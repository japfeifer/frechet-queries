% RNN Search - absolute value approximation version
% 
% Execute the pruning process and then potentially perform quadratic
% Frechet decision procedure computations on the pruning result set.

tic;

h = waitbar(0, 'RNN Search');

% for k = 1:50
for k = 1:size(queryTraj,1)  % do NN search for each query traj
    
    rangeTrajList = [];
    numDP = 0;
    numCFD = 0;
    numCandCurve = 0;
    
    % call the pruning process to get candidate curves
    PruneTraj(k);

    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);

    % loop thru each traj and see if it can go into the result set
    for i = 1:size(candTrajIDList,1)
        centerTrajID = candTrajIDList(i,1);
        currTraj = cell2mat(trajData(centerTrajID,1)); % get center traj 
        if candTrajIDList(i,3) <= Emax + Emin % upper bound < Emax + Emin
            rangeTrajList = [rangeTrajList; candTrajIDList(i,:)];
        else % check frechet decision procedure
            decProRes = FrechetDecide(currTraj,currQueryTraj,Emax + Emin,1);
            numDP = numDP + 1;
            if decProRes == 1 % CFD is <= Emax + Emin
                rangeTrajList = [rangeTrajList; candTrajIDList(i,:)];
            end
        end
    end

    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);
    queryTraj(k,10) = num2cell(0);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell(rangeTrajList,size(rangeTrajList,1),size(rangeTrajList,2));
    queryTraj(k,13) = num2cell(size(rangeTrajList,1));
    
    if mod(k,10) == 0
        X = ['RNN Search: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;