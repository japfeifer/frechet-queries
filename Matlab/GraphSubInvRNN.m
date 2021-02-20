% create data
Qid = 4;
Q = queryStrData(Qid).traj;
sQ = size(Q,1);

% plot result
figure;
hold on;

for j = 1:size(queryStrData(Qid).decidetrajids)
    P = trajStrData(queryStrData(Qid).decidetrajids(j,1)).traj;
    sP = size(P,1);
    plot(P(:,1),P(:,2),'o-k','linewidth',1,'markerfacecolor','k');
    plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',15);
    plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',15);
end

plot(Q(:,1),Q(:,2),'o-b','linewidth',1,'markerfacecolor','b');
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',15);
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',15);

title(['number P (black): ',num2str(j),',  |Q| (blue): ',num2str(sQ),'   Range Dist: ',num2str(queryStrData(Qid).sub3rangedist)]);
% legend('Q','P','location','best');
% line([2 cm+2],[0.5 0.5],'color','m','linewidth',2);
% text(2,0.4,'dFD length');
% for i=1:length(cSq)
%   line([P(cSq(i,1),1) Q(cSq(i,2),1)],...
%        [P(cSq(i,1),2) Q(cSq(i,2),2)],...
%        'color',[0 0 0]+(i/length(cSq)/1.35));
% end
axis equal;
% display the coupling sequence along with each distance between points
% disp([cSq sqrt(sum((P(cSq(:,1),:) - Q(cSq(:,2),:)).^2,2))]);