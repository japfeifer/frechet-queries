% kNN Search 2 - Old code
% Uses Emax threshold
% (1 + epsilon) approximation version - Eapx variable

tic;

mType = 2; % Cluster data structure Method type, can be 1 or 2
kNum = 5;

h = waitbar(0, 'kNN Search 2 Old');

for k = 1:size(queryTraj,1)  % do NN search for each query traj
    
    kNNTrajList = [];
    tmpTrajIDList = [];
    candNodeList = [];
    curveClusterIndex = 0;
    numDP = 0;
    numCandCurve = 0;
    numCandCentre = 0;
    centerAndTraj = {[]};
    currCenterAndTraj = [];
    numCFD = 0;
    currNumK = 0;
    candCurveLowBndList = [];
    
    % call the pruning process to get candidate curves
    PruneTraj(k);

    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);
    
    % calc Emin
    for i = 1:size(candTrajIDList,1)
        centerTrajID = candTrajIDList(i);
        currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
        lowBnd = GetBestLowerBound(currTraj,currQueryTraj,Inf,1,centerTrajID,k);
        candCurveLowBndList = [candCurveLowBndList; lowBnd];
    end
    if isempty(candCurveLowBndList) == true
        Emin = 0;
    else
        candCurveLowBndList = sortrows(candCurveLowBndList,1,'ascend');
        Emin = Eapx * candCurveLowBndList(min(kNum,size(candCurveLowBndList,1)),1);
    end
    
    if mType == 1
        centerAndTraj(size(trajData,1),1) = mat2cell([],size([],1),size([],2));

        % determine the k-size cluster group to search (less than Emin/2)
        for i = 1:size(clusterGroup,1)       
            if Emin/2 >= cell2mat(clusterGroup(i,2)) % this is the best cluster group to search
                curveClusterIndex = i;
                numClustersInGroup = size(cell2mat(clusterGroup(i,3)),1);
                break;
            end
        end

        % find unique candidate clusters (create a list of traj center Id's)
        candClusterList = [];
        for i = 1:size(candTrajIDList,1)
            currCurveCluster = cell2mat(clusterCurveGroup(candTrajIDList(i),1));
            currClusterID = currCurveCluster(curveClusterIndex,2);
            currClusterList = cell2mat(clusterGroup(curveClusterIndex,3));
            currCenterId = currClusterList(currClusterID,3);
            candClusterList = [candClusterList ; currCenterId];

            % also create structure of center and associated traj's
            currCenterAndTraj = cell2mat(centerAndTraj(currCenterId,1));
            currCenterAndTraj = [currCenterAndTraj; candTrajIDList(i)];
            centerAndTraj(currCenterId,1) = mat2cell(currCenterAndTraj,size(currCenterAndTraj,1),size(currCenterAndTraj,2));
        end
        candClusterList = unique(candClusterList); % remove duplicate center Id's
    %     candClusterList = candClusterList(randperm(size(candClusterList, 1)), :); % randomly shuffle the Id's

        % create centre traj list
        cenTrajList = [];
        for i = 1:size(candClusterList,1)
            centerTrajID = candClusterList(i);
            currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            upBnd = GetBestUpperBound(currTraj,currQueryTraj,1,centerTrajID,k);
            lowBnd = GetBestLowerBound(currTraj,currQueryTraj,Inf,1,centerTrajID,k);
            cenTrajList = [cenTrajList; centerTrajID, -1, upBnd, lowBnd, -1];
        end
    end
    
    if mType == 2
        % find unique candidate cluster nodes
        for i = 1:size(candTrajIDList,1)
            iNodeID = GetBestNode(candTrajIDList(i), Emin/2);
            candNodeList = [candNodeList ; iNodeID];
        end
        candNodeList = unique(candNodeList); % remove duplicate node Id's
%         candNodeList = candNodeList(randperm(size(candNodeList, 1)), :); % randomly shuffle the node Id's

        % create centre traj list
        cenTrajList = [];
        for i = 1:size(candNodeList,1)
            centerTrajID = clusterNode(candNodeList(i),6);
            currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            upBnd = GetBestUpperBound(currTraj,currQueryTraj,1,centerTrajID,k);
            lowBnd = GetBestLowerBound(currTraj,currQueryTraj,Inf,1,centerTrajID,k);
            cenTrajList = [cenTrajList; centerTrajID, candNodeList(i), upBnd, lowBnd, -1];
        end
    end
    
    if isempty(cenTrajList) == false
        cenTrajList = sortrows(cenTrajList,3,'ascend');
    end
    numCandCentre = size(cenTrajList,1);
    
    % only process if cenTrajList is not null
    if isempty(cenTrajList) == false
        
        % Phase one. If upper bound <= 1/2 Emin, then the centre and all
        % it's supplemental traj can be added to results.
        tmpCenTrajList = [];
        for i = 1:size(cenTrajList,1)
            centerTrajID = cenTrajList(i,1);
            if cenTrajList(i,3) <= (Emin/2) % upper bound is below (Emin/2)
                % we can add this cluster to results - get the list of traj ID's in this cluster
                if mType == 1
                    tmpTrajIDList = cell2mat(centerAndTraj(centerTrajID,1));
                else
                    leafTrajIDList = [];
                    GetNodeLeafTraj(cenTrajList(i,2));
                    tmpTrajIDList = leafTrajIDList;
                end
                for j = 1:size(tmpTrajIDList,1) % now add each traj to results
                    kNNTrajList = [kNNTrajList; tmpTrajIDList(j)];
                    currNumK = currNumK + 1;
                    if currNumK == kNum % we have reached the k-limit, so do not add any more
                        cenTrajList = []; % empty list of centres since we are done
                        tmpCenTrajList = [];
                        break
                    end 
                end
                if isempty(cenTrajList) == true
                    break;
                end
            else
                tmpCenTrajList = [tmpCenTrajList;cenTrajList(i,:)];
            end
        end  % end Phase one
        cenTrajList = tmpCenTrajList; % we may have processed some centres so used reduced list
        
        % Phase two. If DP(P,Q,1/2 Emin) = true, then the centre and all
        % its supplemental traj can be added to results.
        tmpCenTrajList = [];
        for i = 1:size(cenTrajList,1)
            centerTrajID = cenTrajList(i,1);
            currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
            decProRes = FrechetDecide(currTraj,currQueryTraj,(Emin/2),1);
            numDP = numDP + 1;
            if decProRes == 1 % upper bound is below (Emin/2)
                % we can add this cluster to results - get the list of traj ID's in this cluster
                if mType == 1
                    tmpTrajIDList = cell2mat(centerAndTraj(centerTrajID,1));
                else
                    leafTrajIDList = [];
                    GetNodeLeafTraj(cenTrajList(i,2));
                    tmpTrajIDList = leafTrajIDList;
                end
                for j = 1:size(tmpTrajIDList,1) % now add each traj to results
                    kNNTrajList = [kNNTrajList; tmpTrajIDList(j)];
                    currNumK = currNumK + 1;
                    if currNumK == kNum % we have reached the k-limit, so do not add any more
                        cenTrajList = []; % empty list of centres since we are done
                        tmpCenTrajList = [];
                        break
                    end 
                end
                if isempty(cenTrajList) == true
                    break;
                end
            else
                tmpCenTrajList = [tmpCenTrajList;cenTrajList(i,:)];
            end
        end  % end Phase two
        cenTrajList = tmpCenTrajList; % we may have processed some centres so used reduced list
        
        % Phase three. Now we have to find the closest centre and add it's
        % supplemental traj to the results, and then find the next closest 
        % centre, and do so until we reach the k limit or process all traj.
        while size(cenTrajList,1) > 0
        
            % first find closest centre
            for i = 1:size(cenTrajList,1)
                centerTrajID = cenTrajList(i,1);
                currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                if i == 1 % get CFD distance for first traj in list
                    if cenTrajList(i,5) == -1
                        bestDist = ContFrechet(currQueryTraj,currTraj);
                        numCFD = numCFD + 1;
                    else
                        bestDist = cenTrajList(i,5);
                    end
                    cenTrajList(i,5) = bestDist;
                    closeCTIndex = i;
                    closeCenterTrajID = cenTrajList(i,1);
                else % check the next traj and see if it is closer
                    % only check if traj lower bound < bestDist
                    if bestDist > cenTrajList(i,4)
                        if cenTrajList(i,5) >= 0 % the exact dist is already computed
                            if bestDist > cenTrajList(i,5) % curr traj is closer
                                bestDist = cenTrajList(i,5);
                                closeCTIndex = i;
                                closeCenterTrajID = cenTrajList(i,1);
                            end
                        else % the exact dist is not computed yet
                            % first check the DP
                            decProRes = FrechetDecide(currTraj,currQueryTraj,bestDist,1);
                            numDP = numDP + 1;
                            if decProRes == 1 % this traj is closer.  Get the CFD
                                if cenTrajList(i,5) == -1
                                    bestDist = ContFrechet(currQueryTraj,currTraj);
                                    numCFD = numCFD + 1;
                                else
                                    bestDist = cenTrajList(i,5);
                                end
                                cenTrajList(i,5) = bestDist;
                                closeCTIndex = i;
                                closeCenterTrajID = cenTrajList(i,1);
                            end
                        end
                    end
                end
            end  
            
            % do not report anything where closest centre > Emax + (Emin/2)
            if bestDist > Emax + (Emin/2) 
                cenTrajList = []; % empty list of centres since we are done
            else
                % add centre and supplemental traj in cluster to results
                if mType == 1
                    tmpTrajIDList = cell2mat(centerAndTraj(closeCenterTrajID,1));
                else
                    leafTrajIDList = [];
                    GetNodeLeafTraj(cenTrajList(closeCTIndex,2));
                    tmpTrajIDList = leafTrajIDList;
                end
                for j = 1:size(tmpTrajIDList,1) % now add each traj to results
                    kNNTrajList = [kNNTrajList; tmpTrajIDList(j)];
                    currNumK = currNumK + 1;
                    if currNumK == kNum % we have reached the k-limit, so do not add any more
                        cenTrajList = []; % empty list of centres since we are done
                        break
                    end 
                end 
                % remove centre from list
                if isempty(cenTrajList) == false
                    cenTrajList(closeCTIndex,:) = [];
                end
            end
        end  % end Phase three  
    end

    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(numCandCentre);
    queryTraj(k,10) = num2cell(numCFD);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell(kNNTrajList,size(kNNTrajList,1),size(kNNTrajList,2));
    queryTraj(k,13) = num2cell(size(kNNTrajList,1));
    
    if mod(k,10) == 0
        X = ['kNN Search 2 Old: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;