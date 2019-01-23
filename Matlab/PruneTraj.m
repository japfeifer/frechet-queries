% RNN Pruning
% Called by RNNSearch, RNNSearch2, RNNSearch3
%
% Query the CCT data structure and get an initial result set.


function PruneTraj(Qid)

    global clusterNode prunedNodes nodeCheckCnt queryTraj

    % get pruned nodes
    prunedNodes = [];
    nodeCheckCnt = 0;
    Q = cell2mat(queryTraj(Qid,1));
    
    GetPrunedNodes(1,Q,Qid);
    
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
