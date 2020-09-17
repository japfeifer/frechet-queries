% kNN Search using M-tree data structure - exact search only using the
% Frechet distance measure (no bounds are used)

tic;

h = waitbar(0, 'kNN Search M-tree');
numQ = size(queryTraj,1);

for i = 1:numQ  % do NN search for each query traj
    if mod(i,100) == 0
        X = ['kNN Search M-tree: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
    
    kNNMtree(i,kNum);
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/numQ*1000)]);