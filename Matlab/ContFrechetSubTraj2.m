function [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = ContFrechetSubTraj2(P,Q,minBnd,decPrec)

    global decimalPrecision
    
    switch nargin
    case 3
        decPrec = decimalPrecision;
    end

    totCellCheck = 0;
    totDPCalls = 0;
    totSPCalls = 0;
    loopCnt = 0;
    bestBndCutPath = [];

    maxBnd = max(GetBestUpperBound(P,Q,0,0,0,minBnd) + 0.0001, minBnd);  % think about faster way if P is very large

    while 1 == 1 % stop when answer precision reached
        currLen = (minBnd + maxBnd) / 2;
        startPtsList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
        totSPCalls = totSPCalls + 1;
        sz = size(startPtsList,1);
        if sz > 0 % there is some freespace on freespace diagram right edge
            ans = 0;
            for i = 1:sz
                [ans,numCellCheck,boundCutPath] = FrechetDecideSubTraj(P,Q,currLen,startPtsList(i,1),startPtsList(i,2));
                totDPCalls = totDPCalls + 1;
                totCellCheck = totCellCheck + numCellCheck;
                if ans == 1
                    break
                end
            end
            if ans == 1
                maxBnd = currLen;
                bestBndCutPath = boundCutPath;
            else
                minBnd = currLen;
            end
            if maxBnd - minBnd < decPrec % precision reached
                break
            end
        else
            minBnd = currLen;
        end
        loopCnt = loopCnt + 1;
        if loopCnt > 1000
            error('Too many loops in ContFrechetSubTraj'); 
        end
    end
    frechetDist = maxBnd; % last distance where ans == 1
    
    % there may be more than one inclusion minimal subpath that is monotone
    sP = []; eP = []; numRes = 1;
    startPtsList = GetFreespaceStartPts(P,Q,frechetDist); % get the start points on freespace diagram right edge
    totSPCalls = totSPCalls + 1;
    sz = size(startPtsList,1);
    if sz > 0 % there is some freespace on freespace diagram right edge
        for i = 1:sz
            [ans,numCellCheck,boundCutPath] = FrechetDecideSubTraj(P,Q,frechetDist,startPtsList(i,1),startPtsList(i,2));
            totDPCalls = totDPCalls + 1;
            totCellCheck = totCellCheck + numCellCheck;
            if ans == 1
                szCut = size(boundCutPath,1);
                sP(numRes,1:2) = [boundCutPath(szCut,2) boundCutPath(szCut,6)];
                eP(numRes,1:2) = [boundCutPath(1,2) boundCutPath(1,6)];
                numRes = numRes + 1;
            end
        end
    end
    
    % check if any "overlap"
        
    % run with P in reverse to get inclusion minimal subpath from start of sub-traj

end  % function ContFrechet