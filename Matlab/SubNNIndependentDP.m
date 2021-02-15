function [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = SubNNIndependentDP(P,Q,decPrec)

    global decimalPrecision
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
    end

    totCellCheck = 0;
    totDPCalls = 0;
    totSPCalls = 0;
    loopCnt = 0;
    bestBndCutPath = [];
    minBnd = 0;

    maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd) + 0.0001;  % think about faster way if P is very large

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

    % P subtrajectory start interior segment point (Pcell and location between [0,1] on cell left edge
    szCut = size(bestBndCutPath,1);
    sP = [bestBndCutPath(szCut,2) bestBndCutPath(szCut,6)];
    % P subtrajectory end interior segment point (Pcell and location between [0,1] on cell right edge
    eP = [bestBndCutPath(1,2) bestBndCutPath(1,4)];
    
end  % function ContFrechet