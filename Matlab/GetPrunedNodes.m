% Get Pruned Nodes for RNN search.
% 
% Find all trajetories where their lower bound < range value (Emax)
% Only have to search clusters where the node traj centre lower bound <=
% Emax + node radius.

function GetPrunedNodes(cNodeID,Q,Qid)

    global clusterNode Emax prunedNodes nodeCheckCnt trajData

    nodeCheckCnt = nodeCheckCnt + 1;
    centerTrajID = clusterNode(cNodeID,6);
    cRad = clusterNode(cNodeID,4);
    centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
    lowBnd = GetBestLowerBound(centreTraj,Q,Emax+cRad,1,centerTrajID,Qid);
    if lowBnd <= Emax && (clusterNode(cNodeID,5) == 1)% at leaf and Q is close enough to centre
        upBnd = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
        prunedNodes = [prunedNodes; cNodeID lowBnd upBnd];
    elseif lowBnd <= Emax + cRad && ... % some of the cluster may be in results
           clusterNode(cNodeID,5) > 1 % only process if there are more children
        GetPrunedNodes(clusterNode(cNodeID,2),Q,Qid);
        GetPrunedNodes(clusterNode(cNodeID,3),Q,Qid);
    end
end