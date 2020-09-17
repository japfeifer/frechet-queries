% Get Pruned S1 for kNN search

function kNNPrune(cNodeID,Q,Qid,lowBnd,kNum,eAdd)

    global clusterNode S1 nodeCheckCnt trajData
    global Bk stopCheckNodes distCalcCnt kUBList searchStat

    if stopCheckNodes == false
 
        nodeCheckCnt = nodeCheckCnt + 1;
        crad = clusterNode(cNodeID,4);

        if size(S1,1) < kNum
            eAddCheck = 0; % set additive error to 0, since we haven't put candidates in S1 yet
        else
            eAddCheck = eAdd;
        end
        
        if (clusterNode(cNodeID,5) == 1) % at the leaf
            searchStat(end+1) = cNodeID; % for kNN graphing

            if lowBnd < Bk
                
                % compute upper bound
                Cid = clusterNode(cNodeID,6);
                cTraj = cell2mat(trajData(Cid,1));
                upBnd = GetBestUpperBound(cTraj,Q,1,Cid,Qid);
 
                if upBnd < Bk % this traj is a candidate
                    S1(end+1,:) = [cNodeID lowBnd upBnd]; % append traj to the current result set
                    kUBList(end+1) = upBnd;
                    UpdatekthBestUB(kNum); % we have a new kthBestUB - find and update variable kthBestUB
                else
                    % check linear LB to see if we can discard this traj
                    linearLB = GetBestLinearLBDP(cTraj,Q,Bk,1,Cid,Qid);  
                    if linearLB == false % we can not discard this traj, so this traj is a candidate
                        S1(end+1,:) = [cNodeID lowBnd upBnd]; % append traj to the current result set
                        if size(kUBList,2) < kNum
                            kUBList(end+1) = upBnd;
                        end
                    end               
                end           
                
                % see if at least kNum results are all <= eAdd
                if Bk <= eAdd && size(S1,1) >= kNum 
                    stopCheckNodes = true;
                    return
                end
                
            end

        elseif lowBnd <= Bk + crad - eAddCheck % the node may contain a traj that is closer
            
            searchStat(end+1) = cNodeID; % for kNN graphing

            child1NodeID = clusterNode(cNodeID,2);
            Cid = clusterNode(child1NodeID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if Cid == clusterNode(cNodeID,6)
                lowBnd1 = lowBnd;
            else
                cTraj = cell2mat(trajData(Cid,1)); % get center traj 
                childCrad = clusterNode(child1NodeID,4);
                lowBnd1 = GetBestConstLB(cTraj,Q,childCrad + Bk,1,Cid,Qid);
                distCalcCnt = distCalcCnt + 1;
            end

            child2NodeID = clusterNode(cNodeID,3);
            Cid = clusterNode(child2NodeID,6);
            % if next child centre traj = curr parent centre traj then do
            % not have to compute it again
            if Cid == clusterNode(cNodeID,6) 
                lowBnd2 = lowBnd;
            else
                cTraj = cell2mat(trajData(Cid,1)); % get center traj 
                childCrad = clusterNode(child2NodeID,4);
                lowBnd2 = GetBestConstLB(cTraj,Q,childCrad + Bk,1,Cid,Qid);
                distCalcCnt = distCalcCnt + 1;
            end
            
            if lowBnd1 < lowBnd2
                kNNPrune(child1NodeID,Q,Qid,lowBnd1,kNum,eAdd);
                kNNPrune(child2NodeID,Q,Qid,lowBnd2,kNum,eAdd);
            else
                kNNPrune(child2NodeID,Q,Qid,lowBnd2,kNum,eAdd);
                kNNPrune(child1NodeID,Q,Qid,lowBnd1,kNum,eAdd);
            end
        end
    end
end