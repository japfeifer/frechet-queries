% FrechetDecide(P1,P2,err,0,1,0,0,0); % plot the freespace diagram

% Run ProcesskNNExactReal with k=5 for the pen tip data set

Qid = 4;
P2 = queryStrData(Qid).traj;
id = queryStrData(Qid).decidetrajids(5,1); % get fifth closest traj to Q
P1 = trajStrData(id).traj;

sP1 = size(P1,1);
sP2 = size(P2,1);
dist = ContFrechet(P1,P2);
err = dist * 3.0;

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

xyMax = [max(max(P1(:,1)),max(P2(:,1))) max(max(P1(:,2)),max(P2(:,2)))];
xyMin = [min(min(P1(:,1)),min(P2(:,1))) min(min(P1(:,2)),min(P2(:,2)))];
xyLen = xyMax - xyMin;

text(xyMin(1),xyMin(2)-(xyLen(2)*0.03),'\it{CF} \rm{Distance}');
line([xyMin(1) dist+xyMin(1)],[xyMin(2)-(xyLen(2)*0.05) xyMin(2)-xyLen(2)*0.05],'color','c','linewidth',3); % CFD line
text(xyMin(1),xyMin(2)-(xyLen(2)*0.08),'\tau Distance');
line([xyMin(1) err+xyMin(1)],[xyMin(2)-(xyLen(2)*0.1) xyMin(2)-xyLen(2)*0.1],'color','m','linewidth',3); % error line

title(['Size P1: ',num2str(sP1),'  Size P2: ',num2str(sP2)]);
set(gca,'TickDir','out');
% axis([-600 1200 -1900 2300])
axis equal;
