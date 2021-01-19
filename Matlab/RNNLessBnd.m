% function RNN
% 
% Perform RNN query on Qid
% typeQ: 1 Additive, 2 Multiplicative, 3 Implicit
% Three stages: Prune, Reduce, Decide

function RNNLessBnd(Qid,typeQ,tau,eVal,stage,doCnt)

    global clusterNode S1 nodeCheckCnt trajData queryTraj
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
    
    Q = cell2mat(queryTraj(Qid,1)); % query vertices

    % Prune Stage - compute S1
    
    if typeQ == 1 % additive error
        eAdd = eVal;
    else
        eAdd = 0;
    end
    
    RNNPruneLessBnd(1,tau,Q,Qid,0,Inf,doCnt); % traverse the CCT
    
    if typeQ == 2 % multiplicative error
        eAdd = eVal * tau;
    end

    % save results from Prune Stage
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,6) = mat2cell(distCalcCnt,size(distCalcCnt,1),size(distCalcCnt,2));
    queryTraj(Qid,8) = mat2cell(S1,size(S1,1),size(S1,2)); % S1 list (node id)
    queryTraj(Qid,9) = num2cell(size(S1,1)); % |S1|
    
    if stage >= 2
        % Reduce Stage - compute S2 (and maybe result set)

        % save results from Reduce Stage
        queryTraj(Qid,3) = mat2cell(S1,size(S1,1),size(S1,2));
        queryTraj(Qid,5) = num2cell(size(S1,1));

        % get pruned node trajectories
        for i=1:size(S1,1)
            S1(i,1) = clusterNode(S1(i,1),6);
        end

        % save results from Reduce Stage
        queryTraj(Qid,7) = mat2cell(S1,size(S1,1),size(S1,2));
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
                        P = cell2mat(trajData(Pid,1)); % get center traj 
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
        queryTraj(Qid,10) = num2cell(numCFD);
        queryTraj(Qid,11) = num2cell(numDP);
        queryTraj(Qid,12) = mat2cell(rangeTrajList,size(rangeTrajList,1),size(rangeTrajList,2));
        queryTraj(Qid,13) = num2cell(size(rangeTrajList,1));
        if typeQ == 3
            queryTraj(Qid,14) = num2cell(eAddImplicit);
            queryTraj(Qid,15) = num2cell(eMultImplicit);
        end
    end

end

