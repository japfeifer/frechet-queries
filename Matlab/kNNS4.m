% kNN Search 4 - Percent of reach

tic;

h = waitbar(0, 'kNN Search');
numQ = size(queryTraj,1);

for i = 1:numQ  % do kNN search for each query traj
    
    searchStat = [];
    
    % get reach
    currQueryTraj = cell2mat(queryTraj(i,1));
    currReach = TrajReach(currQueryTraj);
    eVal = eMult * currReach;
    
    kNN(i,4,kNum,eVal);

    if mod(i,100) == 0
        X = ['kNN Search: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/numQ*1000)]);