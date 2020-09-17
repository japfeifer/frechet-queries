
function SplitNodeGonzLite(cNodeID,tDistList)

    % global variables
    global numCFD numDP clusterNode clusterTrajNode currNodeID trajData totNode h numSplitCFD

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
    
    sztDistList = size(tDistList,1);
    pDistList(1:sztDistList,1) = 0;
    pDistList(1:sztDistList,2) = 0;
    pDistList(1:sztDistList,3) = 0;
    pDistList(1:sztDistList,4) = 0;
    nDistList(1:sztDistList,1) = 0;
    nDistList(1:sztDistList,2) = 0;
    nDistList(1:sztDistList,3) = 0;
    nDistList(1:sztDistList,4) = 0;
    nDistCnt = 1;
    pDistCnt = 1;
    prevCenterTrajID = clusterNode(cNodeID,6);
    newCenterTrajID = clusterNode(cNodeID,7);
    centerToCenterDist = clusterNode(cNodeID,4);
    
    pTraj = cell2mat(trajData(prevCenterTrajID,1)); % prev center traj 
    nTraj = cell2mat(trajData(newCenterTrajID,1)); % new center traj 

    % determine what center each traj in the cluster is closest to
    for k = 1:size(tDistList,1) 
        currTrajID = tDistList(k,1);
        if currTrajID == prevCenterTrajID % save prev center
            pDistList(pDistCnt,:) = [prevCenterTrajID 0 0 0];
            pDistCnt = pDistCnt + 1;
        elseif currTrajID == newCenterTrajID % save new center
            nDistList(nDistCnt,:) = [newCenterTrajID 0 0 0];
            nDistCnt = nDistCnt + 1;
        else
            % use a series of upper/lower bounds to check if traj belongs to prev or new center
            pCenter = 0; nCenter = 0; foundCenter = 0; currDist = 0; 

            % get the upper/lower bounds from traj to new and prev center
            cTraj = cell2mat(trajData(currTrajID,1)); % curr traj

            nLowBnd = GetBestConstLB(nTraj,cTraj,Inf,2,newCenterTrajID,currTrajID);
            pLowBnd = tDistList(k,3);
            nUpBnd = GetBestUpperBound(nTraj,cTraj,2,newCenterTrajID,currTrajID,pLowBnd);
            pUpBnd = tDistList(k,4);
            
            if nLowBnd > nUpBnd % this fixes a precision error with the football data
                nLowBnd = round(nLowBnd * 10^9) / 10^9;
                nUpBnd = round(nUpBnd * 10^9) / 10^9;
            end
            
            cDist = tDistList(k,2);
            if cDist == -1 && pLowBnd == pUpBnd 
                cDist = pLowBnd;
            end

            if nUpBnd <= pLowBnd % no overlapping and traj is closer to new center
                foundCenter = 1;
                nCenter = 1;
            elseif pUpBnd <= nLowBnd % no overlapping and traj is closer to prev center
                foundCenter = 1;
                pCenter = 1;
            else % try linear LB checks
                linearLB = GetBestLinearLBDP(pTraj,cTraj,nUpBnd,2,prevCenterTrajID,currTrajID);
                if linearLB == true
                    foundCenter = 1;
                    nCenter = 1;
                else
                    linearLB = GetBestLinearLBDP(nTraj,cTraj,pUpBnd,2,newCenterTrajID,currTrajID);
                    if linearLB == true
                        foundCenter = 1;
                        pCenter = 1;
                    end
                end
            end

            % at this point we may have to do some quadratic calcs
            if foundCenter == 0 
                % get dist from P to previous center

                if cDist == -1
                    cDist = ContFrechet(cTraj,pTraj);
                    pLowBnd = cDist; 
                    pUpBnd = cDist;
                    
                    numCFD = numCFD + 1;
                    numSplitCFD = numSplitCFD + 1;
                end
                
                % use triangle inequality comparing distance from prev center to
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
                    if cDist <= nLowBnd % prev center is closer
                        pCenter = 1;
                        foundCenter = 1;
                    elseif cDist > nUpBnd % new center is closer
                        nCenter = 1;
                        foundCenter = 1;
                    else % finally try linear LB check
                        linearLB = GetBestLinearLBDP(nTraj,cTraj,cDist,2,newCenterTrajID,currTrajID);
                        if linearLB == true % prev center is closer
                            pCenter = 1;
                            foundCenter = 1;
                        end
                    end
                end

                % at this point we have to do more quadratic calcs
                if foundCenter == 0 
                    
                    linearLB = GetBestLinearLBDP(nTraj,cTraj,cDist,2,newCenterTrajID,currTrajID);
                    if linearLB == true
                        pCenter = 1;
                    else
                        decResult = FrechetDecide(cTraj,nTraj,cDist,1);
                        numDP = numDP + 1;
                        if decResult == 1 % new center
                            nCenter = 1;
                        else % old center
                            pCenter = 1;
                        end
                    end
                end
 
            end

            % assign traj to the new or prev center
            if nCenter == 1
                % closer to new center
                newExactDist = -1;
                if nLowBnd == nUpBnd
                    newExactDist = nLowBnd;
                end
                nDistList(nDistCnt,:) = [currTrajID newExactDist nLowBnd nUpBnd];
                nDistCnt = nDistCnt + 1;
            else
                % closer to prev center
                pDistList(pDistCnt,:) = [currTrajID cDist pLowBnd pUpBnd];
                pDistCnt = pDistCnt + 1;
            end
        end               
    end

    % get sizes of prev and new clusters
    sPrev = pDistCnt - 1;
    sNew = nDistCnt - 1;
    pDistList(pDistCnt:end,:) = [];
    nDistList(nDistCnt:end,:) = [];

    % call proc to get max Rsize and associated traj ID for prev cluster
    if size(pDistList,1) > 1
        [pFurthestTrajID,pLargestRSize,pDistList] = GetFurthestTrajGonzLite(prevCenterTrajID,pDistList);
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
        [nFurthestTrajID,nLargestRSize,nDistList] = GetFurthestTrajGonzLite(newCenterTrajID,nDistList);
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
        SplitNodeGonzLite(pNodeID,pDistList);
    end
    
    if sNew > 1
        SplitNodeGonzLite(nNodeID,nDistList);
    end

end