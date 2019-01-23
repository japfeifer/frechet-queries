% this function splits one cluster into two clusters and recursively calls
% itself until cluster sizes are reduced to one trajectory at leaf nodes

function SplitNode(cNodeID,tDistList)

    % global variables
    global numCFD numDP clusterNode clusterTrajNode currNodeID trajData totNode h 
    global numTrajCheck doDFD

    % initialize variables
    pDistList = [];
    nDistList = [];
    sPrev = 0;
    sNew = 0;
    k = 0;
    currTrajID = 0;
    newCenterDist = 0;
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
    centerToCenterDist = clusterNode(cNodeID,4);

    % determine what center each traj in the cluster is closest to
    for k = 1:size(tDistList,1) 
        currTrajID = tDistList(k,1);
        if currTrajID == prevCenterTrajID % save prev center
            pDistList = [pDistList; prevCenterTrajID 0];
        elseif currTrajID == newCenterTrajID % save new center
            nDistList = [nDistList; newCenterTrajID 0];
        else
            % use a series of upper/lower bounds to check if traj belongs to prev or new center
            pCenter = 0; nCenter = 0; foundCenter = 0; newCenterDist = 0; 
            nTraj = cell2mat(trajData(newCenterTrajID,1)); % new center traj
            cTraj = cell2mat(trajData(currTrajID,1)); % curr traj
            cDist = tDistList(k,2);
            numTrajCheck = numTrajCheck + 1;
            
            % use triangle inequality comparing distance from old center to
            % new center
            if foundCenter == 0
                if cDist <= centerToCenterDist/2
                    % traj is definitely closer to prev center
                    pCenter = 1;
                    foundCenter = 1;
                end
            end
            
            % Compare known distance (curr traj to prev center traj) to best 
            % up/low bound dist (curr traj to new center traj)
            if foundCenter == 0
                UpBnd = GetBestUpperBound(nTraj,cTraj,2,newCenterTrajID,currTrajID);
                LowBnd = GetBestLowerBound(nTraj,cTraj,cDist,2,newCenterTrajID,currTrajID);
                if cDist <= LowBnd % prev center is closer
                    pCenter = 1;
                    foundCenter = 1;
                elseif cDist >= UpBnd % new center is closer
                    nCenter = 1;
                    foundCenter = 1;
                end
            end

            % at this point we have to do some quadratic calcs
            if foundCenter == 0 || nCenter == 1
                if nCenter ~= 1 % do frechet decision proc if not the new center
                    decResult = FrechetDecide(cTraj,nTraj,cDist,1);
                    numDP = numDP + 1;
                else
                    decResult = 1;
                end
                if decResult == 1 % new center
                    nCenter = 1;
                    if UpBnd == LowBnd % already know the dist, don't do frechet dist call
                        newCenterDist = UpBnd;
                    else
                        if doDFD == true
                            newCenterDist = DiscreteFrechetDist(cTraj,nTraj);
                        else
                            newCenterDist = ContFrechet(cTraj,nTraj);
                        end
                        numCFD = numCFD + 1;
                    end
                else % old center
                    pCenter = 1;
                end
            end

            if nCenter == 1
                % closer to new center
                nDistList = [nDistList; currTrajID newCenterDist];
            else
                % closer to prev center
                pDistList = [pDistList; currTrajID cDist];
            end
    
        end               
    end

    % get sizes of prev and new clusters
    sPrev = size(pDistList,1);
    sNew = size(nDistList,1);

    % get max Rsize and associated traj ID for prev cluster
    [pLargestRSize,pTmpIndex] = max(pDistList(:,2));
    pFurthestTrajID = pDistList(pTmpIndex,1);
    
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

    % get max Rsize and associated traj ID for new cluster
    [nLargestRSize,nTmpIndex] = max(nDistList(:,2));
    nFurthestTrajID = nDistList(nTmpIndex,1);

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
        SplitNode(pNodeID,pDistList);
    end
    
    if sNew > 1
        SplitNode(nNodeID,nDistList);
    end

end