% create data
% P = cell2mat(trajData(1,1));
% Q = cell2mat(trajData(100,1));

% RotMatrix2d45 = [cosd(45) -sind(45); ...
%                      sind(45) cosd(45)];
% RotMatrix2d45 = [cosd(45) sind(45); ...
%                      -sind(45) cosd(45)];     
% P = cell2mat(trajData(54,1));
% Q = cell2mat(trajSimpData(54,1));
% Q = Q*RotMatrix2d45;

% P = cell2mat(trajData(55,1));
% Q = cell2mat(trajSimpData(55,1));

% P = cell2mat(trajData(7950,1));
% Q = cell2mat(queryTraj(5,1));

% P = P(Pos1:Pos2,:);
% Q = cat(1,P(Pos1,:),P(Pos2,:));

% P = cell2mat(trajData(1,1));
% Q = cell2mat(trajData(2,1));

% P = currTraj;
% Q = currSimpTraj;

% P = Q;
% Q = simpQ;

% P = PadTraj(P,1);
% Q = PadTraj(Q,1);

% [cm, cSq] = DiscreteFrechetDist(P,Q);
cm = ContFrechet(P,Q);
sP = size(P,1);
sQ = size(Q,1);
% plot result
figure;
plot(P(:,1),P(:,2),'o-k','linewidth',1,'markerfacecolor','k');
hold on;
plot(Q(:,1),Q(:,2),'o-b','linewidth',1,'markerfacecolor','b');
title(['Cont Frechet: ',num2str(cm),'    size P(black):',num2str(sP),'    size Q:(blue)',num2str(sQ)]);
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