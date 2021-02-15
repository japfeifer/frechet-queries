% create data

figure
for i=1:size(trajStrData,2)
    Q = trajStrData(i).traj;
    plot(Q(:,1),Q(:,2),'linewidth',1);
    plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',2);
    hold on;
end

Q1 = queryStrData(15).traj;
plot([Q1(1,1) Q1(1,1)],[Q1(1,2) Q1(1,2)],'ro','MarkerSize',2);

% graph the stabbed disc id's
for i=1:size(trajStrData,2)
    hold on
    Q = trajStrData(i).traj;
    txt = [num2str(i)];
    xunit = Q(1,1) + 5;
    yunit = Q(1,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

axis equal