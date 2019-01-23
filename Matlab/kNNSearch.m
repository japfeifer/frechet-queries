% kNN Search - absolute value approximation version
% 
% Execute the pruning process.  If num pruning results = kNum then we
% are done.  Otherwise, if numTrajInFinRes > 0, then add that number of
% traj to the final result set.  For the other traj in pruning results 
% perform a series of quadratic Frechet distance and Frechet decision 
% procedure computations. Figure out how many traj you have to add, and
% how many traj you have to delete. If add is smaller then add traj to the
% results, or if delete is smaller then delete traj from results, and stop
% when we reach kNum total results.


tic;

kNum = 5;

h = waitbar(0, 'kNN Search');

% for k=8:8
for k = 1:size(queryTraj,1)  % do kNN search for each query traj
    
    kNNTrajList = [];
    tmpTrajIDList = [];
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    currNumK = 0;
    
    % call the pruning process to get candidate curves
    [numTrajInFinRes,Emin] = PruneTraj6(k,kNum,Emin);

    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);

    if numCandCurve == kNum  % if the number of pruning results = k, then just return the candidate curves
    	numCFD = 0;
    	numDP = 0;
    	kNNTrajList = candTrajIDList(:,1);
    else
        if numTrajInFinRes > 0 % there are some traj from pruning that are definitely in the kNN result set
            currNumK = numTrajInFinRes;
            kNNTrajList = candTrajIDList(1:currNumK,1); % get the first currNumK traj
            candTrajIDList = candTrajIDList(currNumK+1:end,:); % delete first currNumK rows
        end
        
        numTrajAdd = kNum - numTrajInFinRes;
        numTrajDelete = numCandCurve - kNum;

        % put in -1 placeholder for exact Frechet distance
        candTrajIDList(:,4) = -1;

        % only process if cenTrajList is not null
        if isempty(candTrajIDList) == false

            if numTrajAdd <= numTrajDelete % it is more efficient to add traj 
%             if numTrajAdd <= Inf % test by only doing the add traj
                
                % sort candidate cluster centres by lower bound asc
                if isempty(candTrajIDList) == false
                    candTrajIDList = sortrows(candTrajIDList,2,'ascend');
                end

                % Find the closest traj and add it to the results, and then find 
                % the next closest traj, and do so until we reach the k limit or process all traj.
                while size(candTrajIDList,1) > 0

                    % first find closest centre
                    for i = 1:size(candTrajIDList,1)
                        centerTrajID = candTrajIDList(i,1);
                        currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                        if i == 1 % get CFD distance for first traj in list
                            if candTrajIDList(i,4) == -1
                                bestDist = ContFrechet(currQueryTraj,currTraj);
                                numCFD = numCFD + 1;
                                candTrajIDList(i,4) = bestDist;
                            else
                                bestDist = candTrajIDList(i,4);
                            end
                            closeCTIndex = i;
                            closeCenterTrajID = candTrajIDList(i,1);
                        else % check the next traj and see if it is closer
                            % only check if traj lower bound  < bestDist
                            if bestDist > candTrajIDList(i,2)
                                if candTrajIDList(i,4) >= 0 % the exact dist is already computed
                                    if bestDist > candTrajIDList(i,4) % curr traj is closer
                                        bestDist = candTrajIDList(i,4);
                                        closeCTIndex = i;
                                        closeCenterTrajID = candTrajIDList(i,1);
                                    end
                                else % the exact dist is not computed yet
                                    % first check the DP
                                    decProRes = FrechetDecide(currTraj,currQueryTraj,bestDist,1);
                                    numDP = numDP + 1;
                                    if decProRes == 1 % this traj is closer.  Get the CFD
                                        if candTrajIDList(i,4) == -1
                                            bestDist = ContFrechet(currQueryTraj,currTraj);
                                            numCFD = numCFD + 1;
                                            candTrajIDList(i,4) = bestDist;
                                        else
                                            bestDist = candTrajIDList(i,4);
                                        end
                                        closeCTIndex = i;
                                        closeCenterTrajID = candTrajIDList(i,1);
                                    end
                                end
                            end
                        end
                    end  

                    % add traj to results
                    kNNTrajList = [kNNTrajList; candTrajIDList(closeCTIndex,1)];

                    currNumK = currNumK + 1;
                    if currNumK == kNum % we have reached the k-limit, so do not add any more
                        candTrajIDList = []; % empty list of traj since we are done
                    end 

                    % remove centre from list
                    if isempty(candTrajIDList) == false
                        candTrajIDList(closeCTIndex,:) = [];
                    end
                end 
                
            else % it is more efficient to delete traj
                
                % sort candidate cluster centres by lower bound desc
                if isempty(candTrajIDList) == false
                    candTrajIDList = sortrows(candTrajIDList,2,'descend');
                end
                
                numTrajRemoved = 0;

                % Find the furthest traj and delete it, and then find 
                % the next furthest traj, and delete it, and do so until 
                % we have removed numTrajDelete number of traj. Then add the
                % remaining traj to the result set.
               
                while numTrajRemoved < numTrajDelete

                    % first find furthest centre
                    for i = 1:size(candTrajIDList,1)
                        centerTrajID = candTrajIDList(i,1);
                        currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
                        if i == 1 % get CFD distance for first traj in list
                            if candTrajIDList(i,4) == -1
                                bestDist = ContFrechet(currQueryTraj,currTraj);
                                numCFD = numCFD + 1;
                                candTrajIDList(i,4) = bestDist;
                            else
                                bestDist = candTrajIDList(i,4);
                            end
                            closeCTIndex = i;
                            closeCenterTrajID = candTrajIDList(i,1);
                        else % check the next traj and see if it is further
                            % only check if traj upper bound  > bestDist
                            if bestDist < candTrajIDList(i,3)
                                if candTrajIDList(i,4) >= 0 % the exact dist is already computed
                                    if bestDist < candTrajIDList(i,4) % curr traj is further
                                        bestDist = candTrajIDList(i,4);
                                        closeCTIndex = i;
                                        closeCenterTrajID = candTrajIDList(i,1);
                                    end
                                else % the exact dist is not computed yet
                                    % first check the DP
                                    decProRes = FrechetDecide(currTraj,currQueryTraj,bestDist,1);
                                    numDP = numDP + 1;
                                    if decProRes == 0 % this traj is further.  Get the CFD
                                        if candTrajIDList(i,4) == -1
                                            bestDist = ContFrechet(currQueryTraj,currTraj);
                                            numCFD = numCFD + 1;
                                            candTrajIDList(i,4) = bestDist;
                                        else
                                            bestDist = candTrajIDList(i,4);
                                        end
                                        closeCTIndex = i;
                                        closeCenterTrajID = candTrajIDList(i,1);
                                    end
                                end
                            end
                        end
                    end  
                    
                    % remove traj from list
                    if isempty(candTrajIDList) == false
                        candTrajIDList(closeCTIndex,:) = [];
                    end
                    
                    numTrajRemoved = numTrajRemoved + 1;
                end
                
                % add remaining traj to results
                kNNTrajList = [kNNTrajList; candTrajIDList(:,1)];
            end
        end
    end

    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);   % 0 cluster centres
    queryTraj(k,10) = num2cell(numCFD);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell(kNNTrajList,size(kNNTrajList,1),size(kNNTrajList,2));
    queryTraj(k,13) = num2cell(size(kNNTrajList,1));
    
    if mod(k,10) == 0
        X = ['kNN Search: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;