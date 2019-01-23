% graph all trajectories and highlight the ones from range search, 
% simplification, and bounding box
% all traj are colorful thin lines
% query traj is thick black line

QIdx = 1; % query index
P = trajData(:,:);
Q = cell2mat(queryTraj(QIdx,1)); % query trajectory
NN = cell2mat(queryTraj(QIdx,7)); % pruned candidate trajectories

% plot all traj
figure
hold on;
for k = 1 : size(P,1)
    currP = cell2mat(P(k,1));
    plot(currP(:,1),currP(:,2),'linewidth',1); 
end

% plot all NN traj
% for k = 2 : size(NN,1)
%     P2NN = cell2mat(trajData(NN(k,1),1));
%     sP2NN = size(P2NN,1);
%     plot(P2NN(:,1),P2NN(:,2),'r-','linewidth',2);
%     plot([P2NN(1,1) P2NN(1,1)],[P2NN(1,2) P2NN(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k'); 
%     plot([P2NN(sP2NN,1) P2NN(sP2NN,1)],[P2NN(sP2NN,2) P2NN(sP2NN,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k'); 
% end

% plot query traj
sQ = size(Q,1);
plot(Q(:,1),Q(:,2),'k-','linewidth',4);  
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

axis equal;

