% function SubInvNN
% 
% Perform Sub-traj Inverse NN query on Qid
% typeQ: 1 Additive, 2 Multiplicative, 3 Implicit
% Three stages: Prune, Reduce, Decide

function SubInvNN(Qid,typeQ,eVal,stage)

    global clusterNode S1 nodeCheckCnt distCalcCnt
    global Bk Ak stopCheckNodes
    global trajStrData queryStrData
    global sCellCheck sDPCalls sSPVert

    switch nargin
    case 1
        typeQ = 1;
        eVal = 0;
        stage = 3;
    case 3
        stage = 3;
    end

    tSearch = tic;
    
    sCellCheck = 0;
    sDPCalls = 0;
    sSPVert = 0;
    
    S1 = [];
    nodeCheckCnt = 0;
    distCalcCnt = 0;
    stopCheckNodes = false;
    Bk = Inf;
    Ak = Inf;
    
    bestTrajID = 0;
    bestDist = 0;
    eAddImplicit = 0;
    eMultImplicit = 0;
    foundTraj = false;
    
    Q = queryStrData(Qid).traj; % query vertices
    centerTrajID = clusterNode(1,6); % root center traj id
    centreTraj = trajStrData(centerTrajID).traj; % get root center traj vertices
    [lowBnd, upBnd,totCellCheck,totDPCalls,totSPVert] = GetSubDist(Q,centreTraj,Qid,centerTrajID,4);
    sCellCheck = sCellCheck + totCellCheck;
    sDPCalls = sDPCalls + totDPCalls;
    sSPVert = sSPVert + totSPVert;
    distCalcCnt = distCalcCnt + 1;
    
    % Prune Stage - compute S1
    
    if typeQ == 1 % additive error
        eAdd = eVal;
    else
        eAdd = 0;
    end
    
    SubInvNNPrune(1,Q,Qid,lowBnd,upBnd,eAdd) % traverse the CCT

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

        % Delete traj from S1 if their UB > Bk and LB + eAdd > SUB.
        if size(S1,1) > 1
            S1 = sortrows(S1,3,'ascend'); % sort asc by UB
            TF1 = S1(2 : end, 2) + eAdd > Bk; % for all but first row, if  LB + eAdd > SUB then mark for deletion
            S1([false; TF1],:) = []; % delete rows - always keep first row
        end

        % find traj with largest UB (LUB). search other traj and delete them if
        % their LB + eAdd > LUB.
        if size(S1,1) > 1
            lUB = S1(end,3); % largest UB - we already sorted asc by UB, so just get last item in list
            TF1 = S1(1 : end-1, 2) + eAdd > lUB; % for all but last row, if LB + eAdd > LUB then mark for deletion
            S1([TF1; false],:) = []; % delete rows - always keep last row
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
            if size(S1,1) == 1
                foundTraj = true;
                bestTrajID = S1(1,1);
                bestDist = S1(1,3); % just put in the UB
            elseif typeQ == 3 % implicit query
                S1 = sortrows(S1,3,'ascend'); % sort asc by UB
                bestTrajID = S1(1,1);
                bestDist = S1(1,3); % just use the UB
                S1 = S1(2:end,:); % delete the first traj
                S1 = sortrows(S1,2,'ascend'); % sort asc by LB
                sLB = S1(1,2); % smallest lower bound
                eAddImplicit = Bk - sLB;
                eMultImplicit = (Bk - sLB) / sLB;
                foundTraj = true;
            else
                % check sub-traj inverse dec proc for the curve with the second Lowest LB
                candTrajID2List = sortrows(S1,2,'ascend'); % sort asc by LB
                secondLowestLB = candTrajID2List(2,2);
                currTraj = trajStrData(candTrajID2List(1,1)).traj;
                [decProRes,totCellCheck,totDPCalls,totSPVert] = GetSubDP(Q,currTraj,secondLowestLB);
                sCellCheck = sCellCheck + totCellCheck;
                sDPCalls = sDPCalls + totDPCalls;
                sSPVert = sSPVert + totSPVert;
                if decProRes == 1
                    foundTraj = true;
                    bestTrajID = candTrajID2List(1,1);
                    bestDist = candTrajID2List(1,2); % just put in the LB
                end
            end

            % if we haven't found a NN then we have to use more expensive sub-traj inverse distance and
            % decision procedure computations
            if foundTraj == false
                for i = 1:size(S1,1)
                    centerTrajID = S1(i,1);
                    currTraj = trajStrData(centerTrajID).traj; % get center traj 
                    if i == 1
                        % this is first traj we check, so just get the sub-traj inverse distance
                        [garbage,bestDist,totCellCheck,totDPCalls,totSPVert] = GetSubDist(Q,currTraj,Qid,centerTrajID);
                        sCellCheck = sCellCheck + totCellCheck;
                        sDPCalls = sDPCalls + totDPCalls;
                        sSPVert = sSPVert + totSPVert;
                        bestTrajID = centerTrajID;
                        % if the first traj CFD <= eAdd then we are done
                        if bestDist <= eAdd
                            foundTraj = true;
                            break;
                        end
                    else % i >= 2
                        % if traj LB  < bestDist then do DP
                        if S1(i,2) < bestDist
                            % call sub-traj inverse decision procedure
                            [decProRes,totCellCheck,totDPCalls,totSPVert] = GetSubDP(Q,currTraj,bestDist);
                            sCellCheck = sCellCheck + totCellCheck;
                            sDPCalls = sDPCalls + totDPCalls;
                            sSPVert = sSPVert + totSPVert;
                            if decProRes == 1 % then curr traj is closer, so get CFD dist
                                [garbage,bestDist] = GetSubDist(Q,currTraj,Qid,centerTrajID);
                                bestTrajID = centerTrajID;
                                % if the first traj CFD <= eAdd then we are done
                                if bestDist <= eAdd
                                    foundTraj = true;
                                    break;
                                end
                            end
                        end
                    end
                end 
            end
        else
            bestTrajID = [];
            bestDist = [];
        end
        
        timeSearch = toc(tSearch);
        
        numWorst = 0;
        for i = 1:size(trajStrData,2)
            P = trajStrData(i).traj;
            numWorst = numWorst + (size(P,1) * size(Q,1) * 30);
        end

        % save results from decide stage
        queryStrData(Qid).decidecfdcnt = 0;
        queryStrData(Qid).decidedpcnt = 0;
        queryStrData(Qid).decidetrajids = bestTrajID;
        queryStrData(Qid).decidetrajcnt = size(bestTrajID,1);
        if typeQ == 3
            queryStrData(Qid).decideeadd = eAddImplicit;
            queryStrData(Qid).decideemult = eMultImplicit;
        end
        
        currTraj = trajStrData(bestTrajID).traj; % get center traj 
        [lowBnd,upBnd,totCellCheck,totDPCalls,totSPVert,sP,eP] = GetSubDist(Q,currTraj,Qid,bestTrajID); % get data for query
        
        queryStrData(Qid).sub3svert = sP(1,1);
        queryStrData(Qid).sub3sseginterior = sP(1,2);
        queryStrData(Qid).sub3evert = eP(1,1);
        queryStrData(Qid).sub3eseginterior = eP(1,2);
        queryStrData(Qid).sub3lb = lowBnd;
        queryStrData(Qid).sub3ub = upBnd;
        
        queryStrData(Qid).sub3cntworst = numWorst;
        queryStrData(Qid).sub3cntcellcheck = sCellCheck;
        queryStrData(Qid).sub3cntdpcalls = sDPCalls;
        queryStrData(Qid).sub3cntspvert = sSPVert;
        queryStrData(Qid).sub3searchtime = timeSearch;
    end

end

