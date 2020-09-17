% NN Search 1 - Additive Error

tic;

h = waitbar(0, 'NN Search');
numQ = size(queryTraj,1);

for i = 1:numQ  % do NN search for each query traj
    
    linLBcnt = 0; linUBcnt = 0; conLBcnt = 0; timeConstLB = 0; timeLinLB = 0; timeLinUB = 0; 
    
    NN(i,1,eAdd);

    if mod(i,100) == 0
        X = ['NN Search: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/numQ*1000)]);