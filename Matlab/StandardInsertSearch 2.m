
function StandardInsertSearch(Qid)

    global clusterNode trajData queryTraj nodeCheckCnt
    
    numCFD = 0;
    numDP = 0;
    S1 = [];
    doneSearch = false;
    bestTrajID = 0;
    distCalcCnt = 0;
    
    Q = cell2mat(queryTraj(Qid,1)); % query vertices
    centerTrajID = clusterNode(1,6); % root center traj id
    child1 = clusterNode(1,2); % child1 of root
    
    % traverse the CCT, start at root and go to child node with a closer LB
    if child1 > 0 % root has children
        cNodeID = 1; % start at the root
        while doneSearch == false
            % child 1 LB
            child1NodeID = clusterNode(cNodeID,2);
            child1TrajID = clusterNode(child1NodeID,6);
            cTraj = cell2mat(trajData(child1TrajID,1)); 
            lowBnd1 = GetBestConstLB(cTraj,Q,Inf,1,child1TrajID,Qid);
            distCalcCnt = distCalcCnt + 1;
            % child 2 LB
            child2NodeID = clusterNode(cNodeID,3);
            child2TrajID = clusterNode(child2NodeID,6);
            cTraj = cell2mat(trajData(child2TrajID,1)); 
            lowBnd2 = GetBestConstLB(cTraj,Q,Inf,1,child2TrajID,Qid);
            distCalcCnt = distCalcCnt + 1;
            if lowBnd1 < lowBnd2 % determine which child node to search next
                % child 1 is closer
                if (clusterNode(child1NodeID,5) == 1) % at the leaf
                    bestTrajID = child1TrajID;
                    S1 = [bestTrajID lowBnd1];
                    doneSearch = true;
                else % it's a parent node
                    cNodeID = child1NodeID;
                end
            else
                % child 2 is closer
                if (clusterNode(child2NodeID,5) == 1) % at the leaf
                    bestTrajID = child2TrajID;
                    S1 = [bestTrajID lowBnd2];
                    doneSearch = true;
                else % it's a parent node
                    cNodeID = child2NodeID;
                end
            end
        end
    else % there is only one node in the CCT tree
        bestTrajID = clusterNode(1,6);
        S1 = [bestTrajID 0];
    end

    % save results from Prune Stage
    queryTraj(Qid,4) = mat2cell(nodeCheckCnt,size(nodeCheckCnt,1),size(nodeCheckCnt,2));
    queryTraj(Qid,6) = mat2cell(distCalcCnt,size(distCalcCnt,1),size(distCalcCnt,2));
    queryTraj(Qid,8) = mat2cell(S1,size(S1,1),size(S1,2)); % S1 list (node id)
    queryTraj(Qid,9) = num2cell(size(S1,1)); % |S1|

    % save results from Reduce Stage
    queryTraj(Qid,3) = mat2cell(S1,size(S1,1),size(S1,2));
    queryTraj(Qid,5) = num2cell(size(S1,1));

    % get pruned node trajectories
    for i=1:size(S1,1)
        S1(i,1) = clusterNode(S1(i,1),6);
    end

    % save results from Reduce Stage
    queryTraj(Qid,7) = mat2cell(S1,size(S1,1),size(S1,2));

    % save results from decide stage
    queryTraj(Qid,10) = num2cell(numCFD);
    queryTraj(Qid,11) = num2cell(numDP);
    queryTraj(Qid,12) = mat2cell(bestTrajID,1,1);
    queryTraj(Qid,13) = num2cell(size(bestTrajID,1));

end

