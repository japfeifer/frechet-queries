% Get Pruned S1 for NN search

function SubInvNNPrune(cNodeID,Q,Qid,lowBnd,upBnd,eAdd)

    global clusterNode S1 distCalcCnt
    global Bk Ak stopCheckNodes nodeCheckCnt
    global trajStrData
    global sCellCheck sDPCalls sSPVert

    if stopCheckNodes == false
 
        nodeCheckCnt = nodeCheckCnt + 1;
        crad = clusterNode(cNodeID,4);

        if (clusterNode(cNodeID,5) == 1) % at the leaf
            if lowBnd < Bk
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
                else % this traj is a candidate
                    S1(end+1,:) = [cNodeID lowBnd upBnd]; % append traj to the current result set
                    if lowBnd < Ak
                        Ak = lowBnd;
                    end
                    if upBnd < Bk 
                        Bk = upBnd;
                    end
                end                
            end
        elseif lowBnd <= Bk + crad - eAdd % parent node that may contain a traj that is closer
            
            child1NodeID = clusterNode(cNodeID,2);
            Cid = clusterNode(child1NodeID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if Cid == clusterNode(cNodeID,6)
                lowBnd1 = lowBnd;
                upBnd1 = upBnd;
            else
                cTraj = trajStrData(Cid).traj; % get center traj 
                childCrad = clusterNode(child1NodeID,4);
                tStartConstLB = tic;
                [lowBnd1,upBnd1,totCellCheck,totDPCalls,totSPVert] = GetSubDist(Q,cTraj,Qid,Cid,4);
                sCellCheck = sCellCheck + totCellCheck;
                sDPCalls = sDPCalls + totDPCalls;
                sSPVert = sSPVert + totSPVert;
                distCalcCnt = distCalcCnt + 1;
            end

            child2NodeID = clusterNode(cNodeID,3);
            Cid = clusterNode(child2NodeID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if Cid == clusterNode(cNodeID,6) 
                lowBnd2 = lowBnd;
                upBnd2 = upBnd;
            else
                cTraj = trajStrData(Cid).traj; % get center traj
                childCrad = clusterNode(child2NodeID,4);
                tStartConstLB = tic;
                [lowBnd2,upBnd2,totCellCheck,totDPCalls,totSPVert] = GetSubDist(Q,cTraj,Qid,Cid,4);
                sCellCheck = sCellCheck + totCellCheck;
                sDPCalls = sDPCalls + totDPCalls;
                sSPVert = sSPVert + totSPVert;
                distCalcCnt = distCalcCnt + 1;
            end
            if lowBnd1 < lowBnd2
                SubInvNNPrune(child1NodeID,Q,Qid,lowBnd1,upBnd1,eAdd);
                SubInvNNPrune(child2NodeID,Q,Qid,lowBnd2,upBnd2,eAdd);
            else
                SubInvNNPrune(child2NodeID,Q,Qid,lowBnd2,upBnd2,eAdd);
                SubInvNNPrune(child1NodeID,Q,Qid,lowBnd1,upBnd1,eAdd);
            end
        end
    end
end