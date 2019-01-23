% Cluster Centre Tree Algo 1
%
% The CCT is an unbalanced binary tree. Each node represents a cluster with
% a centre traj and associated traj, and has a radius (traj with furthest
% distance to centre traj).  The top node contains all traj.  Subsequent
% child nodes contain subsets of traj.  Leaf nodes contain a single traj.
% 
% For the root node, randomly choose a traj as the centre and compute the 
% Frechet dist from other traj to the centre traj.  Determine the furthest 
% traj from the centre, and it's distance to the centre becomes the node radius.   
% Then recursively split the node into two clusters - one with the existing
% centre and one with the furthest traj as the new centre.

tic;
h = waitbar(0, 'Build Cluster');

totalTraj = size(trajData,1);  % get number of trajectories to process
totNode = (totalTraj * 2) - 1;  % calc total nodes
currMatrixInsert = 0;
trajFactor = 0;
centerTrajId = 0;
newCenterTraj = [];
j = 0;
currDist = 0;
currTraj = [];
numDistCalls = 0;
numDecisionCalls = 0;
numCFD = 0;
numDP = 0;
numTrajCheck = 0;
numDecNewCalls = 0;
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
% compare distance from center traj to all other traj
for j = 1:totalTraj 
    if j == centerTrajId % we are comparing the traj to itself
        currDist = 0;
    else
        currTraj = cell2mat(trajData(j,1)); 
        
        upBnd = GetBestUpperBound(currTraj,newCenterTraj,2,j,centerTrajId);
        lowBnd = GetBestLowerBound(currTraj,newCenterTraj,Inf,2,j,centerTrajId);
        if upBnd == lowBnd % we have the Continuous Frechet dist
            currDist = upBnd;
        else  
            if doDFD == true
                currDist = DiscreteFrechetDist(newCenterTraj,currTraj);
            else
                currDist = ContFrechet(newCenterTraj,currTraj);
            end
            numCFD = numCFD + 1;
        end
    end  
    trajDistList = [trajDistList; j currDist];
end

% get max Rsize and associated traj ID
[largestRSize,tmpIndex] = max(trajDistList(:,2));
furthestTrajID = trajDistList(tmpIndex,1);

% save info to clusterNode
currNodeID = 1;
clusterNode(currNodeID,:) = [0 0 0 largestRSize totalTraj centerTrajId furthestTrajID];

X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode), ...
    ' Num CFD: ',num2str(numCFD)];
waitbar(currNodeID/totNode, h, X);

% now call function to recursively split node into 2-k clusters
SplitNode(currNodeID,trajDistList);

disp(['------------------']);
disp(['numCFD: ',num2str(numCFD)]);
disp(['numDP: ',num2str(numDP)]);

close(h);
timeElapsed = toc;