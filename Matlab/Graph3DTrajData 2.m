
figure
for i=1:size(trajStrData,2)
    P = trajStrData(i).traj;
    plot3(P(:,1),P(:,2),P(:,3),'linewidth',1);
    hold on;
end
axis equal
