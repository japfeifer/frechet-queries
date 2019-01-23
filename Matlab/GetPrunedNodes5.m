% used in kNNSearch

% search for traj where lowBnd <= largestUB && lowBnd > prevLowestUpBnd

function GetPrunedNodes5(cNodeID,Q,Qid,lowBnd,upBnd,largestUB)

    global clusterNode prunedNodes nodeCheckCnt trajData prevLowestUpBnd

    nodeCheckCnt = nodeCheckCnt + 1;
    cRad = clusterNode(cNodeID,4);

    if (clusterNode(cNodeID,5) == 1) ... % at the leaf

        if lowBnd <= largestUB && lowBnd > prevLowestUpBnd
%             disp(['three, cNodeID:',num2str(cNodeID),', lowBnd:',num2str(lowBnd),', upBnd:',num2str(upBnd)]);
            prunedNodes = [prunedNodes; cNodeID lowBnd upBnd];
        end
    elseif largestUB >= lowBnd - cRad && ...% the node may contain a traj that we want to include
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
            GetPrunedNodes5(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1,largestUB);
            GetPrunedNodes5(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2,largestUB);
        else
            GetPrunedNodes5(clusterNode(cNodeID,3),Q,Qid,lowBnd2,upBnd2,largestUB);
            GetPrunedNodes5(clusterNode(cNodeID,2),Q,Qid,lowBnd1,upBnd1,largestUB);
        end
    end
end