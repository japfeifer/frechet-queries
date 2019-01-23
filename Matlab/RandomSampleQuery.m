% Randomly sample 1000 trajectories from the dataset and use those as
% queries.  Then remove the 1000 traj from the dataset

queryTraj = {[]};

% uniformly Randomly sample numQueryTraj number of trajectories from the dataset
[tmpQuery,tmpIndex] = datasample(trajData,numQueryTraj,'Replace',false);

% insert the sample traj into the Query data structure
for k = 1:numQueryTraj
    queryTraj(k,1) = tmpQuery(k,1);
    queryTraj(k,2) = tmpQuery(k,2);
end

% delete the sample traj from the dataset
trajData(tmpIndex, : ) = [];