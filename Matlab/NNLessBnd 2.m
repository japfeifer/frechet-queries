
function NNLessBnd(Qid,typeQ,eVal,stage)

    global clusterNode S1 nodeCheckCnt trajData queryTraj
    global Bk Ak stopCheckNodes distCalcCnt conLBcnt

    switch nargin
    case 3
        stage = 3;
    end

    S1 = [];
    nodeCheckCnt = 0;
    distCalcCnt = 0;
    stopCheckNodes = false;
    Bk = Inf;
    Ak = Inf;
    
    bestTrajID = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    eAddImplicit = 0;
    eMultImplicit = 0;
    foundTraj = false;
    
    Q = cell2mat(queryTraj(Qid,1)); % query vertices
    centerTrajID = clusterNode(1,6); % root center traj id
    centreTraj = cell2mat(trajData(centerTrajID,1)); % get root center traj vertices 
    lowBnd = GetBestConstLBLessBnd(centreTraj,Q,Inf,1,centerTrajID,Qid); % root center traj LB call
    conLBcnt = conLBcnt + 1;
    distCalcCnt = distCalcCnt + 1;
    
    % Prune Stage - compute S1
    
    if typeQ == 1 % additive error
        eAdd = eVal;
    else
        eAdd = 0;
    end
    
    NNPruneLessBnd(1,Q,Qid,lowBnd,eAdd); % traverse the CCT
    
    if typeQ == 2 % multiplicative error
        eAdd = eVal * Ak;
    end
    
    % save results from Prune Stage
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,6) = mat2cell(distCalcCnt,size(distCalcCnt,1),size(distCalcCnt,2));
    queryTraj(Qid,8) = mat2cell(S1,size(S1,1),size(S1,2)); % S1 list (node id)
    queryTraj(Qid,9) = num2cell(size(S1,1)); % |S1|
    
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

        % Delete traj from S1 if their UB > Bk and LB + eAdd > SUB,
        % but check with linear LB Traversal Race
        if size(S1,1) > 1
            tmpS1 = S1(2:end,:);
            S1 = S1(1,:);
            for i=1:size(tmpS1,1)
                Pid = clusterNode(tmpS1(i,1),6);
                currTraj = cell2mat(trajData(Pid,1));
%                 linearLB = GetBestLinearLBDP(currTraj,Q,Bk - eAdd,1,Pid,Qid);
%                 if linearLB == false
                     S1(end+1,:) = tmpS1(i,:);
%                 end
            end
        end

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
                % check frechet dec proc for the curve with the second Lowest LB
                candTrajID2List = sortrows(S1,2,'ascend'); % sort asc by LB
                secondLowestLB = candTrajID2List(2,2);
                currTraj = cell2mat(trajData(candTrajID2List(1,1),1));

%                 linearLB = GetBestLinearLBDP(currTraj,Q,secondLowestLB,1,candTrajID2List(1,1),Qid);
%                 if linearLB == false
                    decProRes = FrechetDecide(currTraj,Q,secondLowestLB,1);
                    if decProRes == 1
                        foundTraj = true;
                        bestTrajID = candTrajID2List(1,1);
                        bestDist = candTrajID2List(1,2); % just put in the LB
                    end
%                 end
            end

            % if we haven't found a NN then we have to use more expensive CFD and
            % frechet decision procedure computations
            if foundTraj == false
                for i = 1:size(S1,1)
                    centerTrajID = S1(i,1);
                    currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                    if i == 1
                        % this is first traj we check, so just get the CFD
                        bestDist = ContFrechet(Q,currTraj);
                        numCFD = numCFD + 1;
                        bestTrajID = centerTrajID;
                        % if the first traj CFD <= eAdd then we are done
                        if bestDist <= eAdd
                            foundTraj = true;
                            break;
                        end
                    else % i >= 2
                        % if traj LB  < bestDist then do DP
                        if S1(i,2) < bestDist

%                             linearLB = GetBestLinearLBDP(currTraj,Q,bestDist,1,centerTrajID,Qid);
%                             if linearLB == false
                                % call frechet decision procedure
                                decProRes = FrechetDecide(currTraj,Q,bestDist,1);
                                numDP = numDP + 1;
                                if decProRes == 1 % then curr traj is closer, so get CFD dist
                                    bestDist = ContFrechet(Q,currTraj);
                                    numCFD = numCFD + 1;
                                    bestTrajID = centerTrajID;
                                    % if the first traj CFD <= eAdd then we are done
                                    if bestDist <= eAdd
                                        foundTraj = true;
                                        break;
                                    end
                                end
%                             end
                        end
                    end
                end 
            end
        else
            bestTrajID = [];
            bestDist = [];
        end

        % save results from decide stage
        queryTraj(Qid,10) = num2cell(numCFD);
        queryTraj(Qid,11) = num2cell(numDP);
        queryTraj(Qid,12) = mat2cell(bestTrajID,1,1);
        queryTraj(Qid,13) = num2cell(size(bestTrajID,1));
        if typeQ == 3
            queryTraj(Qid,14) = num2cell(eAddImplicit);
            queryTraj(Qid,15) = num2cell(eMultImplicit);
        end
    end

end

