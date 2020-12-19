% Graph P and simplified P'
Q = PSimp;

cm = ContFrechet(P,Q);
sP = size(P,1);
sQ = size(Q,1);
% plot result
figure;
plot(P(:,1),P(:,2),'o-k','linewidth',1,'markerfacecolor','k');
hold on;
% plot(Q(:,1),Q(:,2),'o-b','linewidth',1,'markerfacecolor','b');

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',15);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',15);

% plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',15);
% plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',15);

title(['Dataset: ',dataName,...
    '   P id: ',num2str(Pidx),...
    '   |P| (black): ',num2str(sP),...
    '   |P''| (blue): ',num2str(sQ),...
    '   Driemel error: ',num2str(currBestErr*dispFact),...
    '   Cont Frechet: ',num2str(cm*dispFact),...
    '   P max seg len: ',num2str(maxSegLenP*dispFact),...
    '   P'' max seg len: ',num2str(maxSegLenPSimp*dispFact)]);% legend('Q','P','location','best');
% line([2 cm+2],[0.5 0.5],'color','m','linewidth',2);
% text(2,0.4,'dFD length');

axis equal;
