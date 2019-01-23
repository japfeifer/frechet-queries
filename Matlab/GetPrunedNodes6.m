% Get Pruned Nodes for kNN search
%
% Find the trajectory with the smallest upper bound (SUB) distance compared
% to query Q, with a LB > prevLowestUpBnd, and all other trajectories where 
% their lower bound is less than SUB.

function GetPrunedNodes6(cNodeID,Q,Qid,lowBnd,upBnd)

    global clusterNode prunedNodes nodeCheckCnt trajData prevLowestUpBnd
    global currBestUpNodeDist currBestLowNodeDist nextNodeList

    cRad = clusterNode(cNodeID,4);

    if (clusterNode(cNodeID,5) == 1) ... % at the leaf

        if upBnd < currBestLowNodeDist && lowBnd > prevLowestUpBnd % this traj centre is definitely closer than all current ones
            % we must add any potential pruned nodes to nextNodeList as they are now "too far" from the query
            nextNodeList = [nextNodeList; prunedNodes];
            
            prunedNodes = [cNodeID lowBnd upBnd];
            currBestLowNodeDist = lowBnd;
            currBestUpNodeDist = upBnd;
        elseif lowBnd <= currBestUpNodeDist && lowBnd > prevLowestUpBnd
            prunedNodes = [prunedNodes; cNodeID lowBnd upBnd];
            if lowBnd < currBestLowNodeDist
                currBestLowNodeDist = lowBnd;
            end
            if upBnd < currBestUpNodeDist
                currBestUpNodeDist = upBnd;
            end
        else % this leaf node is not close enough - add the node to the nextNodeList
            nextNodeList = [nextNodeList; cNodeID lowBnd upBnd];
        end
    elseif currBestUpNodeDist >= lowBnd - cRad && ...% the node may contain a traj that we want to include
           prevLowestUpBnd < upBnd + cRad

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
            nodeCheckCnt = nodeCheckCnt + 1;
            GetPrunedNodes6(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
            nodeCheckCnt = nodeCheckCnt + 1;
            GetPrunedNodes6(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
        else
            nodeCheckCnt = nodeCheckCnt + 1;
            GetPrunedNodes6(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
            nodeCheckCnt = nodeCheckCnt + 1;
            GetPrunedNodes6(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
        end
    else % this parent node is not close enough - add the node to the nextNodeList
        nextNodeList = [nextNodeList; cNodeID lowBnd upBnd];
    end
end