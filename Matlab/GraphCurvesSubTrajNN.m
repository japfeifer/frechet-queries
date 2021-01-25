% create data
P = inP;
Q = queryStrData(Qid).traj;
Q = Q(17:18,:);

cm = ContFrechet(P,Q);
sP = size(P,1);
sQ = size(Q,1);
% plot result
figure;
plot(P(:,1),P(:,2),'k','linewidth',1,'markerfacecolor','k');
hold on;
plot(Q(:,1),Q(:,2),'b','linewidth',1,'markerfacecolor','b');

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',5);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',5);

plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',5);
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',5);

title(['Cont Frechet: ',num2str(cm),'    size inP(black):',num2str(sP),'    size Q:(blue)',num2str(sQ)]);
axis equal;
