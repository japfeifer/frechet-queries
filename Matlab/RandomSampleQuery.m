% Randomly sample 1000 trajectories from the dataset and use those as
% queries.  Then remove the 1000 traj from the dataset

queryStrData = [];

% uniformly Randomly sample numQueryTraj number of trajectories from the dataset
[tmpQuery,tmpIndex] = datasample(trajStrData,numQueryTraj,'Replace',false);

% insert the sample traj into the Query data structure
for k = 1:numQueryTraj
    queryStrData(k).traj = tmpQuery(k).traj;
    queryStrData(k).se = tmpQuery(k).se;
end

% delete the sample traj from the dataset
trajStrData(tmpIndex) = [];