% NN Pruning
% Called by NNSearch, NNSearch2, NNSearch3
%
% First, query the CCT data structure and get an initial result set. Then,
% potentially delete some traj from this result set based on upper/lower 
% bounds and an approximation epsilon (Emin).

function PruneTraj2(Qid,relApx)

    global clusterNode prunedNodes nodeCheckCnt trajData queryTraj
    global currBestUpNodeDist currBestLowNodeDist stopCheckNodes Emin Eapx

    prunedNodes = [];
    nodeCheckCnt = 0;
    Q = cell2mat(queryTraj(Qid,1));
    stopCheckNodes = false;
    currBestUpNodeDist = Inf;
    currBestLowNodeDist = Inf;
    
    centerTrajID = clusterNode(1,6);
    centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
    lowBnd = GetBestLowerBound(centreTraj,Q,Inf,1,centerTrajID,Qid);
    upBnd = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
    
    % get initial pruned nodes from CCT data structure
    if relApx == 1 % (1 + epsilon) relative approximation version
        GetPrunedNodes3(1,Q,Qid,lowBnd,upBnd);
        Emin = Eapx * currBestLowNodeDist;  % calc Emin
    else
        GetPrunedNodes2(1,Q,Qid,lowBnd,upBnd); % absolute approximation version
    end
    
    % find traj with the smallest UB (SUB).  Search other traj and delete
    % them if their LB + Emin > SUB.
    if size(prunedNodes,1) > 1
        prunedNodes = sortrows(prunedNodes,3,'ascend'); % sort asc by UB
        sUB = prunedNodes(1,3); % smallest UB
        TF1 = prunedNodes(2 : end, 2) + Emin > sUB; % for all but first row, if  LB + Emin > SUB then mark for deletion
        prunedNodes([false; TF1],:) = []; % delete rows - always keep first row
    end
    
    % find traj with largest UB (LUB). search other traj and delete them if
    % their LB + Emin > LUB.
    if size(prunedNodes,1) > 1
        lUB = prunedNodes(end,3); % largest UB - we already sorted asc by UB, so just get last item in list
        TF1 = prunedNodes(1 : end-1, 2) + Emin > lUB; % for all but last row, if LB + Emin > LUB then mark for deletion
        prunedNodes([TF1; false],:) = []; % delete rows - always keep last row
    end

    % get pruned node trajectories
    prunedTraj = [];
    for i=1:size(prunedNodes,1)
        prunedTraj = [prunedTraj; clusterNode(prunedNodes(i,1),6) prunedNodes(i,2) prunedNodes(i,3)];
    end

    % save results in queryTraj
    queryTraj(Qid,3) = mat2cell(prunedNodes,size(prunedNodes,1),size(prunedNodes,2));
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,5) = num2cell(size(prunedNodes,1));
    queryTraj(Qid,7) = mat2cell(prunedTraj,size(prunedTraj,1),size(prunedTraj,2));
    
end
