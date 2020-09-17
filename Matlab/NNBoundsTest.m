% NNBoundsTest - tests the effectiveness of the various upper and lower
% bounds on curves that are close.  It performs a NN search on a query traj
% and compares the bounds between the query traj and NN traj.

tic;

mType = 2; % Cluster data structure Method type, can be 1 or 2

h = waitbar(0, 'NN Bounds Test');

for k = 1:size(queryTraj,1)  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    foundTraj = false;
    
    NN(k,1,0); % get exact NN

    % now do test on the bounds
    currTraj = cell2mat(trajData(bestCenterTraj,1)); % get center traj 
    CalcLBUBTest(k,currTraj,currQueryTraj,1,bestCenterTraj,k);
    
    if mod(k,10) == 0
        X = ['NN Bounds Test: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;