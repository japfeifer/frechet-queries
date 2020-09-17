% Construct CCT using approximate radii (upper bounds)
%

tic;
h = waitbar(0, 'Build Cluster');

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

if totNode > 0
    clusterNode(totNode,7) = 0;
    clusterTrajNode(totalTraj,1) = 0;
    trajDistList(1:totalTraj,1) = 0;
    trajDistList(1:totalTraj,2) = 0;

    % randomly choose a traj as the first center
    % centerTrajId = randi(totalTraj,1);

    % for testing purposes hardcode the first center ID so that it is easy to do
    % comparisons of code changes and recreate the same output 
    centerTrajId = 1;
    
%     centerTrajId = 13; % for hurdat2 dataset

    newCenterTraj = cell2mat(trajData(centerTrajId,1));

    h2 = waitbar(0, 'Initial Split');
    
    % process top node cluster
    % compare UB distance from center traj to all other traj
    for j = 1:totalTraj 
        if j == centerTrajId % we are comparing the traj to itself
            upBnd = 0;
        else
            currTraj = cell2mat(trajData(j,1)); 
            upBnd = GetBestUpperBound(currTraj,newCenterTraj,2,j,centerTrajId);
        end  
        trajDistList(j,:) = [j upBnd];
        
        if mod(j,100000) == 0
            X = ['Initial Split ',num2str(j),'/',num2str(totalTraj)];
            waitbar(j/totalTraj, h2, X);
        end
    
    end
    
    close(h2);

    % get max Rsize and associated traj ID
    [largestRSize,tmpIndex] = max(trajDistList(:,2));
    furthestTrajID = trajDistList(tmpIndex,1);

    % save info to clusterNode
    currNodeID = 1;
    clusterNode(currNodeID,:) = [0 0 0 largestRSize totalTraj centerTrajId furthestTrajID];

    X = ['Build Cluster ',num2str(currNodeID),'/',num2str(totNode)];
    waitbar(currNodeID/totNode, h, X);

    % now call function to recursively split node into 2-k clusters
    SplitNodeApproxRadii(currNodeID,trajDistList);

end

close(h);
timeElapsed = toc;
disp(['Runtime per trajectory (ms): ',num2str(timeElapsed/totalTraj*1000)]);