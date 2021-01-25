% Brute-force distance comparison on candidate curve results.  Note that this
% step is not required for queries, but is used for informational
% purposes in the experiment

tic;

h = waitbar(0, 'Calc Exact Dist');
candIdList = [];

for k = 1:50
% for k = 1:numQueryTraj
    
    % Do brute-force dist comparison from query to traj 
    
    candIdList = cell2mat(queryTraj(k,7));
    
    if isempty(candIdList) == false 
        Q = cell2mat(queryTraj(k,1));
        currDistList = [];
        for j = 1:size(candIdList,1)  % compare query traj to all traj in dataset
            P = trajStrData(candIdList(j,1)).traj;
%             % calc using continuous frechet
            currDist = ContFrechet(Q,P);           
            currDistList = cat(1,currDistList, [candIdList(j,1), currDist]);
        end 

        currDistList = sortrows(currDistList,2);
        queryTraj(k,6) = mat2cell(currDistList,size(currDistList,1),[2]);
    end
    
    if mod(k,10) == 0
        X = ['Calc Exact Dist ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end
close(h);
timeElapsed = toc;