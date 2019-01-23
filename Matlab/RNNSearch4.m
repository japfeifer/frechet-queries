% RNN Search4 - returns all trajectories where LB <= Emax, and capture approximation factor 

tic;

h = waitbar(0, 'RNN Search4');

% for k = 1:50
for k = 1:size(queryTraj,1)  % do NN search for each query traj
    
    rangeTrajList = [];
    numDP = 0;
    numCandCurve = 0;
    addError = 0;
    relError = 0;
    
    % call the pruning process to get candidate curves
    PruneTraj(k);

    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);
    
    if isempty(candTrajIDList) == false % compute error bounds
        candTrajIDList = sortrows(candTrajIDList,3,'ascend'); % sort asc by UB
        rangeTrajList = candTrajIDList;
        hUB = candTrajIDList(numCandCurve,3); % highest upper bound
        addError = hUB - Emax;
        relError = (hUB - Emax) / Emax;
    end

    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);
    queryTraj(k,10) = num2cell(0);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell(rangeTrajList,size(rangeTrajList,1),size(rangeTrajList,2));
    queryTraj(k,13) = num2cell(size(rangeTrajList,1));
    queryTraj(k,14) = num2cell(addError);
    queryTraj(k,15) = num2cell(relError);
    
    if mod(k,10) == 0
        X = ['RNN Search4: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;