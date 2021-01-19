% Graph P and Q trajectories
% *** use NON-SIMPLIFIED trajectories

% P = cell2mat(trajOrigData(2,1));
% Q = cell2mat(trajOrigData(4,1));
% % P = P(1:300,:);
% % Q = Q(3000:3100,:);

P = cell2mat(trajOrigData(2,1));
Q = cell2mat(trajData(4,1));
P = P(1:300,:);
Q = Q(1:10,:);

figure

plot(P(:,1),P(:,2),'linewidth',2);
hold on;
plot(Q(:,1),Q(:,2),'linewidth',2);
hold on;

axis equal


% ContFrechet(P,Q,2,1)
% FrechetDecide(P,Q,0.03,1,1)