% Get Pruned Nodes for NN search for (1 + epsilon) approximation.
%
% Find the trajectory with the smallest upper bound (SUB) distance compared
% to query Q, and all other trajectories where their lower bound is less 
% than SUB.  The (1 + epsilon) approximation algo does not yet know what 
% the aprroximation epsilon (Emin) is, so this function does not use EMin
% (as opposed to GetPrunedNodes2 which knows Emin ahead of time and can
% utilize it).

function GetPrunedNodes3(cNodeID,Q,Qid,lowBnd,upBnd)

    global clusterNode prunedNodes nodeCheckCnt trajData
    global currBestUpNodeDist currBestLowNodeDist
        
    nodeCheckCnt = nodeCheckCnt + 1;

    cRad = clusterNode(cNodeID,4);

    if (clusterNode(cNodeID,5) == 1)  % at the leaf

        if upBnd < currBestLowNodeDist % this traj centre is definitely closer than all current ones
            prunedNodes = [cNodeID lowBnd upBnd];
        elseif lowBnd <= currBestUpNodeDist
            prunedNodes = [prunedNodes; cNodeID lowBnd upBnd];
        end
        if lowBnd < currBestLowNodeDist
            currBestLowNodeDist = lowBnd;
        end
        if upBnd < currBestUpNodeDist 
            currBestUpNodeDist = upBnd;
        end
    elseif currBestUpNodeDist > lowBnd - cRad % the node may contain a traj that is closer

        cID = clusterNode(cNodeID,2);
        centerTrajID = clusterNode(cID,6);
        % if next child centre traj = curr parent centre traj then do
        % not have to compute it again
        if centerTrajID == clusterNode(cNodeID,6) 
            lowBnd1 = lowBnd;
            upBnd1 = upBnd;
        else
            centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            lowBnd1 = GetBestLowerBound(centreTraj,Q,Inf,1,centerTrajID,Qid);
            upBnd1 = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
        end

        cID = clusterNode(cNodeID,3);
        centerTrajID = clusterNode(cID,6);
        % if next child centre traj = curr parent centre traj then do
        % not have to compute it again
        if centerTrajID == clusterNode(cNodeID,6) 
            lowBnd2 = lowBnd;
            upBnd2 = upBnd;
        else
            centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            lowBnd2 = GetBestLowerBound(centreTraj,Q,Inf,1,centerTrajID,Qid);
            upBnd2 = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
        end

        if lowBnd1 < lowBnd2
            GetPrunedNodes3(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
            GetPrunedNodes3(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
        else
            GetPrunedNodes3(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
            GetPrunedNodes3(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
        end
    end
end