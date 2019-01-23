% this function returns the max depth in the tree for a specific node

function nHeight = GetMaxNodeDepth(cNodeID)

    global clusterNode

    if clusterNode(cNodeID,2) == 0 && clusterNode(cNodeID,3) == 0
        nHeight = 1;  % we are at leaf level so start by returning a 1
    else
        child1Height = GetMaxNodeDepth(clusterNode(cNodeID,2));
        child2Height = GetMaxNodeDepth(clusterNode(cNodeID,3));
        nHeight = 1 + max(child1Height,child2Height);
    end

end



