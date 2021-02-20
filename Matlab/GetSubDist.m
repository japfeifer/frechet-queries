


function [lowBnd,upBnd,totCellCheck,totDPCalls,totSPVert,sP,eP] = GetSubDist(P,Q,Pid,Qid,numIter,decPrec)

    global decimalPrecision

    switch nargin
    case 2
        Qid = 0;
        Pid = 0;
        numIter = Inf;
        decPrec = decimalPrecision;
    case 4
        numIter = Inf;
        decPrec = decimalPrecision;
    case 5
        decPrec = decimalPrecision;
    end
    
    if Qid == 0
        cType = 0;
    else
        cType = 1;
    end
    totCellCheck = 0;
    totDPCalls = 0;
    totSPVert = 0;
    loopCnt = 0;
    minBnd = 0;
    bestBndCutPath = [];

    % find a max bound 
    maxBnd = GetBestUpperBound(Q,P,cType,Qid,Pid) + 0.000001;  
%     maxBnd = GetBestUpperBound(Q,P,0,0,0) + 0.000001; 

    while 1 == 1 % stop when condition is reached
        currLen = (minBnd + maxBnd) / 2; % get leash length to test
        ans = 0;
        startPtsVertList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
        totSPVert = totSPVert + size(P,1);
        sz = size(startPtsVertList,1);
        if sz > 0 % there is at least one freespace interval on freespace diagram right edge
            for j = 1:sz % for each freespace interval
                [ans,numCellCheck,boundCutPath] = FrechetDecideSubTraj(P,Q,currLen,startPtsVertList(j,1),startPtsVertList(j,2));
                totDPCalls = totDPCalls + 1;
                totCellCheck = totCellCheck + numCellCheck;
                if ans == 1
                    break
                end
            end
        end
        if ans == 1
            maxBnd = currLen;
            bestBndCutPath = boundCutPath;
        else
            minBnd = currLen;
        end
        loopCnt = loopCnt + 1;
        if maxBnd - minBnd < decPrec % precision reached so stop
            break
        end
        if loopCnt >= numIter % we can stop as we have reached the specified number of iterations
            break
        end
        if loopCnt > 1000
            error('Too many loops in GetSubDist'); 
        end
    end

    lowBnd = minBnd;
    upBnd = maxBnd;
    
    % P subtrajectory start interior segment point (Pcell and location between [0,1] on cell left edge
    szCut = size(bestBndCutPath,1);
    if szCut > 0
        sP = [bestBndCutPath(szCut,2) bestBndCutPath(szCut,6)];
        % P subtrajectory end interior segment point (Pcell and location between [0,1] on cell right edge
        eP = [bestBndCutPath(1,2) bestBndCutPath(1,4)];
    else
        sP = [];
        eP = [];
    end

end