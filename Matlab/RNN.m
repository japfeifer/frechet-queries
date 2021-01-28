% function RNN
% 
% Perform RNN query on Qid
% typeQ: 1 Additive, 2 Multiplicative, 3 Implicit
% Three stages: Prune, Reduce, Decide

function RNN(Qid,typeQ,tau,eVal,stage,doCnt)

    global clusterNode S1 nodeCheckCnt trajStrData queryStrData
    global distCalcCnt
    
    switch nargin
    case 4
        stage = 3;
        doCnt = 0;
    case 5
        doCnt = 0;
    end

    S1 = [];
    nodeCheckCnt = 0;
    distCalcCnt = 0;
    rangeTrajList = [];
    numCFD = 0;
    numDP = 0;
    eAddImplicit = 0;
    eMultImplicit = 0;
    
    Q = queryStrData(Qid).traj; % query vertices

    % Prune Stage - compute S1
    
    if typeQ == 1 % additive error
        eAdd = eVal;
    else
        eAdd = 0;
    end
    
    RNNPrune(1,tau,Q,Qid,0,Inf,doCnt); % traverse the CCT
    
    if typeQ == 2 % multiplicative error
        eAdd = eVal * tau;
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
    
    if stage >= 3
        % Decide Stage

        if isempty(S1) == false
            if typeQ == 3 % implicit query
                S1 = sortrows(S1,3,'ascend'); % sort asc by UB
                rangeTrajList = S1;
                hUB = S1(size(S1,1),3); % highest upper bound
                if hUB > tau
                    eAddImplicit = hUB - tau;
                    eMultImplicit = (hUB - tau) / tau;
                end
            else
                % loop thru each traj and see if it can go into the result set
                for i = 1:size(S1,1)

                    if S1(i,3) <= tau + eAdd % upper bound < tau + eAdd
                        rangeTrajList = [rangeTrajList; S1(i,:)];
                    else % check frechet decision procedure
                        Pid = S1(i,1);
                        P = trajStrData(Pid).traj; % get center traj 
                        decProRes = FrechetDecide(P,Q,tau,1);
                        numDP = numDP + 1;
                        if decProRes == 1 % CFD is <= tau
                            rangeTrajList = [rangeTrajList; S1(i,:)];
                        end
                    end
                end
            end
        end
        
        if isempty(rangeTrajList) == false
            rangeTrajList = rangeTrajList(:,1); % just save traj id's
        end

        % save results from decide stage
        queryStrData(Qid).decidecfdcnt = numCFD;
        queryStrData(Qid).decidedpcnt = numDP;
        queryStrData(Qid).decidetrajids = rangeTrajList;
        queryStrData(Qid).decidetrajcnt = size(rangeTrajList,1);
        if typeQ == 3
            queryStrData(Qid).decideeadd = eAddImplicit;
            queryStrData(Qid).decideemult = eMultImplicit;
        end
    end

end

