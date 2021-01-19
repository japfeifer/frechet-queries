% Construct CCT using exact radii build with Partial Gonzalez ('lite')
%

tic;
h = waitbar(0, 'Build Cluster');

totalTraj = size(trajStrData,2);  % get number of trajectories to process
totNode = (totalTraj * 2) - 1;  % calc total nodes
numCFD = 0;
numDP = 0;
largestRSize = 0;
furthestTrajID = 0;
currNodeID = 0;
trajDistList = [];
clusterNode = [];
clusterTrajNode = [];

numFurthestCFD = 0;
numSplitCFD = 0;

if totNode > 0
    clusterNode(totNode,7) = 0;
    clusterTrajNode(totalTraj,1) = 0;

    % randomly choose a traj as the first center
    % centerTrajId = randi(totalTraj,1);

    % for testing purposes hardcode the first center ID so that it is easy to do
    % comparisons of code changes and recreate the same output 
    centerTrajId = 1;
    
%     centerTrajId = 13; % for hurdat2 dataset

    % create the initial list of traj that belong to the center
    trajDistList = [1:totalTraj]'; % all traj id's
    trajDistList = [trajDistList ones(totalTraj,1)*-1 ones(totalTraj,1)*-1 ones(totalTraj,1)*-1];

    % call proc to get max Rsize and associated traj ID
    [furthestTrajID,largestRSize,trajDistList] = GetFurthestTrajGonzLite(centerTrajId,trajDistList);

    % save info to clusterNode
    currNodeID = 1;
    clusterNode(currNodeID,:) = [0 0 0 largestRSize totalTraj centerTrajId furthestTrajID];

    X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode), ...
        ' Num CFD: ',num2str(numCFD)];
    waitbar(currNodeID/totNode, h, X);

    % now call function to recursively split node into 2-k clusters
    SplitNodeGonzLite(currNodeID,trajDistList);

end 

disp(['------------------']);
disp(['numCFD: ',num2str(numCFD)]);
disp(['numDP: ',num2str(numDP)]);
disp(['numSplitCFD: ',num2str(numSplitCFD)]);
disp(['numFurthestCFD: ',num2str(numFurthestCFD)]);

close(h);
timeElapsed = toc;

disp(['Runtime per trajectory (ms): ',num2str(timeElapsed/totalTraj*1000)]);