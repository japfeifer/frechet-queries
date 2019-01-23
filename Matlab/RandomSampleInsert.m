%% Randomly sample some trajectories from trajData and move them into insertTrajData

numInsertTraj = 500;
Emin = 0;

% put in current trap ID in col 10 - used later for testing/debugging
trajData(:,10) = num2cell([1:size(trajData,1)]');

% uniformly Randomly sample numInsertTraj number of trajectories from the dataset
[insertTrajData,insTmpIndex] = datasample(trajData,numInsertTraj,'Replace',false);

% delete the sample traj from the dataset
trajData(insTmpIndex, : ) = [];

%% Build initial CCT - run the BuildClusterCentreTree script 
% 
%
%

%% Insert traj one at a time from insertTrajData to trajData

tic;

% create the "query" trajectories, which will be the list of traj in insertTrajData
szQ = size(queryTraj,1); % size inital query traj
queryTraj(szQ+1:szQ+numInsertTraj,1) = insertTrajData(:,1);
queryTraj(szQ+1:szQ+numInsertTraj,2) = insertTrajData(:,2);
queryTraj(szQ+1:szQ+numInsertTraj,20) = insertTrajData(:,3);
queryTraj(szQ+1:szQ+numInsertTraj,21) = insertTrajData(:,4);
queryTraj(szQ+1:szQ+numInsertTraj,22) = insertTrajData(:,5);
queryTraj(szQ+1:szQ+numInsertTraj,23) = insertTrajData(:,6);
queryTraj(szQ+1:szQ+numInsertTraj,24) = insertTrajData(:,7);

% append the inserted traj to trajData
szT = size(trajData,1);
trajData = [trajData; insertTrajData];

% for each query find the exact NN, then create two new leaf nodes beneath each NN leaf
h = waitbar(0, 'Insert');

insCnt = 1;

for k = szQ+1:szQ+numInsertTraj  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    foundTraj = false;
    
    % call the pruning process to get candidate curves
    PruneTraj2(k,0);
    
    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);

    candTrajIDList = sortrows(candTrajIDList,3,'ascend'); % sort asc by UB
    
    % only process if cenTrajList is not null
    if isempty(candTrajIDList) == false
        
        if size(candTrajIDList,1) == 1
            foundTraj = true;
        end

        % if we haven't found a NN then we have to use more expensive CFD and
        % frechet decision procedure computations
        if foundTraj == false
            for i = 1:size(candTrajIDList,1)
                centerTrajID = candTrajIDList(i,1);
                currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                if i == 1
                    % this is first traj we check, so just get the CFD
                    bestDist = ContFrechet(currQueryTraj,currTraj);
                    numCFD = numCFD + 1;
                    bestCenterTraj = centerTrajID;
                else % i >= 2
                    % if traj LB  < bestDist then do DP
                    if candTrajIDList(i,2) < bestDist
                        % call frechet decision procedure
                        decProRes = FrechetDecide(currTraj,currQueryTraj,bestDist,1);
                        numDP = numDP + 1;
                        if decProRes == 1 % then curr traj is closer, so get CFD dist
                            bestDist = ContFrechet(currQueryTraj,currTraj);
                            numCFD = numCFD + 1;
                            bestCenterTraj = centerTrajID;
                        end
                    end
                end
            end 
        else % a single traj is in the result set
            bestCenterTraj = candTrajIDList(1,1);
            currTraj = cell2mat(trajData(bestCenterTraj,1));
            bestDist = ContFrechet(currQueryTraj,currTraj);
            numCFD = numCFD + 1;
        end
    else
        bestCenterTraj = [];
        bestDist = [];
    end
    
    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);  % 0 cluster centres
    queryTraj(k,10) = num2cell(numCFD);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell([bestCenterTraj bestDist],size([bestCenterTraj bestDist],1),size([bestCenterTraj bestDist],2));
    queryTraj(k,13) = num2cell(size(bestCenterTraj,1));
    
    % set some variables
    nnNodeID = clusterTrajNode(bestCenterTraj,1); % NN traj node id
    szNode = size(clusterNode,1);
    newTrajID = szT + k - szQ;
    
    % find node in CCT to insert traj to
    insType = 0; % 1 = leaf, 2 = middle, 3 = new root
    prevNodeID = nnNodeID;
    while insType == 0
        parentNodeID = clusterNode(prevNodeID,1); % get parent node

        % get up bnd from query (insert traj) to the centre traj
        centerTrajID = clusterNode(parentNodeID,6);
        centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
        upBnd = GetBestUpperBound(centreTraj,currQueryTraj,1,centerTrajID,k);
        
        if upBnd < clusterNode(parentNodeID,4) % query traj dist is < cluster radius
            if prevNodeID == nnNodeID
                insType = 1;
            else
                insType = 2;
            end
            currDist = ContFrechet(currQueryTraj,centreTraj);
            numCFD = numCFD + 1;
        else % do quadratic calc
            currDist = ContFrechet(currQueryTraj,centreTraj);
            numCFD = numCFD + 1;
            if currDist < clusterNode(parentNodeID,4) % query traj dist is < cluster radius
                if prevNodeID == nnNodeID
                    insType = 1;
                else
                    insType = 2;
                end 
            end
        end
        
        if insType == 0 && clusterNode(parentNodeID,1) == 0 % at root and can't go higher
            insType = 3;
        end
        
        prevNodeID = parentNodeID;
    end

    % update nodes
    if insType == 1
        % update leaf that was NN to a parent node
        clusterNode(nnNodeID,2) = szNode+1;
        clusterNode(nnNodeID,3) = szNode+2;
        clusterNode(nnNodeID,4) = bestDist;
        clusterNode(nnNodeID,5) = 2;
        clusterNode(nnNodeID,7) = newTrajID;

        % create new leaf - same traj as parent
        clusterNode(szNode+1,1) = nnNodeID;
        clusterNode(szNode+1,2) = 0;
        clusterNode(szNode+1,3) = 0;
        clusterNode(szNode+1,4) = 0;
        clusterNode(szNode+1,5) = 1;
        clusterNode(szNode+1,6) = bestCenterTraj;
        clusterNode(szNode+1,7) = bestCenterTraj;

        % create new leaf - "query" traj that is inserted
        clusterNode(szNode+2,1) = nnNodeID;
        clusterNode(szNode+2,2) = 0;
        clusterNode(szNode+2,3) = 0;
        clusterNode(szNode+2,4) = 0;
        clusterNode(szNode+2,5) = 1;
        clusterNode(szNode+2,6) = newTrajID;
        clusterNode(szNode+2,7) = newTrajID;

        % update clusterTrajNode since one node id changed and one is inserted
        clusterTrajNode(bestCenterTraj,1) = szNode+1; % NN found traj
        clusterTrajNode(newTrajID,1) = szNode+2; % newly inserted traj
        
    elseif insType == 2
        pc1NodeID = clusterNode(parentNodeID,2);
        pc2NodeID = clusterNode(parentNodeID,3);
        % create new parent - same as prev parent
        clusterNode(szNode+1,1) = parentNodeID;
        clusterNode(szNode+1,2) = clusterNode(parentNodeID,2);
        clusterNode(szNode+1,3) = clusterNode(parentNodeID,3);
        clusterNode(szNode+1,4) = clusterNode(parentNodeID,4);
        clusterNode(szNode+1,5) = clusterNode(parentNodeID,5);
        clusterNode(szNode+1,6) = clusterNode(parentNodeID,6);
        clusterNode(szNode+1,7) = clusterNode(parentNodeID,7);
        
        % create new leaf - "query" traj that is inserted
        clusterNode(szNode+2,1) = parentNodeID;
        clusterNode(szNode+2,2) = 0;
        clusterNode(szNode+2,3) = 0;
        clusterNode(szNode+2,4) = 0;
        clusterNode(szNode+2,5) = 1;
        clusterNode(szNode+2,6) = newTrajID;
        clusterNode(szNode+2,7) = newTrajID;
        
        % update prev parent - point to 2 new nodes created
        clusterNode(parentNodeID,2) = szNode+1;
        clusterNode(parentNodeID,3) = szNode+2;
        
        % update prev children nodes - point to new parent
        clusterNode(pc1NodeID,1) = szNode+1;
        clusterNode(pc2NodeID,1) = szNode+1;
        
        % update clusterTrajNode - new "query" traj that is inserted
        clusterTrajNode(newTrajID,1) = szNode+2; % newly inserted traj
        
    elseif insType == 3
        disp(['root']);
        pc1NodeID = clusterNode(1,2);
        pc2NodeID = clusterNode(1,3);
        
        % create new parent - same as prev root, point to new root
        clusterNode(szNode+1,1) = 1;
        clusterNode(szNode+1,2) = clusterNode(1,2);
        clusterNode(szNode+1,3) = clusterNode(1,3);
        clusterNode(szNode+1,4) = clusterNode(1,4);
        clusterNode(szNode+1,5) = clusterNode(1,5);
        clusterNode(szNode+1,6) = clusterNode(1,6);
        clusterNode(szNode+1,7) = clusterNode(1,7);
        
        % create new leaf - "query" traj that is inserted, point to root
        clusterNode(szNode+2,1) = 1;
        clusterNode(szNode+2,2) = 0;
        clusterNode(szNode+2,3) = 0;
        clusterNode(szNode+2,4) = 0;
        clusterNode(szNode+2,5) = 1;
        clusterNode(szNode+2,6) = newTrajID;
        clusterNode(szNode+2,7) = newTrajID;
        
        % update new root - point to 2 new nodes created, add 1 to leaf
        % count, update larger radius, and update the furthest traj
        clusterNode(1,2) = szNode+1;
        clusterNode(1,3) = szNode+2;
        clusterNode(1,4) = currDist;
        clusterNode(1,5) = clusterNode(1,5) + 1;
        clusterNode(1,7) = newTrajID;
        
        % update prev children nodes - point to new parent
        clusterNode(pc1NodeID,1) = szNode+1;
        clusterNode(pc2NodeID,1) = szNode+1;
        
        % update clusterTrajNode - new "query" traj that is inserted
        clusterTrajNode(newTrajID,1) = szNode+2; % newly inserted traj
        
    end
    
    % update parent node leaf counts, and potentially the radius
    if insType == 1 || insType == 2
        
        % go up the CCT towards the root
        while parentNodeID ~= 0
            % update leaf count
            clusterNode(parentNodeID,5) = clusterNode(parentNodeID,5) + 1;

            % get up bnd from query (insert traj) to the centre traj
            centerTrajID = clusterNode(parentNodeID,6);
            centreTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            upBnd = GetBestUpperBound(centreTraj,currQueryTraj,1,centerTrajID,k);
            
            % potentially update the radius and furthest traj
            if upBnd > clusterNode(parentNodeID,4) % newly inserted traj may be further than cluster radius
                currDist = ContFrechet(currQueryTraj,centreTraj);
                numCFD = numCFD + 1;
                if currDist > clusterNode(parentNodeID,4)
                    clusterNode(parentNodeID,4) = currDist; % update cluster radius
                    clusterNode(parentNodeID,7) = newTrajID; % update furthest traj ID to newly inserted traj ID
                end
            end
            
            % get the next higher parent 
            parentNodeID = clusterNode(parentNodeID,1);
        end
    end
    
    if mod(k,10) == 0
        X = ['Insert: ',num2str(k-szQ),'/',num2str(numInsertTraj)];
        waitbar((k-szQ)/numInsertTraj, h, X);
    end
end

close(h);

% clear the insert traj list
insertTrajData = [];

% clear the insert "query" trajectories
queryTraj(szQ+1:szQ+numInsertTraj,:) = [];

timeElapsed = toc;
