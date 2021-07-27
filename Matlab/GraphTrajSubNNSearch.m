rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable

Qid = 5;
Q = queryStrData(Qid).traj;

figure
axes('Units', 'normalized', 'Position', [0 0 1 1])
hold on;

% plot input traj
P = inP;
plot(P(:,1),P(:,2),'linewidth',1,'color',[0 0 0]); 

% plot query traj
plot(Q(:,1),Q(:,2),'linewidth',5,'Color',[255/255 0/255 0/255 0.3]); 

% plot nearest-neighbor traj
idx1 = queryStrData(Qid).subsvert;
idx2 = queryStrData(Qid).subevert;
plot(P(idx1:idx2,1),P(idx1:idx2,2),'linewidth',5,'Color',[0 100/255 0]); 

% plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
% plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

set(gca,'TickDir','out');
axis equal;

