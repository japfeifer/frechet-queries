% this function splits one cluster into two clusters and recursively calls
% itself until cluster sizes are reduced to one trajectory at leaf nodes

function SplitNodeApproxRadii(cNodeID,tDistList)

    % global variables
    global clusterNode clusterTrajNode currNodeID trajStrData totNode h 

    % initialize variables
    pDistList = [];
    nDistList = [];
    sPrev = 0;
    sNew = 0;
    k = 0;
    currTrajID = 0;
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
    nDistList(1:sztDistList,1) = 0;
    nDistList(1:sztDistList,2) = 0;
    nDistCnt = 1;
    pDistCnt = 1;
    prevCenterTrajID = clusterNode(cNodeID,6);
    pTraj = trajStrData(prevCenterTrajID); % prev center traj
    newCenterTrajID = clusterNode(cNodeID,7);
    nTraj = trajStrData(newCenterTrajID); % new center traj

    % determine what center each traj in the cluster is closest to
    for k = 1:sztDistList 
        currTrajID = tDistList(k,1);
        if currTrajID == prevCenterTrajID % save prev center
            pDistList(pDistCnt,:) = [prevCenterTrajID 0];
            pDistCnt = pDistCnt + 1;
        elseif currTrajID == newCenterTrajID % save new center
            nDistList(nDistCnt,:) = [newCenterTrajID 0];
            nDistCnt = nDistCnt + 1;
        else
            cTraj = trajStrData(currTrajID).traj; % curr traj
            UpBndNew = GetBestUpperBound(nTraj,cTraj,2,newCenterTrajID,currTrajID);
            UpBndPrev =  tDistList(k,2); % we computed and stored the UB already for prev centre 

            if UpBndNew < UpBndPrev % closer to new center
                nDistList(nDistCnt,:) = [currTrajID UpBndNew];
                nDistCnt = nDistCnt + 1;
            else % closer to prev center
                pDistList(pDistCnt,:) = [currTrajID UpBndPrev];
                pDistCnt = pDistCnt + 1;
            end
        end               
    end

    % get sizes of prev and new clusters
    sPrev = pDistCnt - 1;
    sNew = nDistCnt - 1;
    pDistList(pDistCnt:end,:) = [];
    nDistList(nDistCnt:end,:) = [];

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
        X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode)];
        waitbar(currNodeID/totNode, h, X);
    end

    % recursively call SplitNode for clusters that have two or more traj
    if sPrev > 1
        SplitNodeApproxRadii(pNodeID,pDistList);
    end
    
    if sNew > 1
        SplitNodeApproxRadii(nNodeID,nDistList);
    end

end