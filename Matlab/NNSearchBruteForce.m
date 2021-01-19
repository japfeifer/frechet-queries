% NN Search Brute Force exact search

tic;

numCandCurve = size(trajStrData,2);

h = waitbar(0, 'NN Search');
numQ = size(queryStrData,2);

for i = 1:numQ  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = Inf;
    numCFD = numCandCurve;
    numDP = 0;

    currQueryTraj = queryStrData(i).traj;

    for j = 1:numCandCurve % do Cont Frechet dist call on each input traj
        currTraj = trajStrData(j).traj; % get center traj 
%         currDist = ContFrechet(currQueryTraj,currTraj,2,0);  % cont frechet dist
        currDist = FrechetDistBringmann(currQueryTraj,currTraj);  % cont frechet dist
        if currDist < bestDist
            bestDist = currDist;
            bestCenterTraj = j;
        end
    end
    
    % save info on query
    queryStrData(i).prunes1 = numCandCurve;
    queryStrData(i).prunes1sz = 0;
    queryStrData(i).decidecfdcnt = numCFD;
    queryStrData(i).decidedpcnt = numDP;
    queryStrData(i).decidetrajids = bestCenterTraj;
    queryStrData(i).decidetrajcnt = size(bestCenterTraj,1);

    if mod(i,20) == 0
        X = ['NN Search: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/i*1000)]);