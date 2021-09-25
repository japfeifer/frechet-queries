% create data
P = inP;
% P = trajStrData(2).traj;
% P = cell2mat(trajOrigData(5,1));

sP = size(P,1);

% plot result
figure;

% set(gca,'Units','normalized','position',[0.1,0.1,0.8,0.8]);
% hold on;

plot(P(:,1),P(:,2),'k','linewidth',1);
hold on;

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'go','MarkerSize',10);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'rx','MarkerSize',10);

% title(['Size P:',num2str(sP)]);
% set(gca,'TickDir','out');
% axis([4400 5100 -50 250])

axis off
% axis equal;
