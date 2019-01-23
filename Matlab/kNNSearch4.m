% kNN Search4 - returns the trajectories with the best approximation

tic;

kNum = 5;

h = waitbar(0, 'kNN Search4');

% for k=8:8
for k = 1:size(queryTraj,1)  % do kNN search for each query traj
    
    kNNTrajList = [];
    tmpTrajIDList = [];
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    addError = 0;
    relError = 0;
    
    % call the pruning process to get candidate curves
    [numTrajInFinRes] = PruneTraj8(k,kNum);

    currQueryTraj = cell2mat(queryTraj(k,1));
    candTrajIDList = cell2mat(queryTraj(k,7));  % Candidate traj list
    numCandCurve = size(candTrajIDList,1);
    numCFD = 0;
    numDP = 0;

    if numCandCurve == kNum  % if the number of pruning results = k, then just return the candidate curves
    	kNNTrajList = candTrajIDList(:,1);
    else
        candTrajIDList = sortrows(candTrajIDList,3,'ascend'); % sort asc by UB
        kNNTrajList = candTrajIDList(1:kNum,1); % kNN result set is first k traj in list
        lUB = candTrajIDList(kNum,3); % lowest upper bound
        candTrajIDList = candTrajIDList(kNum+1:end,:); % delete the first k traj
        candTrajIDList = sortrows(candTrajIDList,2,'ascend'); % sort asc by LB
        sLB = candTrajIDList(1,2); % smallest lower bound
        addError = lUB - sLB;
        relError = (lUB - sLB) / sLB;
    end

    % save info on query
    queryTraj(k,8) = num2cell(numCandCurve);
    queryTraj(k,9) = num2cell(0);   % 0 cluster centres
    queryTraj(k,10) = num2cell(numCFD);
    queryTraj(k,11) = num2cell(numDP);
    queryTraj(k,12) = mat2cell(kNNTrajList,size(kNNTrajList,1),size(kNNTrajList,2));
    queryTraj(k,13) = num2cell(size(kNNTrajList,1));
    queryTraj(k,14) = num2cell(addError);
    queryTraj(k,15) = num2cell(relError);
    
    if mod(k,10) == 0
        X = ['kNN Search4: ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;