% create data
% P = inP;
% P = trajStrData(2).traj;
P = cell2mat(trajOrigData(5,1));

reach = TrajReach(P);
P1 = DriemelSimp(P,reach*0.02);
P2 = TrajSimp(P,reach*0.02);

sP = size(P,1);
sP1 = size(P1,1);
sP2 = size(P2,1);

P=P2;
sP=sP2;

% plot result
figure;

set(gca,'Units','normalized','position',[0.1,0.1,0.8,0.8]);
hold on;

plot(P(:,1),P(:,2),'o-k','linewidth',2,'markerfacecolor','k','MarkerSize',4);
hold on;

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',10);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',10);

title(['Size P:',num2str(sP)]);
set(gca,'TickDir','out');
axis([9.75 11.05 43.6 44.15])
% axis equal;
