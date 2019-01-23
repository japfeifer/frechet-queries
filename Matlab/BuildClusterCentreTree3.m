% Cluster Centre Tree Algo 3
%
% Build the CCT with 0 Frechet distance computations.  Use upper
% bounds.  First, choose an arbitrary center C(c).  Then, find the traj F
% with the largest uppoer bound. For other trajectories P, determine if it
% is closer to C(c) or F by computing the upper bound.  Recurse on C(c) and
% F.

tic;
h = waitbar(0, 'Build Cluster 3');

totalTraj = size(trajData,1);  % get number of trajectories to process
totNode = (totalTraj * 2) - 1;  % calc total nodes
centerTrajId = 0;
newCenterTraj = [];
j = 0;
currTraj = [];
largestRSize = 0;
furthestTrajID = 0;
currNodeID = 0;
trajDistList = [];
clusterNode = [];
clusterTrajNode = [];
tmpIndex = 0;

clusterNode(totNode,7) = 0;
clusterTrajNode(totalTraj,1) = 0;

% randomly choose a traj as the first center
% centerTrajId = randi(totalTraj,1);

% for testing purposes hardcode the first center ID so that it is easy to do
% comparisons of code changes and recreate the same output 
centerTrajId = 1;

newCenterTraj = cell2mat(trajData(centerTrajId,1));

% process top node cluster
% compare UB distance from center traj to all other traj
for j = 1:totalTraj 
    if j == centerTrajId % we are comparing the traj to itself
        upBnd = 0;
    else
        currTraj = cell2mat(trajData(j,1)); 
        upBnd = GetBestUpperBound(currTraj,newCenterTraj,2,j,centerTrajId);
    end  
    trajDistList(end+1,:) = [j upBnd];
end

% get max Rsize and associated traj ID
[largestRSize,tmpIndex] = max(trajDistList(:,2));
furthestTrajID = trajDistList(tmpIndex,1);

% save info to clusterNode
currNodeID = 1;
clusterNode(currNodeID,:) = [0 0 0 largestRSize totalTraj centerTrajId furthestTrajID];

X = ['Build Cluster 3 ',num2str(currNodeID),'/',num2str(totNode)];
waitbar(currNodeID/totNode, h, X);

% now call function to recursively split node into 2-k clusters
SplitNode3(currNodeID,trajDistList);

close(h);
timeElapsed = toc;