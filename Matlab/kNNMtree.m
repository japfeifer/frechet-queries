% function kNNMtree
% 
% Perform kNN query on Qid using the M-tree.
% Perform exact search only using the Frechet distance measure (no bounds are used).

function kNNMtree(Qid,kNum)

    global S1 nodeCheckCnt queryTraj mTreeRootId numCFD numDP
    global Bk kUBList

    kUBList = [];
    S1 = [];
    nodeCheckCnt = 0;
    Bk = Inf;
    numCFD = 0;
    numDP = 0;
    
    % Prune Stage - compute S1 (since we are doing an exact search using Frechet distance, S1 will only contain 1 result)
    Q = cell2mat(queryTraj(Qid,1)); % query vertices
    kNNPruneMtree(mTreeRootId,Q,0,kNum); % traverse the M-tree starting at the root

    % save results from Prune Stage
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,6) = num2cell(0);
    queryTraj(Qid,8) = mat2cell(S1,size(S1,1),size(S1,2)); % S1 list (node id)
    queryTraj(Qid,9) = num2cell(size(S1,1)); % |S1|
    
    queryTraj(Qid,3) = mat2cell(S1,size(S1,1),size(S1,2));
    queryTraj(Qid,5) = num2cell(size(S1,1));

    % save results from Reduce Stage
    queryTraj(Qid,7) = mat2cell(S1,size(S1,1),size(S1,2));
    
    % save results from Decide stage
    queryTraj(Qid,10) = num2cell(numCFD);
    queryTraj(Qid,11) = num2cell(numDP);
    queryTraj(Qid,12) = mat2cell(S1,size(S1,1),size(S1,2));
    queryTraj(Qid,13) = num2cell(size(S1,1)); 
 
end

