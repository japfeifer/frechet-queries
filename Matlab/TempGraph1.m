
Qid = 4;
Q = queryStrData(Qid).traj;
sQ = size(Q,1);
subSVert = 88402;
subEVert = 88403;

f = figure('Name','NN Search','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
hold on;

  

P = inP(subSVert:subEVert,:);
sP = size(P,1);
plot(P(:,1),P(:,2),'k','linewidth',1,'markerfacecolor','k');
plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',5);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',5);

P = inP(75684:75686,:);
sP = size(P,1);
plot(P(:,1),P(:,2),'g','linewidth',2,'markerfacecolor','g');
plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'go','MarkerSize',5);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'gx','MarkerSize',5);


% plot Q
plot(Q(:,1),Q(:,2),'b','linewidth',4,'markerfacecolor','b');
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',5);
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',5);
