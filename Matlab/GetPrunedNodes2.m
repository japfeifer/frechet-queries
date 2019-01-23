% Get Pruned Nodes for NN search for absolute value approximation.
% 
% Find the trajectory with the smallest upper bound (SUB) distance compared
% to query Q, and all other trajectories where their lower bound is less 
% than SUB.  The SUB can be epsilon (Emin) further away than the exact SUB.

function GetPrunedNodes2(cNodeID,Q,Qid,lowBnd,upBnd)

    global clusterNode prunedNodes nodeCheckCnt trajData
    global currBestUpNodeDist currBestLowNodeDist stopCheckNodes Emin

    if stopCheckNodes == false
        
        nodeCheckCnt = nodeCheckCnt + 1;

        % see if we have found a close enough node
        if upBnd <= Emin % we have found a NN within the approximation threshold
            prunedNodes = [cNodeID lowBnd upBnd];
            currBestLowNodeDist = lowBnd;
            stopCheckNodes = true;
            return
        end
        
        cRad = clusterNode(cNodeID,4);
        
        if (clusterNode(cNodeID,5) == 1) % at the leaf
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
        elseif currBestUpNodeDist > lowBnd - cRad + Emin % the node may contain a traj that is closer
            
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
                GetPrunedNodes2(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
                GetPrunedNodes2(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
            else
                GetPrunedNodes2(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
                GetPrunedNodes2(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
            end
        end
    end
end