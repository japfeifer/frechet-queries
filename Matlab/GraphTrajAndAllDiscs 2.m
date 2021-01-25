% plot a single trajectory and all leaf-level discs 

P = trajStrData(9).traj;

figure

% graph the random discs
for i=1:size(randPts,1)
    hold on
    th = 0:pi/50:2*pi;
    xunit = randPtsBallRad(i) * cos(th) + randPts(i,1);
    yunit = randPtsBallRad(i) * sin(th) + randPts(i,2);
    h = plot(xunit, yunit,'color','b');
    hold off
end

% graph the disc node id's
for i=1:size(randPts,1)
    hold on
    txt = [num2str(clusterPointNodeToID(i))];
    discCentrePointID = i;
    xunit = randPts(discCentrePointID,1);
    yunit = randPts(discCentrePointID,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

% graph the trajectory
hold on
plot(P(:,1),P(:,2),'linewidth',1,'color','k');
hold off

axis equal
