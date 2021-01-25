% plot all trajectories and random leaf level discs


figure
% graph the trajectories
for i=1:size(trajStrData,2)
    Q = trajStrData(i).traj;
    plot(Q(:,1),Q(:,2),'linewidth',1);
    hold on;
end

% graph the random balls
for i=1:size(randPts,1)
    hold on
    th = 0:pi/50:2*pi;
    xunit = randPtsBallRad(i) * cos(th) + randPts(i,1);
    yunit = randPtsBallRad(i) * sin(th) + randPts(i,2);
    h = plot(xunit, yunit,'color','k');
    hold off
end


axis equal


