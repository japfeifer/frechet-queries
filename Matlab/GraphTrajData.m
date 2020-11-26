% create data
P = trajData(4:5,:);
% P = queryTraj(:,:);
% P = anchorTraj;
% P = trajData(1:1000,:);

figure
for i=1:size(P,1)
    Q = cell2mat(P(i,1));
    plot(Q(:,1),Q(:,2),'linewidth',1);
    hold on;
end
axis equal
