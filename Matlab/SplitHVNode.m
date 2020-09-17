% this function splits one cluster into two clusters and recursively calls
% itself until cluster sizes are reduced to one point at leaf nodes

function SplitHVNode(cNodeID,tDistList)

    % global variables
    global clusterHVNode clusterHVNodeToID currNodeID totNode h trajHyperVector

    % initialize variables
    pDistList = [];
    nDistList = [];
    sPrev = 0;
    sNew = 0;
    currID = 0;
    newCenterDist = 0;
    pSmallestCosDist = 0;
    nSmallestCosDist = 0;
    pTmpIndex = 0;
    nTmpIndex = 0;
    pFurthestID = 0;
    nFurthestID = 0;
    pNodeID = 0;
    nNodeID = 0;
    
    prevCenterID = clusterHVNode(cNodeID,6);
    newCenterID = clusterHVNode(cNodeID,7);
    centerToCenterDist = clusterHVNode(cNodeID,4);

    % determine what center each point in the cluster is closest to
    for k = 1:size(tDistList,1) 
        currID = tDistList(k,1);
        if currID == prevCenterID % save prev center
            pDistList = [pDistList; prevCenterID 1];
        elseif currID == newCenterID % save new center
            nDistList = [nDistList; newCenterID 1];
        else
            cDist = tDistList(k,2);
            
            % get dist to new centre
            newCenterDist = VectorCosDist(trajHyperVector(newCenterID,:), trajHyperVector(currID,:));
            if newCenterDist < cDist % closer to prev center
                pDistList = [pDistList; currID cDist];
            else % closer to new centre
                nDistList = [nDistList; currID newCenterDist];
            end

        end               
    end

    % get sizes of prev and new clusters
    sPrev = size(pDistList,1);
    sNew = size(nDistList,1);

    % get min COS distance and associated point ID for prev cluster
    [pSmallestCosDist,pTmpIndex] = min(pDistList(:,2));
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
    clusterHVNode(pNodeID,:) = [cNodeID 0 0 pSmallestCosDist sPrev prevCenterID pFurthestID];

    % get min COS distance and associated point ID for new cluster
    [nSmallestCosDist,nTmpIndex] = min(nDistList(:,2));
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
    clusterHVNode(nNodeID,:) = [cNodeID 0 0 nSmallestCosDist sNew newCenterID nFurthestID];
    
    % update parent node to point to two new child nodes
    clusterHVNode(cNodeID,2) = pNodeID;  % node child 1 ID
    clusterHVNode(cNodeID,3) = nNodeID;  % node child 2 ID
    
    % if prev or new clusters are comprised of one points then update
    % clusterHVNodeToID table to point to their leaf node
    if sPrev == 1
        clusterHVNodeToID(prevCenterID,1) = pNodeID;
    end
    
    if sNew == 1
        clusterHVNodeToID(newCenterID,1) = nNodeID;
    end
    
    if mod(currNodeID,101) == 0
        X = ['Construct HV CCT ',num2str(currNodeID),'/',num2str(totNode)];
        waitbar(currNodeID/totNode, h, X);
    end

    % recursively call SplitPointNode for clusters that have two or more points
    if sPrev > 1
        SplitHVNode(pNodeID,pDistList);
    end
    
    if sNew > 1
        SplitHVNode(nNodeID,nDistList);
    end

end