% kNN Search 2 - Multiplicative Error

tic;

h = waitbar(0, 'kNN Search');
numQ = size(queryTraj,1);

for i = 1:numQ  % do kNN search for each query traj
    
    searchStat = [];
    
    kNN(i,2,kNum,eMult);

    if mod(i,100) == 0
        X = ['kNN Search: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/numQ*1000)]);