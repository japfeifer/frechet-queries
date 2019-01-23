% Calculate the average height of tree

tic;
totNodeCnt = 0;
maxNodeCnt = 0;
trajSz = size(trajData,1);

for i = 1:trajSz % calc height for each traj

    % get leaf node
    cNodeID = clusterTrajNode(i,1);
    
    foundTop = false;
    nodeCnt = 1;
    pNodeID = clusterNode(cNodeID,1);
    
    while foundTop == false
        if pNodeID == 0 % top parent
            foundTop = true;
        else
            pNodeID = clusterNode(pNodeID,1);
            nodeCnt = nodeCnt + 1;
        end
    end
    
    maxNodeCnt = max(maxNodeCnt,nodeCnt);
    totNodeCnt = totNodeCnt + nodeCnt;
    
end

avgNodeHeight = totNodeCnt/size(trajData,1);
disp(['-------------------']);
disp(['Avg Depth: ',num2str(ceil(avgNodeHeight))]);
disp(['Max Depth: ',num2str(maxNodeCnt)]);
disp(['Optimal Depth: ',num2str(ceil(log2(size(trajData,1))))]);

