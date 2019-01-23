% graph the Query and nearest neighbors from range search, simplification,
% and bounding box, and also the range query results
% traj remaining from pruning are thin black lines
% traj from range search are thin green lines
% query is thick black line

QIdx = 2; % query index
% NN = cell2mat(queryTraj(QIdx,3)); % list of range-search nearest neighbors
% NN = cell2mat(queryTraj(QIdx,6)); % list of simplification nearest neighbors
NN = cell2mat(queryTraj(QIdx,7)); % list of bounding box nearest neighbors

RNN = cell2mat(queryTraj(QIdx,11)); % list of range search traj
Q = cell2mat(queryTraj(QIdx,1));

figure
hold on;

% plot query traj
sQ = size(Q,1);
plot(Q(:,1),Q(:,2),'k-','linewidth',5);  
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

% plot all traj after pruning
for k = 1 : size(NN,1)
    P2NN = cell2mat(trajData(NN(k,1),1));
    sP2NN = size(P2NN,1);
    plot(P2NN(:,1),P2NN(:,2),'k-','linewidth',1);
    plot([P2NN(1,1) P2NN(1,1)],[P2NN(1,2) P2NN(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k'); 
    plot([P2NN(sP2NN,1) P2NN(sP2NN,1)],[P2NN(sP2NN,2) P2NN(sP2NN,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k'); 
end

% plot range search traj
for k = 1 : size(RNN,1)
    P2NN = cell2mat(trajData(RNN(k,1),1));
    sP2NN = size(P2NN,1);
    plot(P2NN(:,1),P2NN(:,2),'g-','linewidth',1);
    plot([P2NN(1,1) P2NN(1,1)],[P2NN(1,2) P2NN(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k'); 
    plot([P2NN(sP2NN,1) P2NN(sP2NN,1)],[P2NN(sP2NN,2) P2NN(sP2NN,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k'); 
end

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



