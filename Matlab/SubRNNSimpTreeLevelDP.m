function [totCellCheck,totDPCalls,totSPVert,sP,eP] = SubRNNSimpTreeLevelDP(Q,alpha,level,sVertList,eVertList)

    global inpTrajVert inpTrajErr inP
    
    if size(sVertList,1)  == 0
        error('variable sVertList is empty');
    end

    totCellCheck = 0;
    totDPCalls = 0;
    totSPVert = 0;

    errDist = alpha + (2*inpTrajErr(level));

    % determine new list of candidate sub-traj
    sP = []; eP = []; numRes = 1;
    for i = 1:size(sVertList,1) % search each candidate sub-traj
        P = inP(inpTrajVert(sVertList(i,1):eVertList(i,1),level) , :); % compute P sub-traj coordinates from level,sVertList,eVertList
        startPtsVertList = GetFreespaceStartPts(P,Q,errDist); % get the start points on freespace diagram right edge
        totSPVert = totSPVert + size(P,1);
        sz = size(startPtsVertList,1);
        idxOffset = sVertList(i,1) - 1;
        if sz > 0 % there is at least one freespace interval on freespace diagram right edge
            for j = 1:sz % for each freespace interval
                [ans,numCellCheck,boundCutPath] = FrechetDecideSubTraj(P,Q,errDist,startPtsVertList(j,1),startPtsVertList(j,2));
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

end  % function ContFrechetSubTraj2