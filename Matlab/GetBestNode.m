% find the highest node for a given trajectory that is less than or equal to Emin

function cNodeID = GetBestNode(cTrajID, cEmin)

    global clusterTrajNode clusterNode
    
    % local variables
    foundNode = false;
    parentNodeID = 0;
    parentRSize = 0;

    % get the leaf node ID for the trajectory

    cNodeID = clusterTrajNode(cTrajID,1);

    while foundNode == false
        parentNodeID = clusterNode(cNodeID,1);
        parentRSize = clusterNode(parentNodeID,4);
        if parentRSize <= cEmin % parent node is still less than Emin
            cNodeID = parentNodeID;
            if clusterNode(parentNodeID,1) == 0  % there are no more higher parents
                foundNode = true;
            end
        else  % parent node is greater than Emin so stop searching
            foundNode = true;
        end
    end
end