% this dendrogram shows the overlap measure we use in the paper - parent
% nodes that overlap each of the leafs.

nodeID = 1;
tmpCCTDepth = Inf;

tmpCCT = clusterNode;

GetCCTTrajOverlap(); % compute the overlap measure for each of the leafs (trajectories)

% normalize cluster radius size
maxRad = tmpCCT(nodeID,4);
NormalizeClusterRad(nodeID,maxRad,1);

% get minimum cluster radius - required when plotting y-axis log scale line segments
lowClustRad = Inf;
GetMinClusterRad(nodeID,1); 
lowClustRad = lowClustRad/2; % make this variable smaller so that the traj with the smallest radius is still graphed

maxRad = tmpCCT(nodeID,4); % get max radius
numTraj = tmpCCT(nodeID,5); % number of trajectories

cmap = gray(256);
cmap = cmap(29:256-28,:); % get the middle 200 colors
cmap = flipud(cmap);

figure;
colormap(cmap);
GraphLeafOverlapDendrogram(1,0,numTraj,1,0.2,0.4,cmap);

% xlim([0 numTraj]);
ax = gca;
ax.FontSize = 22; 
xlim([-1 numTraj + 1]);
ylim([lowClustRad 1]);
set(gca,'TickDir','out');
xlabel('Trajectory ID','FontSize',22);
ylabel('Cluster Radius (Normalized)','FontSize',22);

colorbar;
yyaxis right;
ylabel('Overlap of Leaf','FontSize',22,'Color','k');
set(gca,'YTick', [])
hold off
