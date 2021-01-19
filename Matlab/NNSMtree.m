% NN Search using M-tree data structure - exact search only using the
% Frechet distance measure (no bounds are used)

tic;

h = waitbar(0, 'NN Search M-tree');
numQ = size(queryStrData,2);

for i = 1:numQ  % do NN search for each query traj
    if mod(i,100) == 0
        X = ['NN Search M-tree: ',num2str(i),'/',num2str(numQ)];
        waitbar(i/numQ, h, X);
    end
    
    NNMtree(i);
end

close(h);
timeElapsed = toc;
disp(['Query latency runtime (milli-seconds per query): ',num2str(timeElapsed/numQ*1000)]);