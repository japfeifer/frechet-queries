

function GetLowestLB(cNodeID,Q,Qid,lowBnd,upBnd)

    global clusterNode prunedNodes nodeCheckCnt trajData
    global currBestLowNodeDist stopCheckNodes Emin nextNodeList

    if stopCheckNodes == false
        
        % see if we have found a close enough node
        if upBnd <= Emin % we have found a NN within the approximation threshold
            prunedNodes = [cNodeID lowBnd upBnd];
            currBestLowNodeDist = lowBnd;
            stopCheckNodes = true;
            return
        end

        cRad = clusterNode(cNodeID,4);
        
        if (clusterNode(cNodeID,5) == 1) % at the leaf
            
            if lowBnd < currBestLowNodeDist
                if isempty(prunedNodes) == false
                    nextNodeList = [nextNodeList; prunedNodes];
                end
                prunedNodes = [cNodeID lowBnd upBnd];
                currBestLowNodeDist = lowBnd;
            else
                nextNodeList = [nextNodeList; cNodeID lowBnd upBnd];
            end
        elseif currBestLowNodeDist > lowBnd - cRad + Emin % the node may contain a traj that is closer
            
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
                GetLowestLB(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
                nodeCheckCnt = nodeCheckCnt + 1;
                GetLowestLB(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
            else
                nodeCheckCnt = nodeCheckCnt + 1;
                GetLowestLB(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2);
                nodeCheckCnt = nodeCheckCnt + 1;
                GetLowestLB(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1);
            end
        else
            nextNodeList = [nextNodeList; cNodeID lowBnd upBnd];
        end
    end
end