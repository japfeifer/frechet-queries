% function kNN
% 
% Perform kNN query on Qid
% typeQ: 1 Additive, 2 Multiplicative, 3 Implicit
% Three stages: Prune, Reduce, Decide

function kNN(Qid,typeQ,kNum,eVal,stage)

    global clusterNode S1 nodeCheckCnt trajStrData queryStrData
    global Bk Ak stopCheckNodes distCalcCnt kUBList
    
    switch nargin
    case 4
        stage = 3;
    end
    
    tSearch = tic;

    S1 = [];
    kUBList = [];
    kNNTrajList = [];
    nodeCheckCnt = 0;
    distCalcCnt = 0;
    stopCheckNodes = false;
    Bk = Inf;

    numCFD = 0;
    numDP = 0;
    eAddImplicit = 0;
    eMultImplicit = 0;
    foundTraj = false;
    
    Q = queryStrData(Qid).traj; % query vertices
    centerTrajID = clusterNode(1,6); % root center traj id
    centreTraj = trajStrData(centerTrajID).traj; % get root center traj vertices 
    lowBnd = GetBestConstLB(centreTraj,Q,Inf,1,centerTrajID,Qid); % root center traj LB call
    distCalcCnt = distCalcCnt + 1; % root LB count
    
    rng('default'); % reset the random seed so that experiments are reproducable
    
    % Prune Stage - compute S1
    
    if typeQ == 1 % additive error
        eAdd = eVal;
    else
        eAdd = 0;
    end

    kNNPrune(1,Q,Qid,lowBnd,kNum,eAdd); % traverse the CCT

    if typeQ == 2 % multiplicative error
        S1 = sortrows(S1,2,'ascend'); % sort asc by LB 
        Ak = S1(kNum,2); % get the kth smallest LB
        eAdd = eVal * Ak;
    end
    
    % save results from Prune Stage
    queryStrData(Qid).prunenodecnt = nodeCheckCnt;
    queryStrData(Qid).prunedistcnt = distCalcCnt;
    queryStrData(Qid).prunes1 = S1;
    queryStrData(Qid).prunes1sz = size(S1,1);
    
    if stage >= 2
        % Reduce Stage - compute S2 (and maybe result set)

        % Delete traj from S1 if their UB > Bk and LB + eAdd > SUB.
        if size(S1,1) > kNum
            S1 = sortrows(S1,3,'ascend'); % sort asc by UB
            TF1 = S1(1:kNum,3) > Inf; % just get a set of zeros for first k traj, since we do not want to delete these
            TF2 = S1(kNum+1:end,2) > Bk; % indexes where LB > kth smallest UB, from kNum+1 to end
            S1([TF1; TF2],:) = []; % delete rows 
        end

        % find traj with kth largest UB (LUB). search other traj and delete them if
        % their LB + eAdd > LUB.
        if size(S1,1) > kNum
            lUB = S1(end-kNum+1,3); % largest UB - we already sorted asc by UB, so just get kth largest UB in list
            TF1 = S1(1 : end-kNum, 2) + eAdd > lUB; % for all but the last kth rows, if LB + eAdd > LUB then mark for deletion
            TF2 = S1(end-kNum+1:end ,3) > Inf; % just get a set of zeros for last kth rows, since we do not want to delete these
            S1([TF1; TF2],:) = []; % delete rows 
        end

        % Delete traj from S1 if their UB > Bk and LB + eAdd > SUB,
        % but check with linear LB Traversal Race
        if size(S1,1) > kNum
            tmpS1 = S1(kNum+1:end,:);
            S1 = S1(1:kNum,:);
            for i=1:size(tmpS1,1)
                Pid = clusterNode(tmpS1(i,1),6);
                currTraj = trajStrData(Pid).traj;
                linearLB = GetBestLinearLBDP(currTraj,Q,Bk - eAdd,1,Pid,Qid);
                if linearLB == false
                     S1(end+1,:) = tmpS1(i,:);
                end
            end
        end

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

        S1 = sortrows(S1,3,'ascend'); % sort asc by UB

        % only process if cenTrajList is not null
        if isempty(S1) == false
            if size(S1,1) == kNum
                foundTraj = true;
                kNNTrajList = S1(:,1);
            elseif typeQ == 3 % implicit query
                S1 = sortrows(S1,3,'ascend'); % sort asc by UB
                kNNTrajList = S1(1:kNum,1); % kNN result set is first k traj in list
                S1 = S1(kNum+1:end,:); % delete the first traj
                S1 = sortrows(S1,2,'ascend'); % sort asc by LB
                sLB = S1(1,2); % smallest lower bound
                eAddImplicit = Bk - sLB;
                eMultImplicit = (Bk - sLB) / sLB;
                foundTraj = true;
            end

            if foundTraj == false

                % get k+1 smallest LB, and check if some traj can be appended to result set:
                % check if UB - eAdd < kthLB, or if TR(P,Q,kth+1 LB) == true
                S1 = sortrows(S1,2,'ascend'); % sort asc by LB
                kthLB = S1(kNum+1,2); % get the kth + 1 smallest LB
                TF1 = [];
                for i = 1:kNum
                    if S1(i,3) - eAdd < kthLB % UB - eAdd < kthLB
                        kNNTrajList = [kNNTrajList; S1(i,1)]; % append traj to result set
                        TF1(end+1) = true;
                    else
                        TF1(end+1) = false;
                    end
                end
                TF1 = logical(TF1');
                TF2 = S1(kNum+1:end,3) > Inf; % just get a set of zeros for all traj after k, since we do not want to delete these
                S1([TF1; TF2],:) = []; % delete rows 
                currNumK = kNum - sum(TF1(:) == 1); % reduce the k number to add to result set

                while currNumK > 0
                    if size(S1,1) == currNumK % we are done 
                        kNNTrajList = [kNNTrajList; S1(:,1)];
                    else

                        markWithinDist = [];
                        markOutsideDist = [];

                        % Compute continuous frechet distance on traj with kth
                        % smallest UB. Lets call the kth smallest UB the "pivot".
                        % Note that the pivot can also be chosen randomly, but in
                        % this implementation we set it to the kth smallest UB.

                        pivot = randi([1 size(S1,1)]); % randomly choose the pivot
                        pivotRecord = S1(pivot,:);
                        centerTrajID = S1(pivot,1);
                        currTraj = trajStrData(centerTrajID).traj;
                        pivotDist = ContFrechet(Q,currTraj);
                        numCFD = numCFD + 1;

                        for i = 1:size(S1,1)
                            if i ~= pivot % do not test the pivot
                                if S1(i,2) > pivotDist
                                    markOutsideDist(end+1) = i;
                                elseif S1(i,3) < pivotDist
                                    markWithinDist(end+1) = i;
                                else
                                    currTraj = trajStrData(S1(i,1)).traj;
                                    linearLB = GetBestLinearLBDP(currTraj,Q,pivotDist,1,S1(i,1),Qid);
                                    if linearLB == true
                                       markOutsideDist(end+1) = i; % traj is further
                                    else
                                        decProRes = FrechetDecide(currTraj,Q,pivotDist,1);
                                        numDP = numDP + 1;
                                        if decProRes == 1 % traj is closer
                                            markWithinDist(end+1) = i;
                                        else
                                            markOutsideDist(end+1) = i;
                                        end
                                    end
                                end
                            else
                                markOutsideDist(end+1) = i; % mark pivot as outside the distance
                            end
                        end

                        if size(markWithinDist,2) == currNumK % we are done 
                            S1(markOutsideDist,:) = []; % delete rows
                            kNNTrajList = [kNNTrajList; S1(:,1)];
                            currNumK = 0;
                        elseif size(markWithinDist,2) + 1 == currNumK % we are done 
                            pivotValue = S1(pivot,1);
                            S1(markOutsideDist,:) = []; % delete rows
                            kNNTrajList = [kNNTrajList; S1(:,1); pivotValue];
                            currNumK = 0;
                        elseif size(markWithinDist,2) == size(S1,1) - 1 % all other traj are closer 
                            S1(pivot,:) = []; % delete pivot
                        elseif size(markWithinDist,2) == 0 % all other traj are further
                            kNNTrajList = [kNNTrajList; S1(pivot,1)]; % append pivot to results
                            S1(pivot,:) = []; % delete pivot from candidates
                            currNumK = currNumK - 1;
                        elseif size(markWithinDist,2) < currNumK % append traj to result
                            trajToAppend = S1;
                            trajToAppend(markOutsideDist,:) = [];
                            kNNTrajList = [kNNTrajList; trajToAppend(:,1)];
                            S1(markWithinDist,:) = [];
                            currNumK = currNumK - size(trajToAppend,1);
                        elseif size(markWithinDist,2) + 1 > currNumK % remove traj from S1
                            S1(markOutsideDist,:) = [];
                            S1(end+1,:) = pivotRecord;
                        end
                    end
                end
            end
        end
        
        timeSearch = toc(tSearch);

        % save results from decide stage
        queryStrData(Qid).decidecfdcnt = numCFD;
        queryStrData(Qid).decidedpcnt = numDP;
        queryStrData(Qid).decidetrajids = kNNTrajList;
        queryStrData(Qid).decidetrajcnt = size(kNNTrajList,1);
        if typeQ == 3
            queryStrData(Qid).decideeadd = eAddImplicit;
            queryStrData(Qid).decideemult = eMultImplicit;
        end
        queryStrData(Qid).searchtime = timeSearch;
    end

end

