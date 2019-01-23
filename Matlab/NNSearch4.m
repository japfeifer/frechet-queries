% NN Search4 - returns the traj with the best approximation
% 

tic;

h = waitbar(0, 'NN Search4');

% for k = 19:19
for k = 1:size(queryTraj,1)  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    addError = 0;
    relError = 0;
    
    % call the pruning process to get candidate curves
    PruneTraj7(k);
    
    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);

    % only process if cenTrajList is not null
    if isempty(candTrajIDList) == false
        if size(candTrajIDList,1) == 1 % just one traj, so exact NN is found
            bestCenterTraj = candTrajIDList(1,1);
            bestDist = candTrajIDList(1,2); % just use the LB
        else % find traj with smallest error range
            candTrajIDList = sortrows(candTrajIDList,3,'ascend'); % sort asc by UB
            bestCenterTraj = candTrajIDList(1,1);
            bestDist = candTrajIDList(1,2); % just use the LB
            lUB = candTrajIDList(1,3); % lowest upper bound
            candTrajIDList = candTrajIDList(2:end,:); % delete the first traj
            candTrajIDList = sortrows(candTrajIDList,2,'ascend'); % sort asc by LB
            sLB = candTrajIDList(1,2); % smallest lower bound
            addError = lUB - sLB;
            relError = (lUB - sLB) / sLB;
        end
    else
        bestCenterTraj = [];
        bestDist = [];
    end
    
    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);       % 0 cluster centres
    queryTraj(k,10) = num2cell(0);      % numCFD
    queryTraj(k,11) = num2cell(0);      % numDP
    queryTraj(k,12) = mat2cell([bestCenterTraj bestDist],size([bestCenterTraj bestDist],1),size([bestCenterTraj bestDist],2));
    queryTraj(k,13) = num2cell(size(bestCenterTraj,1));
    queryTraj(k,14) = num2cell(addError);
    queryTraj(k,15) = num2cell(relError);
    
    if mod(k,10) == 0
        X = ['NN Search4: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;