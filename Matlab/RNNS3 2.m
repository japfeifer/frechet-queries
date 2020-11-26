% RNN Search 3 - Implicit Error

tic;

h = waitbar(0, 'RNN Search');
numQ = size(queryTraj,1);

for i = 1:numQ  % do RNN search for each query traj
    
    RNN(i,3,tau,0);

    if mod(i,100) == 0
        X = ['RNN Search: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/numQ*1000)]);