% Cluster Centre Tree Algo 2
%
% Method 2b build cluster - build clusters with a tree.  The top node
% contains one center with all trajectories.  The top node is broken into 2
% k-clusters which are represented by it's children nodes.  Each node is 
% treated as a new set of sub-trajectories which are broken into 2 children 
% nodes.  This process is done recursively to lower levels in the tree.
% The leaf nodes contain just one trajectory.
% Works for N-dimensional trajectories.
%
% This differs from Method2BuildCluster2 in that this version doesn't
% automatically determine frechet distances to the new center, but rather
% uses upper/lower bounds and the frechet decision procedure to try and
% figure out what center the traj belongs to.

tic;
h = waitbar(0, 'Build Cluster');

totalTraj = size(trajData,1);  % get number of trajectories to process
totNode = (totalTraj * 2) - 1;  % calc total nodes
currMatrixInsert = 0;
trajFactor = 0;
maxMatrixInsert = 0;
centerTrajId = 0;
j = 0;
currDist = 0;
currTraj = [];
numCFD = 0;
numDP = 0;
largestRSize = 0;
furthestTrajID = 0;
currNodeID = 0;
trajDistList = [];
clusterNode = [];
clusterTrajNode = [];

clusterNode(totNode,7) = 0;
clusterTrajNode(totalTraj,1) = 0;

% randomly choose a traj as the first center
% centerTrajId = randi(totalTraj,1);

% for testing purposes hardcode the first center ID so that it is easy to do
% comparisons of code changes and recreate the same output 
centerTrajId = 1;

% create the initial list of traj that belong to the center
trajDistList = [1:totalTraj]'; % all traj id's

% call proc to get max Rsize and associated traj ID
[furthestTrajID,largestRSize] = GetFurthestTraj(centerTrajId,trajDistList);

% save info to clusterNode
currNodeID = 1;
clusterNode(currNodeID,:) = [0 0 0 largestRSize totalTraj centerTrajId furthestTrajID];

X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode), ...
    ' Num CFD: ',num2str(numCFD)];
waitbar(currNodeID/totNode, h, X);

% now call function to recursively split node into 2-k clusters
SplitNode2(currNodeID,trajDistList);

disp(['------------------']);
disp(['numCFD: ',num2str(numCFD)]);
disp(['numDP: ',num2str(numDP)]);

close(h);
timeElapsed = toc;