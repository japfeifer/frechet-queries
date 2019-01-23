% Cluster Centre Tree Algo 1
%
% The top node
% contains one center with all trajectories.  The top node is broken into 2
% k-clusters which are represented by it's children nodes.  Each node is 
% treated as a new set of sub-trajectories which are broken into 2 children 
% nodes.  This process is done recursively to lower levels in the tree.
% The leaf nodes contain just one trajectory.
% Works for N-dimensional trajectories

tic;
h = waitbar(0, 'Build Cluster');

totalTraj = 0;
currMatrixInsert = 0;
trajFactor = 0;
maxMatrixInsert = 0;
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
clusterNode = {[]};
clusterTrajNode = {[]};
tmpIndex = 0;
totNode = 0;

% get number of trajectories to process
totalTraj = size(trajData,1);

% calc total nodes
totNode = (totalTraj * 2) - 1;

% randomly choose a traj as the first center
% centerTrajId = randi(totalTraj,1);

% for testing purposes hardcode the first center ID so that it is easy to do
% comparisons of code changes and recreate the same output 
centerTrajId = randi(totalTraj,1);
% centerTrajId = 1;

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
clusterNode(currNodeID,1) = num2cell(0);  % node parent ID
clusterNode(currNodeID,2) = num2cell(0);  % node child 1 ID
clusterNode(currNodeID,3) = num2cell(0);  % node child 2 ID
clusterNode(currNodeID,4) = num2cell(largestRSize);  % Rsize
clusterNode(currNodeID,5) = num2cell(totalTraj);  % Number of traj
clusterNode(currNodeID,6) = num2cell(centerTrajId); % center traj ID
clusterNode(currNodeID,7) = num2cell(furthestTrajID); % furthest traj ID

X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode), ...
    ' Num CFD: ',num2str(numCFD)];
waitbar(currNodeID/totNode, h, X);

% now call function to recursively split node into 2-k clusters
SplitNodeRand(currNodeID,trajDistList);

disp(['------------------']);
disp(['numCFD: ',num2str(numCFD)]);
disp(['numDP: ',num2str(numDP)]);

close(h);
timeElapsed = toc;