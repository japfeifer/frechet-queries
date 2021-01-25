% graph trajectory clusters

kSize = 8;
kIndex = log2(kSize);

% create some random colors for each of the k clusters
colorList = rand(kSize,3);

figure
hold on;
title(['Trajectory Clusters for k = ' num2str(kSize)])

for i = 1:size(clusterCurveGroup,1) % plot each traj
    currTraj = trajStrData(i).traj;  % get traj
    currCurveCluster = cell2mat(clusterCurveGroup(i,1)); % get traj cluster list
    currClusterID = currCurveCluster(kIndex,2); % get traj cluster id for KSize value
    currColor = colorList(currClusterID,:);  % set color for traj
    plot(currTraj(:,1),currTraj(:,2),'linewidth',1,'color',currColor); 
    
end

axis equal;