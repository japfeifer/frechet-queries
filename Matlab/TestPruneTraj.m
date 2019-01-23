% NN Search

tic;

h = waitbar(0, 'Prune Test');

for k = 1:size(queryTraj,1)  % do NN search for each query traj
    
    % call the pruning process to get candidate curves
    PruneTraj(k);
     
    if mod(k,10) == 0
        X = ['Prune Test ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;