% this dendrogram shows ball overlap (not the overlap measure we use in the paper)

nodeID = 1;
tmpCCTDepth = Inf;

tmpCCT = clusterNode;

% normalize cluster radius size
maxRad = tmpCCT(nodeID,4);
NormalizeClusterRad(nodeID,maxRad,1);

% get minimum cluster radius - required when plotting y-axis log scale line segments
lowClustRad = Inf;
GetMinClusterRad(nodeID,1); 

% update tmpCCT with radius overlap info
tmpCCT = [tmpCCT zeros(size(tmpCCT,1),1)]; % insert 0's to overlap distance column
dendroOverlapList = [];
GetDendrogramOverlap(nodeID,1);

maxRad = tmpCCT(nodeID,4); % get max radius
numTraj = tmpCCT(nodeID,5); % number of trajectories

figure;

GraphDendrogram(1,0,numTraj,1,0.3,0.7);

xlim([0 numTraj]);
ylim([lowClustRad 1]);
set(gca,'TickDir','out');
xlabel('Number of Trajectories');
ylabel('Cluster Radius Size (Normalized)');
hold off
