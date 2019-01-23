% create data
P = trajData(1:1000,:);
% P = queryTraj(:,:);
% P = anchorTraj;
% P = trajData(1:1000,:);

figure
for i=1:size(P,1)
    Q = cell2mat(P(i,1));
    plot3(Q(:,1),Q(:,2),Q(:,3),'linewidth',1);
    hold on;
end
axis equal
