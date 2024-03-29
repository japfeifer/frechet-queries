


% [cm, cSq] = DiscreteFrechetDist(P,Q);
cm = ContFrechet(P,Q);
sP = size(P,1);
sQ = size(Q,1);
% plot result
figure;
set(gca,'Units','normalized','position',[0.1,0.1,0.8,0.8]);
hold on;
plot(P(:,1),P(:,2),'o-k','linewidth',2,'markerfacecolor','k','MarkerSize',3);
hold on;
plot(Q(:,1),Q(:,2),'o-b','linewidth',2,'markerfacecolor','b','MarkerSize',3);

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',15);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',15);

plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',15);
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',15);

% title(['Cont Frechet: ',num2str(cm),'    size P (black):',num2str(sP),'    size Q (blue):',num2str(sQ)]);

set(gca,'TickDir','out');
axis([-0.5 0.5 -0.1 1.5])

% legend('Q','P','location','best');
% line([2 cm+2],[0.5 0.5],'color','m','linewidth',2);
% text(2,0.4,'dFD length');
% for i=1:length(cSq)
%   line([P(cSq(i,1),1) Q(cSq(i,2),1)],...
%        [P(cSq(i,1),2) Q(cSq(i,2),2)],...
%        'color',[0 0 0]+(i/length(cSq)/1.35));
% end
% axis equal;
% display the coupling sequence along with each distance between points
% disp([cSq sqrt(sum((P(cSq(:,1),:) - Q(cSq(:,2),:)).^2,2))]);