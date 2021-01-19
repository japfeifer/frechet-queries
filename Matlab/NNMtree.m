% function NNMtree
% 
% Perform NN query on Qid using the M-tree.
% Perform exact search only using the Frechet distance measure (no bounds are used).

function NNMtree(Qid)

    global S1 nodeCheckCnt queryStrData mTreeRootId numCFD numDP
    global Ak

    S1 = [];
    nodeCheckCnt = 0;
    Ak = Inf;
    bestTrajID = 0;
    numCFD = 0;
    numDP = 0;
    
    % Prune Stage - compute S1 (since we are doing an exact search using Frechet distance, S1 will only contain 1 result)
    Q = queryStrData(Qid).traj; % query vertices
    NNPruneMtree(mTreeRootId,Q,0); % traverse the M-tree starting at the root

    % save results from Prune Stage
    queryStrData(Qid).prunenodecnt = nodeCheckCnt;
    queryStrData(Qid).prunedistcnt = 0;
    queryStrData(Qid).prunes1 = S1;
    queryStrData(Qid).prunes1sz = size(S1,1);
    queryStrData(Qid).reduces1 = S1;
    queryStrData(Qid).reduces1sz = size(S1,1);

    % set the bestTrajID
    bestTrajID = S1(3);

    % save results from Reduce Stage
    queryStrData(Qid).reduces1trajid = S1;
    
    % save results from Decide stage
    queryStrData(Qid).decidecfdcnt = numCFD;
    queryStrData(Qid).decidedpcnt = numDP;
    queryStrData(Qid).decidetrajids = bestTrajID;
    queryStrData(Qid).decidetrajcnt = size(bestTrajID,1);
 
end

