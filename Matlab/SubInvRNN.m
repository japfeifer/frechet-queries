% function SubInvNN
% 
% Perform Sub-traj Inverse NN query on Qid
% typeQ: 1 Additive, 2 Multiplicative, 3 Implicit
% Three stages: Prune, Reduce, Decide

function SubInvRNN(Qid,tau,typeQ,eVal,stage)

    global clusterNode S1 nodeCheckCnt distCalcCnt
    global trajStrData queryStrData
    global sCellCheck sDPCalls sSPVert

    switch nargin
    case 2
        typeQ = 1;
        eVal = 0;
        stage = 3;
    case 4
        stage = 3;
    end

    tSearch = tic;
    
    sCellCheck = 0;
    sDPCalls = 0;
    sSPVert = 0;
    
    S1 = [];
    nodeCheckCnt = 0;
    distCalcCnt = 0;
    
    rangeTrajList = [];
    eAddImplicit = 0;
    eMultImplicit = 0;

    Q = queryStrData(Qid).traj; % query vertices
    
    % Prune Stage - compute S1
    
    if typeQ == 1 % additive error
        eAdd = eVal;
    else
        eAdd = 0;
    end
    
    SubInvRNNPrune(1,tau,Q,Qid); % traverse the CCT

    if typeQ == 2 % multiplicative error
        eAdd = eVal * Ak;
    end
    
    % save results from Prune Stage
    queryStrData(Qid).prunenodecnt = nodeCheckCnt;
    queryStrData(Qid).prunedistcnt = distCalcCnt;
    queryStrData(Qid).prunes1 = S1;
    queryStrData(Qid).prunes1sz = size(S1,1);
    
    if stage >= 2
        % Reduce Stage - compute S2 (and maybe result set)

        % save results from Reduce Stage
        queryStrData(Qid).reduces1 = S1;
        queryStrData(Qid).reduces1sz = size(S1,1);

        % get pruned node trajectories
        for i=1:size(S1,1)
            S1(i,1) = clusterNode(S1(i,1),6);
        end

        % save results from Reduce Stage
        queryStrData(Qid).reduces1trajid = S1;
    end
    
    rangeTrajList = S1;
        
    timeSearch = toc(tSearch);
    
    numWorst = 0;
    for i = 1:size(trajStrData,2)
        P = trajStrData(i).traj;
        numWorst = numWorst + (size(P,1) * size(Q,1));
    end

    % save results from decide stage
    queryStrData(Qid).decidecfdcnt = 0;
    queryStrData(Qid).decidedpcnt = 0;
    queryStrData(Qid).decidetrajids = rangeTrajList(:,1);
    queryStrData(Qid).decidetrajcnt = size(rangeTrajList,1);
    if typeQ == 3
        queryStrData(Qid).decideeadd = eAddImplicit;
        queryStrData(Qid).decideemult = eMultImplicit;
    end
        
    lowBndList = []; upBndList = []; sPList = []; ePList = []; 
    for i = 1:size(rangeTrajList,1)
        currTrajID = rangeTrajList(i,1);
        currTraj = trajStrData(currTrajID).traj; % get center traj 
        [lowBnd,upBnd,totCellCheck,totDPCalls,totSPVert,sP,eP] = GetSubDist(Q,currTraj,Qid,currTrajID); % get data for query
        lowBndList(end+1,:) = lowBnd;
        upBndList(end+1,:) = upBnd;
        sPList(end+1,:) = sP;
        ePList(end+1,:) = eP;
    end

    queryStrData(Qid).sub3svert = sPList(:,1);
    queryStrData(Qid).sub3sseginterior = sPList(:,2);
    queryStrData(Qid).sub3evert = ePList(:,1);
    queryStrData(Qid).sub3eseginterior = ePList(:,2);
    queryStrData(Qid).sub3lb = lowBndList;
    queryStrData(Qid).sub3ub = upBndList;

    queryStrData(Qid).sub3cntworst = numWorst;
    queryStrData(Qid).sub3cntcellcheck = sCellCheck;
    queryStrData(Qid).sub3cntdpcalls = sDPCalls;
    queryStrData(Qid).sub3cntspvert = sSPVert;
    queryStrData(Qid).sub3searchtime = timeSearch;
    queryStrData(Qid).sub3rangedist = tau;

end

