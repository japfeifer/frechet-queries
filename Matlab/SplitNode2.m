% Cluster Centre Tree Algo 2

% This builds the exact same data structure (with all nodes containing the 
% same data) as the Cluster Centre Tree Algo 1 version, except it attempts
% to use upper/lower bounds to figure out the furthest traj in a cluster,
% and upper/lower bounds to assign traj to the new centre or not.

% This algo works better than algo 1, if the bounds are very tight and the 
% traj are relatively far apart from each other.  The only dataset where
% this algo outperforms algo 1 (ie less CFD/FDP calls) is the Cats dataset.

function SplitNode2(cNodeID,tDistList)

    % global variables
    global numCFD numDP clusterNode clusterTrajNode currNodeID trajData totNode h doDFD

    % initialize variables
    pDistList = [];
    nDistList = [];
    sPrev = 0;
    sNew = 0;
    k = 0;
    currTrajID = 0;
    currDist = 0;
    pLargestRSize = 0;
    nLargestRSize = 0;
    pTmpIndex = 0;
    nTmpIndex = 0;
    pFurthestTrajID = 0;
    nFurthestTrajID = 0;
    pNodeID = 0;
    nNodeID = 0;
    
    prevCenterTrajID = clusterNode(cNodeID,6);
    newCenterTrajID = clusterNode(cNodeID,7);
    pTraj = cell2mat(trajData(prevCenterTrajID,1)); % prev center traj 
    nTraj = cell2mat(trajData(newCenterTrajID,1)); % new center traj 

    % determine what center each traj in the cluster is closest to
    for k = 1:size(tDistList,1) 
        currTrajID = tDistList(k,1);
        if currTrajID == prevCenterTrajID % save prev center
            pDistList = [pDistList; prevCenterTrajID];
        elseif currTrajID == newCenterTrajID % save new center
            nDistList = [nDistList; newCenterTrajID];
        else
            % use a series of upper/lower bounds to check if traj belongs to prev or new center
            pCenter = 0; nCenter = 0; foundCenter = 0; currDist = 0; 
            
            % get the upper/lower bounds from traj to new and prev center
            cTraj = cell2mat(trajData(currTrajID,1)); % curr traj
            nUpBnd = GetBestUpperBound(nTraj,cTraj,2,newCenterTrajID,currTrajID);
            pUpBnd = GetBestUpperBound(pTraj,cTraj,2,prevCenterTrajID,currTrajID);
            nLowBnd = GetBestLowerBound(nTraj,cTraj,pUpBnd,2,newCenterTrajID,currTrajID);
            pLowBnd = GetBestLowerBound(pTraj,cTraj,nUpBnd,2,prevCenterTrajID,currTrajID);
            
            if nUpBnd <= pLowBnd % no overlapping and traj is closer to new center
                foundCenter = 1;
                nCenter = 1;
            elseif pUpBnd <= nLowBnd % no overlapping and traj is closer to prev center
                foundCenter = 1;
                pCenter = 1;
            elseif pLowBnd < nUpBnd && pLowBnd > nLowBnd % overlapping, prev Lower bound is within new
                nCenter = 1; % set flag to initially check decision proc on new center
            else
                pCenter = 1; % set flag to initially check decision proc on prev center
            end

            % at this point we have to do some quadratic calcs
            if foundCenter == 0 
                % first do frechet decision proc
                if nCenter == 1
                    decResult = FrechetDecide(cTraj, nTraj, pLowBnd,0);
                else
                    decResult = FrechetDecide(cTraj, pTraj, nLowBnd,0);
                end
                numDP = numDP + 1;

                % if decResult == 1 then we are done, otherwise:
                if decResult ~= 1
                    % now check the frechet dist
                    if nCenter == 1
                        if doDFD == true
                            currDist = DiscreteFrechetDist(cTraj, pTraj);
                        else
                            currDist = ContFrechet(cTraj, pTraj);
                        end
                    else
                        if doDFD == true
                            currDist = DiscreteFrechetDist(cTraj, nTraj);
                        else
                            currDist = ContFrechet(cTraj, nTraj);
                        end
                    end
                    numCFD = numCFD + 1;
                    
                    % and now the frechet decision proc
                    if nCenter == 1
                        decResult = FrechetDecide(cTraj, nTraj, currDist,1);
                        if decResult == 0
                            nCenter = 0;
                            pCenter = 1;
                        end
                    else
                        decResult = FrechetDecide(cTraj, pTraj, currDist,1);
                        if decResult == 0
                            nCenter = 1;
                            pCenter = 0;
                        end
                    end
                    numDP = numDP + 1;
                end
            end

            % assign traj to the new or prev center
            if nCenter == 1
                % closer to new center
                nDistList = [nDistList; currTrajID];
            else
                % closer to prev center
                pDistList = [pDistList; currTrajID];
            end
        end               
    end

    % get sizes of prev and new clusters
    sPrev = size(pDistList,1);
    sNew = size(nDistList,1);

    % call proc to get max Rsize and associated traj ID for prev cluster
    if size(pDistList,1) > 1
        [pFurthestTrajID,pLargestRSize] = GetFurthestTraj(prevCenterTrajID,pDistList);
    else
        pFurthestTrajID = pDistList(1,1);
        pLargestRSize = 0;
    end
    
    % if two or more traj are 0 dist apart, choose a furthest traj id that
    % is different than the center traj id
    if prevCenterTrajID == pFurthestTrajID && sPrev >= 2
        for k = 1:size(pDistList,1)
            if prevCenterTrajID ~= pDistList(k,1)
                pFurthestTrajID = pDistList(k,1);
                break
            end
        end
    end

    % save node info for prev cluster
    currNodeID = currNodeID + 1;
    pNodeID = currNodeID;
    clusterNode(pNodeID,:) = [cNodeID 0 0 pLargestRSize sPrev prevCenterTrajID pFurthestTrajID];

    % call proc to get max Rsize and associated traj ID for prev cluster
    if size(nDistList,1) > 1
        [nFurthestTrajID,nLargestRSize] = GetFurthestTraj(newCenterTrajID,nDistList);
    else
        nFurthestTrajID = nDistList(1,1);
        nLargestRSize = 0;
    end

    % if two or more traj are 0 dist apart, choose a furthest traj id that
    % is different than the center traj id
    if newCenterTrajID == nFurthestTrajID && sNew >= 2
        for k = 1:size(nDistList,1)
            if newCenterTrajID ~= nDistList(k,1)
                nFurthestTrajID = nDistList(k,1);
                break
            end
        end
    end
    
    % save node info for new cluster
    currNodeID = currNodeID + 1;
    nNodeID = currNodeID;
    clusterNode(nNodeID,:) = [cNodeID 0 0 nLargestRSize sNew newCenterTrajID nFurthestTrajID];
    
    % update parent node to point to two new child nodes
    clusterNode(cNodeID,2) = pNodeID;  % node child 1 ID
    clusterNode(cNodeID,3) = nNodeID;  % node child 2 ID
    
    % if prev or new clusters are comprised of one traj then update
    % clusterTrajNode table to point to their leaf node
    if sPrev == 1
        clusterTrajNode(prevCenterTrajID,1) = pNodeID;
    end
    
    if sNew == 1
        clusterTrajNode(newCenterTrajID,1) = nNodeID;
    end
    
    if mod(currNodeID,101) == 0
        X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode), ...
            ' Num CFD: ',num2str(numCFD)];
        waitbar(currNodeID/totNode, h, X);
    end

    % recursively call SplitNode for clusters that have two or more traj
    if sPrev > 1
        SplitNode2(pNodeID,pDistList);
    end
    
    if sNew > 1
        SplitNode2(nNodeID,nDistList);
    end

end