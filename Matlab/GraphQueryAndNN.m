% graph the Query and nearest neighbors from range search, simplification,
% and bounding box
% query is thick black line
% actual NN is thick green line
% approx NN is thick red line

QIdx = 7; % query index
Q = cell2mat(queryTraj(QIdx,1)); % query trajectory
NN = cell2mat(queryTraj(QIdx,7)); % pruned candidate trajectories
% actNNIDlist = cell2mat(queryTraj(QIdx,6)); % actual NN list
% actNN = actNNIDlist(1,1); % actual NN trajectory
apxNNIDlist = cell2mat(queryTraj(QIdx,12)); % approx NN list
apxNN = apxNNIDlist(1,1); % approx NN trajectory

% PNN = cell2mat(trajData(actNN)); % actual NN
ANN = cell2mat(trajData(apxNN)); % approx NN

% plot all NN traj
figure
hold on;
for k = 2 : size(NN,1)
    P2NN = cell2mat(trajData(NN(k,1),1));
    sP2NN = size(P2NN,1);
    plot(P2NN(:,1),P2NN(:,2),'linewidth',1);
    plot([P2NN(1,1) P2NN(1,1)],[P2NN(1,2) P2NN(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k'); 
    plot([P2NN(sP2NN,1) P2NN(sP2NN,1)],[P2NN(sP2NN,2) P2NN(sP2NN,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k'); 
end

% % plot actual NN
% sPNN = size(PNN,1);
% plot(PNN(:,1),PNN(:,2),'g-','linewidth',5); 
% plot([PNN(1,1) PNN(1,1)],[PNN(1,2) PNN(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
% plot([PNN(sPNN,1) PNN(sPNN,1)],[PNN(sPNN,2) PNN(sPNN,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

% % plot approx NN
% sANN = size(ANN,1);
% plot(ANN(:,1),ANN(:,2),'r-','linewidth',5); 
% plot([ANN(1,1) ANN(1,1)],[ANN(1,2) ANN(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
% plot([ANN(sANN,1) ANN(sANN,1)],[ANN(sANN,2) ANN(sANN,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

% plot query traj
sQ = size(Q,1);
plot(Q(:,1),Q(:,2),'k-','linewidth',5);  
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

% plot a circle at the orig and dest vertices of the query traj with radius Emax
% query traj orig circle
xc = Q(1,1);
yc = Q(1,2);
theta = linspace(0,2*pi);
x = Emax*cos(theta) + xc;
y = Emax*sin(theta) + yc;
plot(x,y,'k--')

% query traj dest circle
xc = Q(size(Q,1),1);
yc = Q(size(Q,1),2);
theta = linspace(0,2*pi);
x = Emax*cos(theta) + xc;
y = Emax*sin(theta) + yc;
plot(x,y,'k--')

% % graph Emin as a line
% % first find min x and y coordinates
% minXY = min(Q) - Emax;
% line([minXY(1) Emin+minXY(1)],[minXY(2)+2 minXY(2)+2],'color','k','linewidth',2)
% text(minXY(1),minXY(2)+1,'Emin length')

axis equal;



