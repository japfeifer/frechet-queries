% this function splits one cluster into two clusters and recursively calls
% itself until cluster sizes are reduced to one point at leaf nodes

function SplitPointNode(cNodeID,tDistList)

    % global variables
    global clusterPointNode clusterPointNodeToID currNodeID totNode h randPts randPtsBallRad

    % initialize variables
    pDistList = [];
    nDistList = [];
    sPrev = 0;
    sNew = 0;
    currID = 0;
    newCenterDist = 0;
    pLargestRSize = 0;
    nLargestRSize = 0;
    pTmpIndex = 0;
    nTmpIndex = 0;
    pFurthestID = 0;
    nFurthestID = 0;
    pNodeID = 0;
    nNodeID = 0;
    
    prevCenterID = clusterPointNode(cNodeID,6);
    newCenterID = clusterPointNode(cNodeID,7);

    % determine what center each point in the cluster is closest to
    for k = 1:size(tDistList,1) 
        currID = tDistList(k,1);
        if currID == prevCenterID % save prev center
            pDistList = [pDistList; prevCenterID randPtsBallRad(prevCenterID)];
        elseif currID == newCenterID % save new center
            nDistList = [nDistList; newCenterID randPtsBallRad(newCenterID)];
        else
            cDist = tDistList(k,2);
            newCenterDist = CalcPointDist(randPts(newCenterID,:), randPts(currID,:)) + randPtsBallRad(newCenterID);
            if newCenterDist > cDist % closer to prev center
                pDistList = [pDistList; currID cDist];
            else % closer to new centre
                nDistList = [nDistList; currID newCenterDist];
            end
        end               
    end

    % get sizes of prev and new clusters
    sPrev = size(pDistList,1);
    sNew = size(nDistList,1);

    % get max Rsize and associated point ID for prev cluster
    [pLargestRSize,pTmpIndex] = max(pDistList(:,2));
    pFurthestID = pDistList(pTmpIndex,1);
    
    % if two or more points are 0 dist apart, choose a furthest point id that
    % is different than the center point id
    if prevCenterID == pFurthestID && sPrev >= 2
        for k = 1:size(pDistList,1)
            if prevCenterID ~= pDistList(k,1)
                pFurthestID = pDistList(k,1);
                break
            end
        end
    end

    % save node info for prev cluster
    currNodeID = currNodeID + 1;
    pNodeID = currNodeID;
    clusterPointNode(pNodeID,:) = [cNodeID 0 0 pLargestRSize sPrev prevCenterID pFurthestID];

    % get max Rsize and associated point ID for new cluster
    [nLargestRSize,nTmpIndex] = max(nDistList(:,2));
    nFurthestID = nDistList(nTmpIndex,1);

    % if two or more points are 0 dist apart, choose a furthest point id that
    % is different than the center point id
    if newCenterID == nFurthestID && sNew >= 2
        for k = 1:size(nDistList,1)
            if newCenterID ~= nDistList(k,1)
                nFurthestID = nDistList(k,1);
                break
            end
        end
    end
    
    % save node info for new cluster
    currNodeID = currNodeID + 1;
    nNodeID = currNodeID;
    clusterPointNode(nNodeID,:) = [cNodeID 0 0 nLargestRSize sNew newCenterID nFurthestID];
    
    % update parent node to point to two new child nodes
    clusterPointNode(cNodeID,2) = pNodeID;  % node child 1 ID
    clusterPointNode(cNodeID,3) = nNodeID;  % node child 2 ID
    
    % if prev or new clusters are comprised of one points then update
    % clusterPointNodeToID table to point to their leaf node
    if sPrev == 1
        clusterPointNodeToID(prevCenterID,1) = pNodeID;
    end
    
    if sNew == 1
        clusterPointNodeToID(newCenterID,1) = nNodeID;
    end
    
    if mod(currNodeID,101) == 0
        X = ['Build Point CCT ',num2str(currNodeID),'/',num2str(totNode)];
        waitbar(currNodeID/totNode, h, X);
    end

    % recursively call SplitPointNode for clusters that have two or more points
    if sPrev > 1
        SplitPointNode(pNodeID,pDistList);
    end
    
    if sNew > 1
        SplitPointNode(nNodeID,nDistList);
    end

end