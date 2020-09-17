% function SplitMtree
% 
% A split is triggered by attempting to insert a new entry into a full node. 
% This function recursively splits nodes in the M-Tree.
%
% This function chooses routing objects OP1 and OP2 by sampling 2 new parent 
% entries uniformly at random without replacement, to save on distance computations.
% It then distributes entries via the hyperplane method.

function SplitMtree(mTreeNodeId,newNodeEntry)

    global mTree mTreePtrList mTreeRootId mTreeNodeCapacity numCFD trajData mTreeMaxCol numDP
    
    allEntries = [];
    for i = 1:mTreeNodeCapacity
        curPos = (i * 4) - 1;
        allEntries(i,:) = mTree(mTreeNodeId,curPos:curPos+3);
    end
    allEntries(end+1,:) = newNodeEntry;
    
    % Choose routing objects OP1 & OP2, then distribute entries via the hyperplane method.
    newParentEntries = datasample(allEntries,2,'Replace',false);
    OP1 = [newParentEntries(1,1) 0 0 0];
    OP2 = [newParentEntries(2,1) 0 0 0];
    nodeSplitType = mTree(mTreeNodeId,1); % determine if node we are splitting is leaf or routing node
    N1 = [nodeSplitType 0];
    N2 = [nodeSplitType 0];
    P1 = cell2mat(trajData(OP1(1),1));
    P2 = cell2mat(trajData(OP2(1),1));
    maxDist1 = 0;
    maxDist2 = 0;
    maxDist1NonLeaf = 0;
    maxDist2NonLeaf = 0;
    newSplitNodeId = size(mTree,1) + 1;

    % partition entries
    for i = 1:size(allEntries,1)
        if allEntries(i,1) == OP1(1)
            N1(2) = N1(2) + 1;  % inc Num Node Entries
            idxPos = (N1(2) * 4) - 1;
            N1(idxPos:idxPos+3) = [allEntries(i,1:3) 0];  % append new entry
            if allEntries(i,3) > maxDist1NonLeaf
                maxDist1NonLeaf = allEntries(i,3);
            end
        elseif allEntries(i,1) == OP2(1)
            N2(2) = N2(2) + 1;  % inc Num Node Entries
            idxPos = (N2(2) * 4) - 1;
            N2(idxPos:idxPos+3) = [allEntries(i,1:3) 0];  % append new entry
            if allEntries(i,3) > maxDist2NonLeaf
                maxDist2NonLeaf = allEntries(i,3);
            end
        else % we have to check distances
            Q = cell2mat(trajData(allEntries(i,1),1));  % the node entry traj curve
            dist1 = ContFrechet(P1,Q);  % compute the continuous frechet distance
            numCFD = numCFD + 1;
            decProRes = FrechetDecide(P2,Q,dist1,1);  % compute the frechet decision procedure
            numDP = numDP + 1;

            if decProRes == false  % the split node entry is closer to parent 1
                N1(2) = N1(2) + 1;  % inc Num Node Entries
                idxPos = (N1(2) * 4) - 1;
                N1(idxPos:idxPos+3) = [allEntries(i,1:3) dist1];  % append new entry
                if dist1 > maxDist1
                    maxDist1 = dist1;
                end
                if dist1 + allEntries(i,3) > maxDist1NonLeaf
                    maxDist1NonLeaf = dist1 + allEntries(i,3);
                end
            else  % the split node entry is closer to parent 2
                dist2 = ContFrechet(P2,Q);  % compute the continuous frechet distance
                numCFD = numCFD + 1;
                N2(2) = N2(2) + 1;  % inc Num Node Entries
                idxPos = (N2(2) * 4) - 1;
                N2(idxPos:idxPos+3) = [allEntries(i,1:3) dist2];  % append new entry
                if dist2 > maxDist2
                    maxDist2 = dist2;
                end
                if dist2 + allEntries(i,3) > maxDist2NonLeaf
                    maxDist2NonLeaf = dist2 + allEntries(i,3);
                end
            end
        end
    end

    OP1(2) = mTreeNodeId;
    OP2(2) = newSplitNodeId;
    if nodeSplitType == 1 % not splitting a leaf, have to make radius larger to ensure coverage of subtree
        OP1(3) = maxDist1NonLeaf;
        OP2(3) = maxDist2NonLeaf;
    else  % splitting a leaf
        OP1(3) = maxDist1;
        OP2(3) = maxDist2;
    end
    
    % replace prev node with N1
    mTree(mTreeNodeId,1:mTreeMaxCol) = zeros(1,mTreeMaxCol);
    mTree(mTreeNodeId,1:size(N1,2)) = N1;
    % create new node with N2
    mTree(newSplitNodeId,1:mTreeMaxCol) = zeros(1,mTreeMaxCol);
    mTree(newSplitNodeId,1:size(N2,2)) = N2;
    % create new record in parent pointer list
    mTreePtrList(newSplitNodeId,:) = [0 0];

    % for each entry in N1 & N2 get its child node and ensure the child node points to the N1/N2 entry 
    numEntries = N1(2);
    for i = 1:numEntries
        idxPos = (i * 4) - 1;
        childNodePtr = N1(idxPos+1);
        if childNodePtr ~= 0
            mTreePtrList(childNodePtr,1) = mTreeNodeId;
            mTreePtrList(childNodePtr,2) = i;
        end
    end
    numEntries = N2(2);
    for i = 1:numEntries
        idxPos = (i * 4) - 1;
        childNodePtr = N2(idxPos+1);
        if childNodePtr ~= 0
            mTreePtrList(childNodePtr,1) = newSplitNodeId;
            mTreePtrList(childNodePtr,2) = i;
        end
    end

    parentNodeId = mTreePtrList(mTreeNodeId,1);
    if parentNodeId == 0  % we are splitting the root
        mTreeRootId = newSplitNodeId + 1;  % create a new root node Id
        mTree(mTreeRootId,1:mTreeMaxCol) = zeros(1,mTreeMaxCol);
        mTree(mTreeRootId,1:10) = [1 2 OP1 OP2];  % create new root node
        mTreePtrList(mTreeRootId,:) = [0 0];
        
        mTreePtrList(mTreeNodeId,1) = mTreeRootId;
        mTreePtrList(mTreeNodeId,2) = 1;
        mTreePtrList(newSplitNodeId,1) = mTreeRootId;
        mTreePtrList(newSplitNodeId,2) = 2;
        
    else  % non-root node is being split
        
        % first process N1
        
    	ParentNodeEntryNum = mTreePtrList(mTreeNodeId,2);
        
        mTreePtrList(mTreeNodeId,1) = parentNodeId;
        mTreePtrList(mTreeNodeId,2) = ParentNodeEntryNum;
        
        % For each N1 entry:
        % (i)  if distToParent = 0 and the traj id is diff from parent, then compute and update the dist
        % (ii) if distToParent > 0 and the traj id is same as parent, then update dist = 0
        numEntries = mTree(mTreeNodeId,2);
        for i = 1:numEntries
            idxPos = (numEntries * 4) - 1;
            if mTree(mTreeNodeId,idxPos+3) == 0 && mTree(mTreeNodeId,idxPos) ~= OP1(1)
                Q = cell2mat(trajData(mTree(mTreeNodeId,idxPos),1));  % the node entry traj curve
                distToParent = ContFrechet(P1,Q);  % compute the continuous frechet distance
                numCFD = numCFD + 1;
                mTree(mTreeNodeId,idxPos+3) = distToParent;
            elseif mTree(mTreeNodeId,idxPos+3) > 0 && mTree(mTreeNodeId,idxPos) == OP1(1)
                mTree(mTreeNodeId,idxPos+3) = 0;
            end
        end

        % update entry OP1 distToParent if OP1 is not in the root and OP1's traj id is diff from OP1's parent
        OP1ParentNode = mTreePtrList(parentNodeId,1);
        OP1ParentEntryNum = mTreePtrList(parentNodeId,2);
        idxPos = (OP1ParentEntryNum * 4) - 1;
        
        if parentNodeId ~= mTreeRootId  % if OP1 is not in the root
            if OP1(1) ~= mTree(OP1ParentNode,idxPos)  % if OP1's traj id is diff from OP1's parent
                Q = cell2mat(trajData(mTree(OP1ParentNode,idxPos),1));  % OP1's parent entry traj curve
                distToParent = ContFrechet(P1,Q);  % compute the continuous frechet distance
                numCFD = numCFD + 1;
                OP1(4) = distToParent;
            end
        end
        
        idxPos = (ParentNodeEntryNum * 4) - 1;
        mTree(parentNodeId,idxPos:idxPos+3) = OP1;  % replace prev parent node entry with OP1
        
        % We are done processing N1, lets now process N2
        ParentNumNodeEntries = mTree(parentNodeId,2);
        if ParentNumNodeEntries == mTreeNodeCapacity % parent node is full, recursively split it
            
            SplitMtree(parentNodeId,OP2);
            
        else % there is space in the parent node, so process N2
            ParentNodeEntryNum = ParentNumNodeEntries + 1;

            mTreePtrList(newSplitNodeId,1) = parentNodeId;
            mTreePtrList(newSplitNodeId,2) = ParentNodeEntryNum;

            % For each N2 entry:
            % (i)  if distToParent = 0 and the traj id is diff from parent, then compute and update the dist
            % (ii) if distToParent > 0 and the traj id is same as parent, then update dist = 0            
            numEntries = mTree(newSplitNodeId,2);
            for i = 1:numEntries
                idxPos = (numEntries * 4) - 1;
                if mTree(newSplitNodeId,idxPos+3) == 0 && mTree(newSplitNodeId,idxPos) ~= OP2(1)
                    Q = cell2mat(trajData(mTree(newSplitNodeId,idxPos),1));  % the node entry traj curve
                    distToParent = ContFrechet(P2,Q);  % compute the continuous frechet distance
                    numCFD = numCFD + 1;
                    mTree(newSplitNodeId,idxPos+3) = distToParent;
                elseif mTree(newSplitNodeId,idxPos+3) > 0 && mTree(newSplitNodeId,idxPos) == OP2(1)
                    mTree(newSplitNodeId,idxPos+3) = 0;
                end
            end

            % update entry OP2 distToParent if OP2 is not in the root and OP2's traj id is diff from OP2's parent
            OP2ParentNode = mTreePtrList(parentNodeId,1);
            OP2ParentEntryNum = mTreePtrList(parentNodeId,2);
            idxPos = (OP2ParentEntryNum * 4) - 1;
            if parentNodeId ~= mTreeRootId  % if OP2 is not in the root 
                if OP2(1) ~= mTree(OP2ParentNode,idxPos)  % if OP2's traj id is diff from OP2's parent
                    Q = cell2mat(trajData(mTree(OP2ParentNode,idxPos),1));  % OP2's parent entry traj curve
                    distToParent = ContFrechet(P2,Q);  % compute the continuous frechet distance
                    numCFD = numCFD + 1;
                    OP2(4) = distToParent;
                end    
            end

            idxPos = (ParentNodeEntryNum * 4) - 1;
            mTree(parentNodeId,idxPos:idxPos+3) = OP2;  % append parent node with OP2
            mTree(parentNodeId,2) = ParentNodeEntryNum;  % update parent node NumNodeEntries
        end
    end

end