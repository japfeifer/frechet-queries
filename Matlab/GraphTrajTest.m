% create data
P = trajData(:,:);
% P = queryTraj(:,:);
% P = anchorTraj;
% P = trajData(1:1000,:);

figure
for i=1:size(P,1)
    Q = cell2mat(P(i,1));
    plot(Q(:,1),Q(:,2),'linewidth',1);
    plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',2);
    hold on;
end

Q1 = cell2mat(queryTraj(15,1));
plot([Q1(1,1) Q1(1,1)],[Q1(1,2) Q1(1,2)],'ro','MarkerSize',2);

% graph the stabbed disc id's
for i=1:size(P,1)
    hold on
    Q = cell2mat(P(i,1));
    txt = [num2str(i)];
    xunit = Q(1,1) + 5;
    yunit = Q(1,2);
    text(xunit,yunit,txt,'color','b')
    hold off
end

axis equal