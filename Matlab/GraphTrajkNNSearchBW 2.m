% graph the kNN search in black & white

Qid = 1;
kNum = 64;
Q = cell2mat(queryTraj(Qid,1)); % query trajectory

PreprocessQuery(Qid);
GetkNNStat(Qid,kNum);

figure
axes('Units', 'normalized', 'Position', [0 0 1 1])
hold on;

% % plot all traj
% for i = 1 : size(trajData,1)
%     P = cell2mat(trajData(i,1));
%     p1 = plot(P(:,1),P(:,2),'linewidth',1,'Color',[0.7,0.7,0.7],'LineStyle',':','DisplayName','A'); 
% end

% plot leafs searched
for i = 1 : size(searchStat,2)
    if tmpCCT(searchStat(i),5) == 1 % a leaf
        trajID = tmpCCT(searchStat(i),6);
        P = cell2mat(trajData(trajID,1));
        p2 = plot(P(:,1),P(:,2),'linewidth',1,'Color',[0.5,0.5,0.5],'DisplayName','B');  
    end
end

% plot S1
for i = 1 : size(s1Stat,2)
    P = cell2mat(trajData(s1Stat(i),1)); 
    p3 = plot(P(:,1),P(:,2),'linewidth',4,'Color',[0.5,0.5,0.5],'LineStyle',':','DisplayName','C'); 
end

% plot S2
for i = 1 : size(s2Stat,2)
    P = cell2mat(trajData(s2Stat(i),1));
    p4 = plot(P(:,1),P(:,2),'linewidth',5,'Color',[0.1,0.1,0.1],'LineStyle',':','DisplayName','D'); 
end

% plot result set
for i = 1 : size(resStat,2)
    P = cell2mat(trajData(resStat(i),1));
    p5 = plot(P(:,1),P(:,2),'linewidth',6,'Color',[0,0,0],'DisplayName','A','DisplayName','E'); 
end

% plot query traj

p6 = plot(Q(:,1),Q(:,2),'linewidth',11,'Color',[0 0 0 0.3],'DisplayName','F');  

% plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
% plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

hold off

legend([p6 p1 p2 p3 p4 p5],'Query','Pruned','Searched','Prune Stage Candidates','Reduce Stage Candidates','Decide Stage Results','FontSize',10)

set(gca,'TickDir','out');
axis equal;

