% NN Search - Old version
% This is an original version that uses pruning threshold Emax
% This version is NOT used in experiments, since later versions do not
% require the threshold Emax

tic;

mType = 2; % Cluster data structure Method type, can be 1 or 2

h = waitbar(0, 'NN Search');

for k = 1:size(queryTraj,1)  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    numCandCentre = 0;
    foundTraj = false;
    candNodeList = [];
    
    % call the pruning process to get candidate curves
    PruneTraj(k);
    
    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);

    if mType == 1
        % determine the k-size cluster group to search
        kSize = 0;
        curveClusterIndex = 0;
        for i = 1:size(clusterGroup,1)       
            if Emin >= cell2mat(clusterGroup(i,2)) % this is the best cluster group to search
                kSize = cell2mat(clusterGroup(i,1));
                curveClusterIndex = i;
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
            cenTrajList = [cenTrajList; centerTrajID, upBnd, lowBnd];
        end
    end
    
    if mType == 2
        % find unique candidate cluster nodes
        for i = 1:size(candTrajIDList,1)
            iNodeID = GetBestNode(candTrajIDList(i), Emin);
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
            cenTrajList = [cenTrajList; centerTrajID, upBnd, lowBnd];
        end
    end

    numCandCentre = size(cenTrajList,1);
    
    % only process if cenTrajList is not null
    if isempty(cenTrajList) == false
        
        % see if any upBnd <= Emin, if yes then we found a NN
        for i = 1:size(cenTrajList,1)
            if cenTrajList(i,2) <= Emin
                bestCenterTraj = cenTrajList(i,1);
                bestDist = cenTrajList(i,2);
                foundTraj = true;
                break;
            end
        end

        % We may be able to reduce the size of cenTrajList.
        % Find the lowest upper bound, lub.  If lub is <= the lower bound on
        % curr traj, then we can delete the curr traj from the list.
        tmpCenTrajList = [];
        cenTrajList2 = cenTrajList;
        if foundTraj == false
            % sort cenTrajList upper bound descending and get the lub
            cenTrajList = sortrows(cenTrajList,2,'ascend');
            lub = cenTrajList(1,2);
            for i = 1:size(cenTrajList,1)
                if i == 1 % this is the lub traj so save this one
                    tmpCenTrajList = [tmpCenTrajList; cenTrajList(i,:)];
                else
                    if lub > cenTrajList(i,3) % then we must keep this traj
                        tmpCenTrajList = [tmpCenTrajList; cenTrajList(i,:)];
                    end
                end
            end
            cenTrajList = tmpCenTrajList;
            % if there is only one traj, then we found a NN
            if size(cenTrajList,1) == 1
                bestCenterTraj = cenTrajList(1,1);
                bestDist = cenTrajList(1,2);
                foundTraj = true;
                % if upper bound > Emax+Emin then we have to check the CFD
                % to ensure that the traj is within the Emax+Emin threshold
                if bestDist > Emax+Emin
                    currTraj = cell2mat(trajData(bestCenterTraj,1)); % get center traj
                    bestDist = ContFrechet(currQueryTraj,currTraj);
                    numCFD = numCFD + 1;
                end
            end
        end

        % if we haven't found a NN then we have to use more expensive CFD and
        % frechet decision procedure computations
        if foundTraj == false
            for i = 1:size(cenTrajList,1)
                centerTrajID = cenTrajList(i,1);
                currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                if i == 1
                    % this is first traj we check, so just get the CFD
                    bestDist = ContFrechet(currQueryTraj,currTraj);
                    numCFD = numCFD + 1;
                    bestCenterTraj = centerTrajID;
                    % if the first traj CFD <= Emin then we are done
                    if bestDist <= Emin
                        foundTraj = true;
                        break;
                    end
                else % i >= 2
                    % call frechet decision procedure
                    decProRes = FrechetDecide(currTraj,currQueryTraj,bestDist,1);
                    numDP = numDP + 1;
                    if decProRes == 1 % then curr traj is closer, so get CFD dist
                        bestDist = ContFrechet(currQueryTraj,currTraj);
                        numCFD = numCFD + 1;
                        bestCenterTraj = centerTrajID;
                        % if the first traj CFD <= Emin then we are done
                        if bestDist <= Emin
                            foundTraj = true;
                            break;
                        end
                    end
                end
            end 
        end

        if bestDist > Emax+Emin % we do not want to report if dist > Emax+Emin
            bestCenterTraj = [];
            bestDist = [];
        end
    
    else
        bestCenterTraj = [];
        bestDist = [];
    end
    
    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(numCandCentre);
    queryTraj(k,10) = num2cell(numCFD);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell([bestCenterTraj bestDist],size([bestCenterTraj bestDist],1),size([bestCenterTraj bestDist],2));
    queryTraj(k,13) = num2cell(size(bestCenterTraj,1));
    
    if mod(k,10) == 0
        X = ['NN Search ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;