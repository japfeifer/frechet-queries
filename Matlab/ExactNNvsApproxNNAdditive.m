% Experiment to compare percent of queries where the approx NN equals the
% exact NN.
%
% NN Search - does not need the tau threshold
% absolute value additive error approximation version - set eAdd directly

tic;

h = waitbar(0, 'Exact vs Approx');

% for k = 1:100
for k = 1:size(queryTraj,1)  % do NN search for each query traj
    
    % do approx NN search first
    
    bestCenterTraj = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    
    NN(k,1,eAdd); % approx NN search

%%%%%%%%%%%%%
% have to modify code below
%%%%%%%%%%%%%%%
    
    queryTraj(k,12) = mat2cell([bestCenterTraj bestDist],size([bestCenterTraj bestDist],1),size([bestCenterTraj bestDist],2));
    queryTraj(k,13) = num2cell(size(bestCenterTraj,1));
    
    NN(k,1,0); % exact NN search
    
%%%%%%%%%%%%%
% have to modify code below
%%%%%%%%%%%%%%%

    queryTraj(k,15) = mat2cell([bestCenterTraj bestDist],size([bestCenterTraj bestDist],1),size([bestCenterTraj bestDist],2));
    queryTraj(k,13) = num2cell(size(bestCenterTraj,1));
    
    if mod(k,10) == 0
        X = ['Exact vs Approx: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;