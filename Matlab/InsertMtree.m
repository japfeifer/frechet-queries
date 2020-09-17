% function InsertMtree
% 
% inserts a trajectory into M-tree by recursively choosing "the best" leaf node

function InsertMtree(mTreeNodeId,insTrajId,distToParent)

    global mTree mTreePtrList mTreeRootId mTreeNodeCapacity numCFD trajData mTreeMaxCol
    
    if mTreeNodeId == 0  % the M-tree is empty
        mTree(1,1:mTreeMaxCol) = zeros(1,mTreeMaxCol);
        mTree(1,1:6) = [0 1 insTrajId 0 0 distToParent];  % insert traj into M-tree
        mTreePtrList(1,:) = [0 0];
        mTreeRootId = 1;  % set root id to first node added to the mTree
    elseif mTree(mTreeNodeId,1) == 0  % the node is a leaf
        if mTree(mTreeNodeId,2) < mTreeNodeCapacity  % the node is not full
            mTree(mTreeNodeId,2) = mTree(mTreeNodeId,2) + 1;  % inc the number of node entries
            idxPos = (mTree(mTreeNodeId,2) * 4) - 1;  % set the column in mTree to insert the entry
            mTree(mTreeNodeId,idxPos:idxPos+3) = [insTrajId 0 0 distToParent];  % insert the traj into M-tree
        else  % the node is full, so it must be split
            SplitMtree(mTreeNodeId,[insTrajId 0 0 distToParent]);
        end
    else  % the node is a routing object (not a leaf), so determine which node entry to descend to
        P = cell2mat(trajData(insTrajId,1));  % the insert traj curve
        bestTrajId = 0;
        bestEntryPos = 0;
        bestType = 0;  % 0 = outside radius, 1 = inside radius
        bestDist = Inf; 
        bestDistType0 = Inf;
        for i = 1:mTree(mTreeNodeId,2)  % for each node entry, determine the "best" entry to descend to
            nodeEntryPos = (i * 4) - 1;  % get the index position of the node entry
            nodeEntryTrajId = mTree(mTreeNodeId,nodeEntryPos);  % get the traj id for the node entry
            Q = cell2mat(trajData(nodeEntryTrajId,1));  % the node entry traj curve
            distCont = ContFrechet(P,Q);  % compute the continuous frechet distance
            numCFD = numCFD + 1;

            if i == 1  % this is the first node entry, so just make it the best one thus far
                bestTrajId = nodeEntryTrajId;
                bestEntryPos = nodeEntryPos;
                bestDist = distCont;
                if distCont < mTree(mTreeNodeId,nodeEntryPos + 2)  % dist is < node entry radius
                    bestType = 1;
                else  % dist is > node entry radius
                    bestType = 0;
                    bestDistType0 = distCont - mTree(mTreeNodeId,nodeEntryPos + 2);
                end
            elseif distCont < mTree(mTreeNodeId,nodeEntryPos + 2)  % dist is < node entry radius
                if bestType == 0
                    bestType = 1;
                    bestDist = distCont;
                    bestTrajId = nodeEntryTrajId;
                    bestEntryPos = nodeEntryPos;
                elseif distCont < bestDist
                    bestDist = distCont;
                    bestTrajId = nodeEntryTrajId;
                    bestEntryPos = nodeEntryPos;
                end
            elseif bestType == 0
                if distCont - mTree(mTreeNodeId,nodeEntryPos + 2) < bestDistType0
                    bestDist = distCont;
                    bestDistType0 = distCont - mTree(mTreeNodeId,nodeEntryPos + 2);
                    bestTrajId = nodeEntryTrajId;
                    bestEntryPos = nodeEntryPos;
                end
            end
        end

        if bestType == 0  % we have to increase the radius of this node entry
            mTree(mTreeNodeId,bestEntryPos + 2) = bestDist;
        end
        
        InsertMtree(mTree(mTreeNodeId,bestEntryPos+1),insTrajId,bestDist);  % go to the next child level node 
        
    end
end