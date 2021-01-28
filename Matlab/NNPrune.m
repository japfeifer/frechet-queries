% Get Pruned S1 for NN search

function NNPrune(cNodeID,Q,Qid,lowBnd,eAdd)

    global clusterNode S1
    global Bk Ak stopCheckNodes distCalcCnt nodeCheckCnt
    global linLBcnt linUBcnt conLBcnt
    global timeConstLB timeLinLB timeLinUB
    global trajStrData
    
    global t5 t6 time5Sum time6Sum

    if stopCheckNodes == false
 
        nodeCheckCnt = nodeCheckCnt + 1;
        crad = clusterNode(cNodeID,4);
        
        if size(S1,1) == 0
            eAddCheck = 0; % set additive error to 0, since we haven't put candidates in S1 yet
        else
            eAddCheck = eAdd;
        end

        if (clusterNode(cNodeID,5) == 1) % at the leaf
            

            if lowBnd < Bk
                t5 = tic;
                % compute upper bound
                Cid = clusterNode(cNodeID,6);
                cTraj = trajStrData(Cid).traj;
                tStartLinUB = tic;
                upBnd = GetBestUpperBound(cTraj,Q,1,Cid,Qid);
                timeLinUB = timeLinUB + toc(tStartLinUB);
                linUBcnt = linUBcnt + 1;
                time5Sum = time5Sum + toc(t5);

                % see if we have found a close enough node
                if upBnd <= eAdd % we have found a NN within the approximation threshold
                    S1 = [cNodeID lowBnd upBnd];
                    Ak = lowBnd;
                    Bk = upBnd;
                    stopCheckNodes = true;
                    return
                end

                if upBnd < Ak % this traj centre is definitely closer than all current ones
                    S1 = [cNodeID lowBnd upBnd];
                    Ak = lowBnd;
                    Bk = upBnd;
                elseif upBnd < Bk % this traj is a candidate
                    S1(end+1,:) = [cNodeID lowBnd upBnd]; % append traj to the current result set
                    if lowBnd < Ak
                        Ak = lowBnd;
                    end
                    if upBnd < Bk 
                        Bk = upBnd;
                    end
                else
                    % check linear LB to see if we can discard this traj
                    tStartLinLB = tic;
                    linearLB = GetBestLinearLBDP(cTraj,Q,Bk,1,Cid,Qid);  
                    timeLinLB = timeLinLB + toc(tStartLinLB);
                    linLBcnt = linLBcnt + 1;  
                    if linearLB == false % we can not discard this traj, so this traj is a candidate
                        S1(end+1,:) = [cNodeID lowBnd upBnd]; % append traj to the current result set
                        if lowBnd < Ak
                            Ak = lowBnd;
                        end
                        if upBnd < Bk 
                            Bk = upBnd;
                        end
                    end
                end                
            end
            
        elseif lowBnd <= Bk + crad - eAdd % the node may contain a traj that is closer
            
            t6 = tic;
            child1NodeID = clusterNode(cNodeID,2);
            Cid = clusterNode(child1NodeID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if Cid == clusterNode(cNodeID,6)
                lowBnd1 = lowBnd;
            else
                cTraj = trajStrData(Cid).traj; % get center traj 
                childCrad = clusterNode(child1NodeID,4);
                tStartConstLB = tic;
                lowBnd1 = GetBestConstLB(cTraj,Q,childCrad + Bk,1,Cid,Qid);
                timeConstLB = timeConstLB + toc(tStartConstLB);
                conLBcnt = conLBcnt + 1;
                distCalcCnt = distCalcCnt + 1;
            end

            child2NodeID = clusterNode(cNodeID,3);
            Cid = clusterNode(child2NodeID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if Cid == clusterNode(cNodeID,6) 
                lowBnd2 = lowBnd;
            else
                cTraj = trajStrData(Cid).traj; % get center traj
                childCrad = clusterNode(child2NodeID,4);
                tStartConstLB = tic;
                lowBnd2 = GetBestConstLB(cTraj,Q,childCrad + Bk,1,Cid,Qid);
                timeConstLB = timeConstLB + toc(tStartConstLB);
                conLBcnt = conLBcnt + 1;
                distCalcCnt = distCalcCnt + 1;
            end
            time6Sum = time6Sum + toc(t6);
            if lowBnd1 < lowBnd2
                NNPrune(child1NodeID,Q,Qid,lowBnd1,eAdd);
                NNPrune(child2NodeID,Q,Qid,lowBnd2,eAdd);
            else
                NNPrune(child2NodeID,Q,Qid,lowBnd2,eAdd);
                NNPrune(child1NodeID,Q,Qid,lowBnd1,eAdd);
            end
        end
    end
end