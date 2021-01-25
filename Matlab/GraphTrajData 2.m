% create data

figure
for i=1:size(trajStrData,2)
    Q = trajStrData(i).traj;
    plot(Q(:,1),Q(:,2),'linewidth',1);
    hold on;
end
axis equal
