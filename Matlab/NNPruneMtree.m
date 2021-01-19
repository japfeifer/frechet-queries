% Get Pruned S1 for NN search on the M-tree

function NNPruneMtree(cNodeID,Q,QDistToParent)

    global S1 trajStrData mTree
    global Ak nodeCheckCnt numCFD numDP

    nodeCheckCnt = nodeCheckCnt + 1;  % we have touched a node so inc node check counter

    if mTree(cNodeID,1) == 0 % at a leaf node
        for i = 1:mTree(cNodeID,2) % for each element in node
            curPos = (i * 4) - 1;
            E = mTree(cNodeID,curPos:curPos+3);  % get the element
            if abs(QDistToParent - E(4)) <= Ak  % see if can exclude by using dist to parent entry
                % can not exclude, so compute cont Frechet dist
                P = trajStrData(E(1)).traj;  % the node entry traj curve
                decProRes = FrechetDecide(P,Q,Ak,1);
                numDP = numDP + 1;
                if decProRes == true  % we have a new NN candidate
                    dist1 = ContFrechet(P,Q);  % compute the continuous frechet distance
                    numCFD = numCFD + 1;
                    Ak = dist1;
                    S1 = [cNodeID i E];
                end
            end
        end

    else % at a parent node
        
        N = [];
        for i = 1:mTree(cNodeID,2) % for each element in node
            curPos = (i * 4) - 1;
            E = mTree(cNodeID,curPos:curPos+3);  % get the element
            if abs(QDistToParent - E(4)) <= Ak + E(3)  % see if can exclude by using dist to parent entry
                % can not exclude, so compute cont Frechet dist
                P = trajStrData(E(1)).traj;  % the node entry traj curve
                dist1 = ContFrechet(P,Q);  % compute the continuous frechet distance
                numCFD = numCFD + 1;
                N(end+1,:) = [E dist1 max((dist1-E(3)),0) (dist1 + E(3)) ];
 
                if dist1 <= Ak  % we have a new NN candidate
                    Ak = dist1;
                    S1 = [cNodeID i E];
                end
            end
        end
        
        if isempty(N) == false % if there are elements to search
            
            % sort N by LB asc
            N = sortrows(N,6,'ascend'); % sort asc by LB
            
            for i = 1:size(N,1) % recursively search the tree
                if N(i,6) <= Ak
                    NNPruneMtree(N(i,2),Q,N(i,5))
                end
            end
        end
    end

end