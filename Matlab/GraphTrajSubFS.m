% FrechetDecide(P1,P2,err,0,1,0,0,0); % plot the freespace diagram

% Pigeon Homing 1000 Sub-traj data set
Qid = 6;
idx1 = queryStrData(Qid).subsvert;
idx2 = queryStrData(Qid).subevert;
idx1 = idx1 - 10;
idx2 = idx2 + 10;
P1 = inP(idx1:idx2,:);
P2 = queryStrData(Qid).traj;

sP1 = size(P1,1);
sP2 = size(P2,1);
dist = queryStrData(Qid).subub;
err = dist * 5.5;

% plot result
figure;

set(gca,'Units','normalized','position',[0.1,0.1,0.8,0.8]);
hold on;

plot(P1(:,1),P1(:,2),'o-k','linewidth',2,'markerfacecolor','k','MarkerSize',4);
hold on;

plot(P2(:,1),P2(:,2),'o-b','linewidth',2,'markerfacecolor','b','MarkerSize',4);
hold on;

plot([P1(1,1) P1(1,1)],[P1(1,2) P1(1,2)],'ko','MarkerSize',10);
plot([P1(sP1,1) P1(sP1,1)],[P1(sP1,2) P1(sP1,2)],'kx','MarkerSize',10);
hold on;

plot([P2(1,1) P2(1,1)],[P2(1,2) P2(1,2)],'bo','MarkerSize',10);
plot([P2(sP2,1) P2(sP2,1)],[P2(sP2,2) P2(sP2,2)],'bx','MarkerSize',10);
hold on;

title(['Size P1: ',num2str(sP1),'  Size P2: ',num2str(sP2)]);
set(gca,'TickDir','out');
% axis([-600 1200 -1900 2300])
axis equal;
