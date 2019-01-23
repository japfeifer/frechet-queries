% this function is sent a node ID and finds all leaf traj ID's beneath the
% node

function GetNodeLeafTraj(cNodeID)
    
    global leafTrajIDList clusterNode

    if clusterNode(cNodeID,5) == 1 % it's a child node
        leafTrajIDList = [leafTrajIDList; clusterNode(cNodeID,6)];
    else % it's a parent node, so recursively call children nodes
        GetNodeLeafTraj(clusterNode(cNodeID,2));
        GetNodeLeafTraj(clusterNode(cNodeID,3));
    end

end