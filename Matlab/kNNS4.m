% kNN Search 4 - Percent of reach

tic;

h = waitbar(0, 'kNN Search');
numQ = size(queryStrData,2);

for i = 1:numQ  % do kNN search for each query traj
    
    searchStat = [];
    
    % get reach
    currQueryTraj = queryStrData(i).traj;
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