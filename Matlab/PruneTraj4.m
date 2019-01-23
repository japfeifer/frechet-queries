% kNN pruning
% PruneTraj gets pruned nodes and associated leaf trajectories, and stores
% results in queryTraj

function PruneTraj4(Qid,kNum)

    global clusterNode prunedNodes nodeCheckCnt trajData leafTrajIDList queryTraj
    global prevLowestUpBnd currBestUpNodeDist currBestLowNodeDist

    tmpPrunedNodes = [];
    nodeCheckCnt = 0;
    Q = cell2mat(queryTraj(Qid,1));
    prevLowestUpBnd = -1;
    prunedTraj = [];
    currNumTraj = 0;
    largestUB = 0;

    centerTrajID = clusterNode(1,6); % root node centre traj id
    centreTraj = cell2mat(trajData(centerTrajID,1)); % root node centre traj
    lowBnd = GetBestLowerBound(centreTraj,Q,Inf,1,centerTrajID,Qid);
    upBnd = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
    
    while currNumTraj < kNum
        
        % get pruned node leafs
        prunedNodes = [];
        currBestLowNodeDist = Inf;
        currBestUpNodeDist = Inf;
        
        GetPrunedNodes4(1,Q,Qid,lowBnd,upBnd);
        
        % if there is more than one traj in prunedNodes, then delete traj 
        % in prunedNodes if the traj LB > currBestUpNodeDist
        if size(prunedNodes,1) > 1
            processPrunedNodes = prunedNodes;
            prunedNodes = [];
            for i=1:size(processPrunedNodes,1)
                if processPrunedNodes(i,2) <= currBestUpNodeDist
                    prunedNodes = [prunedNodes; processPrunedNodes(i,:)];
                end
            end
        end

        % compute the current largest UB of all pruning results
        largestUB = max(max(prunedNodes(:,3)), largestUB);
        
        prevLowestUpBnd = currBestUpNodeDist;

        currNumTraj = currNumTraj + size(prunedNodes,1);
        tmpPrunedNodes = [tmpPrunedNodes; prunedNodes];
    end

    % get all traj where LB > prevLowestUpBnd and LB <= largestUB
    prunedNodes = [];
    GetPrunedNodes5(1,Q,Qid,lowBnd,upBnd,largestUB);
    tmpPrunedNodes = [tmpPrunedNodes; prunedNodes];

    % convert nodes to corresponding trajectories
    for i=1:size(tmpPrunedNodes,1)
        leafTrajIDList = [];
        GetNodeLeafTraj(tmpPrunedNodes(i,1));
        prunedTraj = [prunedTraj; leafTrajIDList tmpPrunedNodes(i,2) tmpPrunedNodes(i,3)];
    end
    
    % save results in queryTraj
    queryTraj(Qid,3) = mat2cell(tmpPrunedNodes,size(tmpPrunedNodes,1),size(tmpPrunedNodes,2));
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,5) = num2cell(size(tmpPrunedNodes,1));
    queryTraj(Qid,7) = mat2cell(prunedTraj,size(prunedTraj,1),size(prunedTraj,2));
    
end
