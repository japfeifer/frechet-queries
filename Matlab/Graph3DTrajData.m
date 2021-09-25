rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable

% figure
% for i=1:size(trajStrData,2)
%     P = trajStrData(i).traj;
%     plot3(P(:,1),P(:,2),P(:,3),'linewidth',1,'color',rand(1,3));
%     hold on;
% end
% axis equal

figure
for i=1:size(trajOrigData,1)
    P = cell2mat(trajOrigData(i,1));
    plot3(P(:,1),P(:,2),P(:,3),'linewidth',1,'color',rand(1,3));
    hold on;
end

axis off
% axis equal