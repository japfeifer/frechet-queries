% function GetClusterLowerBound gets the tightest lower bound between a new
% trajectory centre and the current trajectory centre 

function lowBnd = GetClusterLowerBound(nTrajID,cTrajID,pTrajID,cRSize,pRSize,pCINum,pHistIter)
    
    global DistMatrix trajStrData clusterCenterIteration clusterRSize clusterHistCenterMap histPrevCenterRSize 
    global distMap trajDistMatrix
    
    % compare nTraj to cTraj
    bestLowBnd = ReadDistMap(nTrajID,cTrajID);
    if isempty(bestLowBnd) == true %if bestLowBnd == -1 % dist is not pre-stored
        nTraj = trajStrData(nTrajID).traj;
        cTraj = trajStrData(cTrajID).traj;
        bestLowBnd = GetBestConstLB(nTraj,cTraj,(2*cRSize)+0.0000001,2,nTrajID,cTrajID);
        if ((bestLowBnd/2) - cRSize) > 0
            lowBnd = bestLowBnd;
            return
        end
    else % we have the exact dist from new C to curr C, so we are done
        lowBnd = bestLowBnd;
        return
    end
    
    % compare pTraj to cTraj
    currLowBnd = ReadDistMap(cTrajID,pTrajID);
    if isempty(currLowBnd) == true %if currLowBnd == -1 % dist is not pre-stored
        pTraj = trajStrData(pTrajID).traj;
        cTraj = trajStrData(cTrajID).traj;
        currLowBnd = GetBestConstLB(pTraj,cTraj,(2*cRSize)+0.0000001,2,nTrajID,cTrajID);
    end
    currLowBnd = currLowBnd - pRSize;
    if currLowBnd > bestLowBnd
        bestLowBnd = currLowBnd;
        if ((bestLowBnd/2) - cRSize) > 0
            lowBnd = bestLowBnd;
            return
        end
    end
    
    currClusterIterNum = cell2mat(clusterCenterIteration(cTrajID,1));
    calcIterNum = max(pCINum,currClusterIterNum) - 1;
    pastIterRSize = cell2mat(clusterRSize(calcIterNum,1));
    lowerBoundClusterDist = pastIterRSize - (2 * pRSize);
    if lowerBoundClusterDist > 0
        currLowBnd = lowerBoundClusterDist + cRSize;
        if currLowBnd > bestLowBnd
            bestLowBnd = currLowBnd;
            if ((bestLowBnd/2) - cRSize) > 0
                lowBnd = bestLowBnd;
                return
            end
        end
    end

    if pHistIter == true
        for i = 1:size(clusterHistCenterMap,2)
            % calc what the hist curr center and prev center were
            cHistTrajID = clusterHistCenterMap(cTrajID,i);
            pHistTrajID = clusterHistCenterMap(pTrajID,i);

            currClusterIterNum = cell2mat(clusterCenterIteration(cHistTrajID,1));
            prevClusterIterNum = cell2mat(clusterCenterIteration(pHistTrajID,1));
            calcIterNum = max(prevClusterIterNum,currClusterIterNum) - 1;
            if calcIterNum > 0
                pastIterRSize = cell2mat(clusterRSize(calcIterNum,1));
                lowerBoundClusterDist = pastIterRSize - (2 * histPrevCenterRSize(i));
                if lowerBoundClusterDist > 0
                    currLowBnd = lowerBoundClusterDist + cRSize;
                    if currLowBnd > bestLowBnd
                        bestLowBnd = currLowBnd;
                        if ((bestLowBnd/2) - cRSize) > 0
                            lowBnd = bestLowBnd;
                            return
                        end
                    end
                end
            end
        end
    end

    % compare nTraj to cTraj, but use an intermediary traj, and search for
    % pre-stored distances
    tmpDistIndx = cell2mat(trajDistMatrix(nTrajID,1));
    for i = 1:size(tmpDistIndx,1)
        otherTrajID = tmpDistIndx(i);
        firstDist = ReadDistMap(nTrajID,otherTrajID);
        secondDist = ReadDistMap(otherTrajID,cTrajID);
        if isempty(secondDist) == false %if (secondDist >= 0) 
            currLowBnd = abs(firstDist - secondDist);
            if currLowBnd > bestLowBnd
                bestLowBnd = currLowBnd;
                if ((bestLowBnd/2) - cRSize) > 0
                    lowBnd = bestLowBnd;
                    return
                end
            end
        end    
    end

    % compare pTraj to cTraj, but use an intermediary traj, and search for
    % pre-stored distances
    tmpDistIndx = cell2mat(trajDistMatrix(pTrajID,1));
    for i = 1:size(tmpDistIndx,1)
        otherTrajID = tmpDistIndx(i);
        firstDist = ReadDistMap(pTrajID,otherTrajID);
        secondDist = ReadDistMap(otherTrajID,cTrajID);
        if isempty(secondDist) == false %if (secondDist >= 0) 
            currLowBnd = abs(firstDist - secondDist) - pRSize;
            if currLowBnd > bestLowBnd
                bestLowBnd = currLowBnd;
                if ((bestLowBnd/2) - cRSize) > 0
                    lowBnd = bestLowBnd;
                    return
                end
            end
        end    
    end
    
    lowBnd = bestLowBnd;
    
end