% plot a single trajectory and discs that it stabs

P = trajStrData(90).traj;

stabOrder = GetTrajectoryStabOrder(P); % get the disc stab order

figure

% graph the stabbed random discs
for i=1:size(stabOrder,1)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(stabOrder(i),7));
    discRad = clusterPointNode(stabOrder(i),4) + furthRad;
    discCentrePointID = clusterPointNode(stabOrder(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','b');
    hold off
end

% graph the stabbed disc id's
for i=1:size(stabOrder,1)
    hold on
    txt = [num2str(stabOrder(i))];
    discCentrePointID = clusterPointNode(stabOrder(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

% get nodes that cover start and end points
PStartVertex = P(1,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PStartVertex);
startNodes = pointPrunedNodes;

PEndVertex = P(end,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PEndVertex);
endNodes = pointPrunedNodes;

% make start discs green
for i = 1:size(startNodes,2)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(startNodes(i),7));
    discRad = clusterPointNode(startNodes(i),4) + furthRad;
    discCentrePointID = clusterPointNode(startNodes(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','g');
    hold off
end

% graph the start disc id's
for i=1:size(startNodes,2)
    hold on
    txt = [num2str(startNodes(i))];
    discCentrePointID = clusterPointNode(startNodes(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

% make end discs red
for i = 1:size(endNodes,2)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(endNodes(i),7));
    discRad = clusterPointNode(endNodes(i),4) + furthRad;
    discCentrePointID = clusterPointNode(endNodes(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','r');
    hold off
end

% graph the trajectory
hold on;
plot(P(:,1),P(:,2),'linewidth',1,'color','k'); % trajectory
plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',15); % start vertex with circle
plot([P(end,1) P(end,1)],[P(end,2) P(end,2)],'kx','MarkerSize',15); % end vertex with X
hold off

axis equal


