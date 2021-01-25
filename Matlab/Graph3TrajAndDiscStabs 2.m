% plot a single trajectory and discs that it stabs

Q = cell2mat(queryTraj(11,1));    % query traj
ExactP = trajStrData(115).traj; % exact NN input traj
HVP = trajStrData(10).traj;    % hyper vector NN input traj

stabOrderQ = GetTrajectoryStabOrder(Q);
stabOrderExactP = GetTrajectoryStabOrder(ExactP);
stabOrderHVP = GetTrajectoryStabOrder(HVP);

figure

% graph the stabbed random discs
for i=1:size(stabOrderQ,1)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(stabOrderQ(i),7));
    discRad = clusterPointNode(stabOrderQ(i),4) + furthRad;
    discCentrePointID = clusterPointNode(stabOrderQ(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','b');
    hold off
end

% graph the stabbed disc id's
for i=1:size(stabOrderQ,1)
    hold on
    txt = [num2str(stabOrderQ(i))];
    discCentrePointID = clusterPointNode(stabOrderQ(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

% graph the stabbed random discs
for i=1:size(stabOrderExactP,1)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(stabOrderExactP(i),7));
    discRad = clusterPointNode(stabOrderExactP(i),4) + furthRad;
    discCentrePointID = clusterPointNode(stabOrderExactP(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','b');
    hold off
end

% graph the stabbed disc id's
for i=1:size(stabOrderExactP,1)
    hold on
    txt = [num2str(stabOrderExactP(i))];
    discCentrePointID = clusterPointNode(stabOrderExactP(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

% graph the stabbed random discs
for i=1:size(stabOrderHVP,1)
    hold on
    th = 0:pi/50:2*pi;
    % get the radius of this cluster node
    furthRad = randPtsBallRad(clusterPointNode(stabOrderHVP(i),7));
    discRad = clusterPointNode(stabOrderHVP(i),4) + furthRad;
    discCentrePointID = clusterPointNode(stabOrderHVP(i),6);
    xunit = discRad * cos(th) + randPts(discCentrePointID,1);
    yunit = discRad * sin(th) + randPts(discCentrePointID,2);
    h = plot(xunit, yunit,'color','b');
    hold off
end

% graph the stabbed disc id's
for i=1:size(stabOrderHVP,1)
    hold on
    txt = [num2str(stabOrderHVP(i))];
    discCentrePointID = clusterPointNode(stabOrderHVP(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

% get nodes that cover start and end points
startNodes = [];
PStartVertex = Q(1,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PStartVertex);
startNodes = [startNodes pointPrunedNodes];
PStartVertex = ExactP(1,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PStartVertex);
startNodes = [startNodes pointPrunedNodes];
PStartVertex = HVP(1,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PStartVertex);
startNodes = [startNodes pointPrunedNodes];

endNodes = [];
PEndVertex = Q(end,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PEndVertex);
endNodes = [endNodes pointPrunedNodes];
PEndVertex = ExactP(end,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PEndVertex);
endNodes = [endNodes pointPrunedNodes];
PEndVertex = HVP(end,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PEndVertex);
endNodes = [endNodes pointPrunedNodes];

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
    text(xunit,yunit,txt,'color','b');
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

% graph the end disc id's
for i=1:size(endNodes,2)
    hold on
    txt = [num2str(endNodes(i))];
    discCentrePointID = clusterPointNode(endNodes(i),6);
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b');
    hold off
end

% graph the trajectories
hold on;
% graph query traj
plot(Q(:,1),Q(:,2),'linewidth',1,'color','k'); % trajectory
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',15); % start vertex with circle
plot([Q(end,1) Q(end,1)],[Q(end,2) Q(end,2)],'kx','MarkerSize',15); % end vertex with X

% graph exact NN input traj
plot(ExactP(:,1),ExactP(:,2),'linewidth',1,'color','g'); % trajectory
plot([ExactP(1,1) ExactP(1,1)],[ExactP(1,2) ExactP(1,2)],'go','MarkerSize',15); % start vertex with circle
plot([ExactP(end,1) ExactP(end,1)],[ExactP(end,2) ExactP(end,2)],'gx','MarkerSize',15); % end vertex with X

% graph hyper vector NN input traj
plot(HVP(:,1),HVP(:,2),'linewidth',1,'color','r'); % trajectory
plot([HVP(1,1) HVP(1,1)],[HVP(1,2) HVP(1,2)],'ro','MarkerSize',15); % start vertex with circle
plot([HVP(end,1) HVP(end,1)],[HVP(end,2) HVP(end,2)],'rx','MarkerSize',15); % end vertex with X

hold off

axis equal


