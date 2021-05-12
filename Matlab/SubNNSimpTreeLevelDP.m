function [lowBnd,upBnd,totCellCheck,totDPCalls,totSPVert,totUBVert,sP,eP,timeUB,timeSP,timeDP,errDist,subtrajSz] = ...
    SubNNSimpTreeLevelDP(Q,level,sVertList,eVertList,maxLoop,doSubTrajSz,maxBnd,decPrec)

    global decimalPrecision inpTrajVert inpTrajErr inP
    
    switch nargin
    case 5
        doSubTrajSz = 0;
        maxBnd = 0;
        decPrec = decimalPrecision;
    case 6
        maxBnd = 0;
        decPrec = decimalPrecision;
    case 7
        decPrec = decimalPrecision;
    end
    
    if size(sVertList,1)  == 0
        error('variable sVertList is empty');
    end

    totCellCheck = 0;
    totDPCalls = 0;
    totSPVert = 0;
    totUBVert = 0;
    loopCnt = 0;
    minBnd = 0;
    timeUB = 0;
    timeSP = 0;
    timeDP = 0;
    ansEqOneFlg = 0;
    subtrajSz = [];

    % find a max bound
    if maxBnd == 0
        tUB = tic;
        maxBndList = []; 
        for i = 1:size(sVertList,1)
            P = inP(inpTrajVert(sVertList(i,1):eVertList(i,1),level) , :);
            maxBndList(i) = GetBestUpperBound(P,Q,0,0,0,Inf) + 0.000001;  % set threshBound=Inf, will only check bounding box
            totUBVert = totUBVert + size(P,1);
        end
        maxBnd = max([maxBndList]);
        timeUB = toc(tUB);
    else
        timeUB = 0;
    end
    
    if doSubTrajSz == 1
        for i = 1:size(sVertList,1) % store sub-traj info, cols: level, size, start vertex, end vertex
            subtrajSz(i,1:4) = [level size(sVertList(i,1):eVertList(i,1),2) inpTrajVert(sVertList(i,1),level) inpTrajVert(eVertList(i,1),level)];
        end
    end
 
    while 1 == 1 % stop when answer precision reached

        currLen = (minBnd + maxBnd) / 2; % get leash length to test
        ans = 0;
        for i = 1:size(sVertList,1) % search each candidate sub-traj
            P = inP(inpTrajVert(sVertList(i,1):eVertList(i,1),level) , :); % compute P sub-traj coordinates from level,sVertList,eVertList
            tSP = tic;
            startPtsVertList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
            timeSP = timeSP + toc(tSP);
            totSPVert = totSPVert + size(P,1);
            sz = size(startPtsVertList,1);
            if sz > 0 % there is at least one freespace interval on freespace diagram right edge
                for j = 1:sz % for each freespace interval
                    tDP = tic;
                    [ans,numCellCheck] = FrechetDecideSubTraj(P,Q,currLen,startPtsVertList(j,1),startPtsVertList(j,2));
                    timeDP = timeDP + toc(tDP);
                    totDPCalls = totDPCalls + 1;
                    totCellCheck = totCellCheck + numCellCheck;
                    if ans == 1
                        break
                    end
                end
            end
            if ans == 1
                break
            end
        end
        if ans == 1
            maxBnd = currLen;
            ansEqOneFlg = 1;
        else
            minBnd = currLen;
        end
        if maxBnd - minBnd < decPrec % precision reached
            break
        end
        loopCnt = loopCnt + 1;
        if loopCnt >= maxLoop && ansEqOneFlg == 1 % we can stop searching here
            break
        end
        if loopCnt > 1000
            error('Too many loops in ContFrechetSubTraj'); 
        end
    end

    lowBnd = minBnd;
    upBnd = maxBnd;
%     errDist = upBnd + (2*inpTrajErr(level));
    errDist = upBnd + inpTrajErr(level);

    % determine new list of candidate sub-traj
    sP = []; eP = []; numRes = 1;
    for i = 1:size(sVertList,1) % search each candidate sub-traj
        P = inP(inpTrajVert(sVertList(i,1):eVertList(i,1),level) , :); % compute P sub-traj coordinates from level,sVertList,eVertList
        tSP = tic;
        startPtsVertList = GetFreespaceStartPts(P,Q,errDist); % get the start points on freespace diagram right edge
        timeSP = timeSP + toc(tSP);
        totSPVert = totSPVert + size(P,1);
        sz = size(startPtsVertList,1);
        idxOffset = sVertList(i,1) - 1;
        if sz > 0 % there is at least one freespace interval on freespace diagram right edge
            for j = 1:sz % for each freespace interval
                tDP = tic;
                [ans,numCellCheck,boundCutPath] = FrechetDecideSubTraj(P,Q,errDist,startPtsVertList(j,1),startPtsVertList(j,2));
                timeDP = timeDP + toc(tDP);
                totDPCalls = totDPCalls + 1;
                totCellCheck = totCellCheck + numCellCheck;
                if ans == 1
                    szCut = size(boundCutPath,1);
                    subStart = [boundCutPath(szCut,2)+idxOffset boundCutPath(szCut,6)];
                    subEnd = [boundCutPath(1,2)+idxOffset boundCutPath(1,4)];
                    % we do not want to insert "duplicates", i.e. sub-traj with same endpoint
                    if size(sP,1) == 0 % it is not a "duplicate", insert
                        sP(numRes,1:2) = subStart;
                        eP(numRes,1:2) = subEnd;
                        numRes = numRes + 1;
                    elseif size(sP,1) > 0 && ~(sP(numRes-1,1) == subStart(1) && sP(numRes-1,2) == subStart(2)) % it is not a "duplicate", insert
                        sP(numRes,1:2) = subStart;
                        eP(numRes,1:2) = subEnd;
                        numRes = numRes + 1;
                    end
                end
            end
        end
    end
    if size(sP,1)  == 0
        error('variable sP is empty');
    end

end  % function ContFrechetSubTraj2