
Qid = 1;
kNum = 2;
Q = cell2mat(queryTraj(Qid,1)); % query trajectory

PreprocessQuery(Qid);
GetkNNStat(Qid,kNum);

figure
axes('Units', 'normalized', 'Position', [0 0 1 1])
hold on;

% plot all traj
for i = 1 : size(trajStrData,2)
    P = trajStrData(i).traj;
    plot(P(:,1),P(:,2),'linewidth',1,'Color',[0.7,0.7,0.7],'LineStyle',':'); 
end

% plot leafs searched
for i = 1 : size(searchStat,2)
    if tmpCCT(searchStat(i),5) == 1 % a leaf
        trajID = tmpCCT(searchStat(i),6);
        P = trajStrData(trajID).traj;
        plot(P(:,1),P(:,2),'linewidth',1,'Color',[0.4,0.4,0.4]);  
    end
end

% plot S1
for i = 1 : size(s1Stat,2)
    P = trajStrData(s1Stat(i)).traj; 
    plot(P(:,1),P(:,2),'linewidth',4,'Color',[175/255 226/255 250/255]); 
end

% plot S2
for i = 1 : size(s2Stat,2)
    P = trajStrData(s2Stat(i)).traj;
    plot(P(:,1),P(:,2),'linewidth',5,'Color',[30/255 144/255 255/255]); 
end

% plot result set
for i = 1 : size(resStat,2)
    P = trajStrData(resStat(i)).traj;
    plot(P(:,1),P(:,2),'linewidth',6,'Color',[0 100/255 0]); 
end

% plot query traj

plot(Q(:,1),Q(:,2),'linewidth',10,'Color',[255/255 0/255 0/255 0.3]);  

% plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'ko','MarkerSize',8,'MarkerEdgeColor','k');  
% plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'kx','MarkerSize',8,'MarkerEdgeColor','k');  

set(gca,'TickDir','out');
axis equal;

