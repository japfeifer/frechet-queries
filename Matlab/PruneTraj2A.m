% NN Pruning

function PruneTraj2A(Qid,relApx)

    global clusterNode prunedNodes nodeCheckCnt trajData queryTraj
    global currBestUpNodeDist currBestLowNodeDist stopCheckNodes Emin Eapx
    global currNodeList nextNodeList prevLowestUpBnd
    
    prunedNodes = [];
    nodeCheckCnt = 0;
    Q = cell2mat(queryTraj(Qid,1));
    stopCheckNodes = false;
    currBestUpNodeDist = Inf;
    currBestLowNodeDist = Inf;
    tmpPrunedNodes = [];
    
    % get root node
    nodeCheckCnt = nodeCheckCnt + 1;
    centerTrajID = clusterNode(1,6);
    centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
    lowBnd = GetBestLowerBound(centreTraj,Q,Inf,1,centerTrajID,Qid);
    upBnd = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
    currNodeList = [1 lowBnd upBnd];
    
    % get a single traj with the lowest LB
    nextNodeList = [];
    if relApx == 1 % Initially set Emin to 0 for relative approx
        Emin = 0;  
    end 
    GetLowestLB(currNodeList(1,1),Q,Qid,currNodeList(1,2),currNodeList(1,3));
    if relApx == 1 % (1 + epsilon) relative approximation - calc Emin
        Emin = Eapx * prunedNodes(1,2);  % calc Emin: Eapx * Lowest LB
    end    
    lUB = prunedNodes(1,3); % largest Upper Bound
    sLB = prunedNodes(1,2); % smallest Lower Bound
    tmpPrunedNodes = [tmpPrunedNodes; prunedNodes];
    prunedNodes = [];
    cnt1 = nodeCheckCnt;
    
    % get pruned nodes for each node in currNodeList
    prevLowestUpBnd = sLB;
    currNodeList = nextNodeList;
    nextNodeList = [];
    for i=1:size(currNodeList,1)
        GetPrunedNodes8(currNodeList(i,1),Q,Qid,currNodeList(i,2),currNodeList(i,3),lUB - Emin);
    end
    tmpPrunedNodes = [tmpPrunedNodes; prunedNodes];
    prunedNodes = [];
    cnt2 = nodeCheckCnt - cnt1;
    
%     disp(['Qid:',num2str(Qid),'  cnt1:',num2str(cnt1),'  cnt2:',num2str(cnt2)]);

    % find traj with the smallest UB (SUB).  Search other traj and delete
    % them if their LB + Emin > SUB.
    if size(tmpPrunedNodes,1) > 1
        tmpPrunedNodes = sortrows(tmpPrunedNodes,3,'ascend'); % sort asc by UB
        sUB = tmpPrunedNodes(1,3); % smallest UB
        TF1 = tmpPrunedNodes(2 : end, 2) + Emin > sUB; % for all but first row, if  LB + Emin > SUB then mark for deletion
        tmpPrunedNodes([false; TF1],:) = []; % delete rows - always keep first row
    end
    
    % find traj with largest UB (LUB). search other traj and delete them if
    % their LB + Emin > LUB.
    if size(tmpPrunedNodes,1) > 1
        lUB = tmpPrunedNodes(end,3); % largest UB - we already sorted asc by UB, so just get last item in list
        TF1 = tmpPrunedNodes(1 : end-1, 2) + Emin > lUB; % for all but last row, if LB + Emin > LUB then mark for deletion
        tmpPrunedNodes([TF1; false],:) = []; % delete rows - always keep last row
    end

    % get pruned node trajectories
    prunedTraj = [];
    for i=1:size(tmpPrunedNodes,1)
        prunedTraj = [prunedTraj; clusterNode(tmpPrunedNodes(i,1),6) tmpPrunedNodes(i,2) tmpPrunedNodes(i,3)];
    end

    % save results in queryTraj
    queryTraj(Qid,3) = mat2cell(tmpPrunedNodes,size(tmpPrunedNodes,1),size(tmpPrunedNodes,2));
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,5) = num2cell(size(tmpPrunedNodes,1));
    queryTraj(Qid,7) = mat2cell(prunedTraj,size(prunedTraj,1),size(prunedTraj,2));
    
end

