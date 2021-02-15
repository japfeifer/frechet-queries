
Qid = 4;
Q = queryStrData(Qid).traj;
sQ = size(Q,1);
subSVert = queryStrData(Qid).subsvert;
subEVert = queryStrData(Qid).subevert;

f = figure('Name','NN Search','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
hold on;

% plot CCT method
decideTrajIds = queryStrData(Qid).decidetrajids;
for i = 1:size(decideTrajIds,1)
    P = trajStrData(decideTrajIds(i)).traj;
    sP = size(P,1);
    plot(P(:,1),P(:,2),'g','linewidth',2,'markerfacecolor','g');
    plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'go','MarkerSize',5);
    plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'gx','MarkerSize',5);
end
    
numPlotP = size(subSVert,1);
% plot Sub-Traj DP Method (use Simp Tree)
for i = 1:numPlotP
    P = inP(subSVert(i):subEVert(i),:);
    sP = size(P,1);
    plot(P(:,1),P(:,2),'k','linewidth',1,'markerfacecolor','k');
    plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',5);
    plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',5);
end

% plot Q
plot(Q(:,1),Q(:,2),'b','linewidth',4,'markerfacecolor','b');
plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',5);
plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',5);
