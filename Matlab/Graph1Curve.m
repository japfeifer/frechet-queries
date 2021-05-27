% create data
P = inP;

sP = size(P,1);

% plot result
figure;
plot(P(:,1),P(:,2),'o-k','linewidth',1,'markerfacecolor','k','MarkerSize',2);
hold on;

plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',15);
plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',15);

title(['Size P:',num2str(sP)]);
axis equal;
