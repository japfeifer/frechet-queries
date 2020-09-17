% construct the dendrogram in black and white format

Qid = 1;
kNum = 2;
nodeID = 1;
tmpCCTDepth = Inf;

PreprocessQuery(Qid);
GetkNNStat(Qid,kNum);

% normalize cluster radius size
maxRad = tmpCCT(nodeID,4);
NormalizeClusterRad(nodeID,maxRad,1);

% get minimum cluster radius - required when plotting y-axis log scale line segments
lowClustRad = Inf;
GetMinClusterRad(nodeID,1); 

maxRad = tmpCCT(nodeID,4); % get max radius
numTraj = tmpCCT(nodeID,5); % number of trajectories

figure;

GraphkNNDendrogram1(1,0,numTraj,1,[0.7,0.7,0.7],':'); % graph all dendrogram
GraphkNNDendrogram2(1,0,numTraj,1,[0.5,0.5,0.5],'-'); % just graph nodes that were visited
GraphkNNDendrogram3(1,0,numTraj,1,[0.5,0.5,0.5],'-'); % just graph S1
GraphkNNDendrogram4(1,0,numTraj,1,[0.5,0.5,0.5],'-'); % just graph S2
GraphkNNDendrogram5(1,0,numTraj,1,[0,0,0],'-'); % just graph result set

xlim([-1 numTraj + 1]);
ylim([lowClustRad 1.1]);
set(gca,'xticklabel',{[]});
set(gca,'yticklabel',{[]});
% set(gca,'TickDir','out');
% xlabel('Number of Trajectories');
% ylabel('Cluster Radius Size (Normalized)');
hold off

