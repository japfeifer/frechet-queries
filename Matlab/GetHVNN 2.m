
function GetHVNN(cNodeID,centreCosDist)

    global currBestCosDist currBestNodeID QV

        if isempty(centreCosDist) == true
            
        end

        if (clusterNode(cNodeID,5) == 1) % at the leaf
            if centreCosDist > currBestCosDist % this traj centre is definitely closer than all current ones
                currBestNodeID = cNodeID;
                currBestCosDist = centreCosDist;
            end


        elseif currBestCosDist < centreCosDist % the node may contain a traj that is closer
            
            cID = clusterNode(cNodeID,2);
            centerTrajID = clusterNode(cID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if centerTrajID == clusterNode(cNodeID,6)
                lowBnd1 = lowBnd;
                upBnd1 = upBnd;
            else
                centreTraj = trajStrData(centerTrajID).traj; % get center traj 
                lowBnd1 = GetBestConstLB(centreTraj,Q,Inf,1,centerTrajID,Qid);
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
                centreTraj = trajStrData(centerTrajID).traj; % get center traj 
                lowBnd2 = GetBestConstLB(centreTraj,Q,Inf,1,centerTrajID,Qid);
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