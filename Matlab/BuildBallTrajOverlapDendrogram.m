% this dendrogram shows traj that are within ball overlap region (not the overlap measure we use in the paper)

% ********* must load in tmpCCT first, before running this script **********

nodeID = 1;
tmpCCTDepth = 27;

% normalize cluster radius size
maxRad = tmpCCT(nodeID,4);
NormalizeClusterRad(nodeID,maxRad,1);

% get minimum cluster radius - required when plotting y-axis log scale line segments
lowClustRad = Inf;
GetMinClusterRad(nodeID,1); 

maxRad = tmpCCT(nodeID,4); % get max radius
numTraj = tmpCCT(nodeID,5); % number of trajectories

figure;

GraphDendrogram(1,0,numTraj,1,0.30,0.70);

xlim([0 numTraj]);
ylim([lowClustRad 1]);
set(gca,'TickDir','out');
xlabel('Number of Trajectories');
ylabel('Cluster Radius Size (Normalized)');
hold off
