% NN Search Brute Force exact search

tic;

numCandCurve = size(trajData,1);

for k = 1:10
% for k = 1:size(queryTraj,1)  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = Inf;
    numCFD = numCandCurve;
    numDP = 0;

    currQueryTraj = cell2mat(queryTraj(k,1));

    for i = 1:numCandCurve
        currTraj = cell2mat(trajData(i,1)); % get center traj 
        currDist = ContFrechet(currQueryTraj,currTraj,1,0);  % cont frechet, do not use up/low bounds
        if currDist < bestDist
            bestDist = currDist;
            bestCenterTraj = i;
        end
    end
    
    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);
    queryTraj(k,10) = num2cell(numCFD);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell([bestCenterTraj bestDist],size([bestCenterTraj bestDist],1),size([bestCenterTraj bestDist],2));
    queryTraj(k,13) = num2cell(size(bestCenterTraj,1));
    
end

timeElapsed = toc;