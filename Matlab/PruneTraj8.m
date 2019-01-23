% kNN pruning
% Called by kNNSearch, kNNSearch2, kNNSearch3
%
% Iteratively execute the pruning process (GetPrunedNodes6) until at least
% kNum results are gathered. In each iteration search for traj that are a
% further distance from Q than the pervious iteration.
% In the first iteration search the CCT starting
% at the root node, and keep track of all nodes that are eliminated or
% deleted (nextNodeList).  In subsequent iterations search the set of nodes 
% from the previous iteration that were eliminated or deleted.  This algo
% ensures that we do not search starting at the root for each iteration 
% (which will result in more node accesses and slower performance).
% 
% During each iteration delete traj from the pruning result set where the
% traj LB > currBestUpNodeDist, since they can be added in a subsequent 
% iteration if need be.
%
% If on the final iteration, exactly one more traj was required, and
% exactly one traj was returned, and the traj LB > currBestUpNodeDist, then
% we are done (and the result set is an exact kNN search result, regardless
% of the epsilon Emin).  
% 
% Otherwise, do one more query on the CCT (GetPrunedNodes7)
% which returns traj where LB > prevLowestUpBnd and LB <= largestUB. Now 
% delete traj from result set where LB + Emin > kthUB and UB > kthUB.  
% Finally, determine all traj where UB - Emin < kthLB, as these will be in 
% the final result set (and the rest we will have to check back in kNNSearch).

function [numTrajInFinRes] = PruneTraj8(Qid,kNum)

    global clusterNode prunedNodes nodeCheckCnt trajData queryTraj
    global prevLowestUpBnd currBestUpNodeDist currBestLowNodeDist
    global currNodeList nextNodeList

    tmpPrunedNodes = [];
    nodeCheckCnt = 0;
    Q = cell2mat(queryTraj(Qid,1));
    prevLowestUpBnd = -1;
    prunedTraj = [];
    currNumTraj = 0;
    largestUB = 0;
    doneProcess = false;
    donePrune = false;
    numTrajInFinRes = 0;
    
    nodeCheckCnt = nodeCheckCnt + 1;
    centerTrajID = clusterNode(1,6); % root node centre traj id
    centreTraj = cell2mat(trajData(centerTrajID,1)); % root node centre traj
    lowBnd = GetBestLowerBound(centreTraj,Q,Inf,1,centerTrajID,Qid);
    upBnd = GetBestUpperBound(centreTraj,Q,1,centerTrajID,Qid);
    currNodeList = [1 lowBnd upBnd];
    
    while currNumTraj < kNum
        % get pruned node leafs
        prunedNodes = [];
        currBestLowNodeDist = Inf;
        currBestUpNodeDist = Inf;
        
        % get pruned nodes for each node in currNodeList
        nextNodeList = [];
        for i=1:size(currNodeList,1)
            GetPrunedNodes6(currNodeList(i,1),Q,Qid,currNodeList(i,2),currNodeList(i,3));
        end
        
        % if there is more than one traj in prunedNodes, then delete traj 
        % in prunedNodes and add them to nextNodeList if the traj LB > currBestUpNodeDist
        if size(prunedNodes,1) > 1
            processPrunedNodes = prunedNodes;
            prunedNodes = [];
            for i=1:size(processPrunedNodes,1)
                if processPrunedNodes(i,2) > currBestUpNodeDist
                    nextNodeList = [nextNodeList; processPrunedNodes(i,:)];
                else
                    prunedNodes = [prunedNodes; processPrunedNodes(i,:)];
                end
            end
        end
        
        currNodeList = nextNodeList;
        prevLowestUpBnd = currBestUpNodeDist;
        
        % if this is the final iteration, and only one more traj was 
        % required, and only one traj was returned in this iteration, and 
        % it's LB > largestUB, then we do not have to do the extra processing
        if currNumTraj + 1 == kNum && ... % final interation, only one more traj required
           size(prunedNodes,1) == 1 && ... % only one traj was returned in this iteration
           prunedNodes(1,3) > largestUB
            doneProcess = true;
        end

        % compute the current largest UB of all pruning results
        largestUB = max(max(prunedNodes(:,3)), largestUB);

        currNumTraj = currNumTraj + size(prunedNodes,1);
        tmpPrunedNodes = [tmpPrunedNodes; prunedNodes];
    end
    
    % do extra proccessing
    if doneProcess == false
        
        % get all traj where LB > prevLowestUpBnd and LB <= largestUB
        prunedNodes = [];
        for i=1:size(currNodeList,1)
            GetPrunedNodes7(currNodeList(i,1),Q,Qid,currNodeList(i,2),currNodeList(i,3),largestUB);
        end
        tmpPrunedNodes = [tmpPrunedNodes; prunedNodes];
        
        % sort asc by UB, get the kth smallest UB, and delete nodes from k+1 to end where the
        % LB > kth smallest UB
        tmpPrunedNodes = sortrows(tmpPrunedNodes,3,'ascend'); % sort asc by UB
        kthUB = tmpPrunedNodes(kNum,3); % get the kth smallest UB
        TF1 = tmpPrunedNodes(1:kNum,3) > Inf; % just get a set of zeros for first k traj, since we do not want to delete these
        TF2 = tmpPrunedNodes(kNum+1:end,2) > kthUB; % indexes where LB > kth smallest UB, from kNum+1 to end
        tmpPrunedNodes([TF1; TF2],:) = []; % delete rows  
    else
        tmpPrunedNodes = sortrows(tmpPrunedNodes,3,'ascend'); % sort asc by UB
    end

    if kNum == size(tmpPrunedNodes,1)
        numTrajInFinRes = kNum;
        donePrune = true;
    end

    % get all traj where UB < kthLB, as these will be in result set
    if donePrune == false
        tmpPrunedNodes2 = sortrows(tmpPrunedNodes,2,'ascend'); % sort asc by LB
        kthLB = tmpPrunedNodes2(kNum,2); % get the kth smallest LB
        for i = kNum - 1 : -1 : 1
            if tmpPrunedNodes(i,3) < kthLB  % use tmpPrunedNodes which is sorted asc by UB
                numTrajInFinRes = i;
                break;
            end
        end
    end
    
    % get pruned node trajectories
    for i=1:size(tmpPrunedNodes,1)
        prunedTraj = [prunedTraj; clusterNode(tmpPrunedNodes(i,1),6) tmpPrunedNodes(i,2) tmpPrunedNodes(i,3)];
    end

    % save results in queryTraj
    queryTraj(Qid,3) = mat2cell(tmpPrunedNodes,size(tmpPrunedNodes,1),size(tmpPrunedNodes,2));
    queryTraj(Qid,4) = num2cell(nodeCheckCnt);
    queryTraj(Qid,5) = num2cell(size(tmpPrunedNodes,1));
    queryTraj(Qid,7) = mat2cell(prunedTraj,size(prunedTraj,1),size(prunedTraj,2));
    
end
