rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable

% figure
% for i=1:size(trajStrData,2)
%     Q = trajStrData(i).traj;
%     plot(Q(:,1),Q(:,2),'linewidth',1,'color',rand(1,3));
%     hold on;
% end
% axis equal

figure

% set(gca,'Units','normalized','position',[0.1,0.1,0.8,0.8]);
% hold on;

for i=1:size(trajOrigData,1)
    Q = cell2mat(trajOrigData(i,1));
    plot(Q(:,1),Q(:,2),'linewidth',1,'color',rand(1,3));
    hold on;
end

axis off
% axis equal