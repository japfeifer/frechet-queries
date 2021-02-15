level = 9;

f = figure('Name','NN Search','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
hold on;

% plot P1
P1 = inP;
sP1 = size(P1,1);
plot(P1(:,1),P1(:,2),'k','linewidth',1,'markerfacecolor','k');
plot([P1(1,1) P1(1,1)],[P1(1,2) P1(1,2)],'ko','MarkerSize',5);
plot([P1(sP1,1) P1(sP1,1)],[P1(sP1,2) P1(sP1,2)],'kx','MarkerSize',5);

% plot P2
P2 = DriemelSimp(P1,inpTrajErr(level));
sP2 = size(P2,1);
plot(P2(:,1),P2(:,2),'b','linewidth',2,'markerfacecolor','b');
plot([P2(1,1) P2(1,1)],[P2(1,2) P2(1,2)],'bo','MarkerSize',5);
plot([P2(sP2,1) P2(sP2,1)],[P2(sP2,2) P2(sP2,2)],'bx','MarkerSize',5);

% plot P3
P3 = BallSimp(P1,inpTrajErr(level));
sP3 = size(P3,1);
plot(P3(:,1),P3(:,2),'g','linewidth',2,'markerfacecolor','g');
plot([P3(1,1) P3(1,1)],[P3(1,2) P3(1,2)],'go','MarkerSize',5);
plot([P3(sP3,1) P3(sP3,1)],[P3(sP3,2) P3(sP3,2)],'gx','MarkerSize',5);
