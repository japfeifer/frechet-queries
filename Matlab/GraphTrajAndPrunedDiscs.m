% plot a single trajectory and discs in pointPrunedNodes

P = cell2mat(trajData(3,1));

figure

% graph the trajectory
plot(P(:,1),P(:,2),'linewidth',1,'color','k');
hold on;

% graph the random discs
for i=1:size(pointPrunedNodes,2)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(pointPrunedNodes(i),7));
    discRad = clusterPointNode(pointPrunedNodes(i),4) + furthRad;
    discCentrePointID = clusterPointNode(pointPrunedNodes(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','k');
    hold off
end

% graph the disc id's
for i=1:size(pointPrunedNodes,2)
    hold on
    txt = [num2str(pointPrunedNodes(i))];
    discCentrePointID = clusterPointNode(pointPrunedNodes(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt)
    hold off
end

axis equal