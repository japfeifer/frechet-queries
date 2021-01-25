% Get Pruned S1 for kNN search on the M-tree

function kNNPruneMtree(cNodeID,Q,QDistToParent,kNum)

    global S1 trajStrData mTree
    global Bk nodeCheckCnt numCFD numDP

    nodeCheckCnt = nodeCheckCnt + 1;  % we have touched a node so inc node check counter

    if mTree(cNodeID,1) == 0 % at a leaf node
        for i = 1:mTree(cNodeID,2) % for each element in node
            curPos = (i * 4) - 1;
            E = mTree(cNodeID,curPos:curPos+3);  % get the element
            if abs(QDistToParent - E(4)) <= Bk  % see if can exclude by using dist to parent entry
                % can not exclude, so compute cont Frechet dist
                P = trajStrData(E(1)).traj;  % the node entry traj curve
                decProRes = FrechetDecide(P,Q,Bk,1);
                numDP = numDP + 1;
                if decProRes == true  % we have a new kNN candidate
                    dist1 = ContFrechet(P,Q);  % compute the continuous frechet distance
                    numCFD = numCFD + 1;
                    S1(end+1,:) = [cNodeID i E dist1];
                    UpdatekthS1(kNum);
                end
            end
        end

    else % at a parent node
        
        N = [];
        for i = 1:mTree(cNodeID,2) % for each element in node
            curPos = (i * 4) - 1;
            E = mTree(cNodeID,curPos:curPos+3);  % get the element
            if abs(QDistToParent - E(4)) <= Bk + E(3)  % see if can exclude by using dist to parent entry
                % can not exclude, so compute cont Frechet dist
                P = trajStrData(E(1)).traj;  % the node entry traj curve
                dist1 = ContFrechet(P,Q);  % compute the continuous frechet distance
                numCFD = numCFD + 1;
                N(end+1,:) = [E dist1 max((dist1-E(3)),0) (dist1 + E(3)) ];
            end
        end
        
        if isempty(N) == false % if there are elements to search
            
            N = sortrows(N,6,'ascend'); % sort asc by LB
            
            for i = 1:size(N,1) % recursively search the tree
                if N(i,6) <= Bk
                    kNNPruneMtree(N(i,2),Q,N(i,5),kNum)
                end
            end
        end
    end

end