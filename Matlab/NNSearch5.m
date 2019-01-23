% NN Search 5 - additive value approximation version
% 
% Execute the pruning process and then potentially perform quadratic
% Frechet distance and Frechet decision procedure computations on the
% pruning result set.
%
% Same as NN Search, except this version tests the frechet dec proc
% for the curve with the Lowest LB, with the next lowest LB

tic;

h = waitbar(0, 'NN Search5');

% for k = 19:19
for k = 1:size(queryTraj,1)  % do NN search for each query traj
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
        
        if size(candTrajIDList,1) == 1 % only one traj
            foundTraj = true;
            bestCenterTraj = candTrajIDList(1,1);
            bestDist = candTrajIDList(1,2); % just put in the LB
        else % check frechet dec proc for the curve with the Lowest LB
            candTrajID2List = sortrows(candTrajIDList,2,'ascend'); % sort asc by LB
            secondLowestLB = candTrajID2List(2,2);
            currTraj = cell2mat(trajData(candTrajID2List(1,1),1));
            decProRes = FrechetDecide(currTraj,currQueryTraj,secondLowestLB,1);
            if decProRes == 1
                foundTraj = true;
                bestCenterTraj = candTrajID2List(1,1);
                bestDist = candTrajID2List(1,2); % just put in the LB
            end
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
                    % if the first traj CFD <= Emin then we are done
                    if bestDist <= Emin
                        foundTraj = true;
                        break;
                    end
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
                            % if the first traj CFD <= Emin then we are done
                            if bestDist <= Emin
                                foundTraj = true;
                                break;
                            end
                        end
                    end
                end
            end 
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
    
    if mod(k,10) == 0
        X = ['NN Search5: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;