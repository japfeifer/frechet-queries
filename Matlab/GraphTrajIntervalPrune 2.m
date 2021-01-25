% graph normalized trajectory LB/UB intervals - Prune

Qid = 1; % query index
kNum = 12;

PreprocessQuery(Qid);
GetkNNStat(Qid,kNum);

% prepare S1
s1StatBnd = s1Stat';
s1StatBnd = [s1StatBnd zeros(size(s1StatBnd,1),1) zeros(size(s1StatBnd,1),1)];

% get LB, UB
Q = cell2mat(queryTraj(Qid,1)); % query trajectory
szS1 = size(s1StatBnd,1);
for i = 1:szS1
    PID = s1StatBnd(i);
    P = trajStrData(PID).traj; % get center traj 
    lowBnd = GetBestConstLB(P,Q,Inf,1,PID,Qid);
    upBnd = GetBestUpperBound(P,Q,1,PID,Qid);
    s1StatBnd(i,2:3) = [lowBnd upBnd];
end

% normalize LB, UB
minLB = min(s1StatBnd(:,2));
maxUB = max(s1StatBnd(:,3));
s1StatBnd(:,2) = (s1StatBnd(:,2) - minLB) / (maxUB - minLB); % LB
s1StatBnd(:,3) = (s1StatBnd(:,3) - minLB) / (maxUB - minLB); % UB

s1StatBnd = sortrows(s1StatBnd,3,'ascend'); % sort asc by UB

% plot all intervals
figure
hold on;

SUB = 0;
for i=1:szS1
    if i <= kNum
        plot([s1StatBnd(i,2) s1StatBnd(i,3)],[szS1-i+1 szS1-i+1],'o-k','linewidth',3,'MarkerSize',1,'color',[30/255 144/255 255/255],'LineStyle','-');
    end
    if i == kNum
        SUB = s1StatBnd(i,3);
    elseif i > kNum
        if s1StatBnd(i,2) > SUB
            plot([s1StatBnd(i,2) s1StatBnd(i,3)],[szS1-i+1 szS1-i+1],'o','linewidth',3,'color',[175/255 226/255 250/255],...
                'LineStyle','-','MarkerSize',1,'MarkerEdgeColor',[175/255 226/255 250/255]);
        else
            plot([s1StatBnd(i,2) s1StatBnd(i,3)],[szS1-i+1 szS1-i+1],'o-k','linewidth',3,'MarkerSize',1,'color',[30/255 144/255 255/255],'LineStyle','-');
        end
    end
end
i = kNum;
plot([s1StatBnd(i,3) s1StatBnd(i,3)],[szS1-i+1 1],'linewidth',3,'color',[0.1,0.1,0.1],'LineStyle',':');
text(s1StatBnd(i,3)*1.03,szS1-i+1.2,'k-th smallest UB','FontSize',22,'color',[0.1,0.1,0.1]);

ylim([0 szS1+1]);
xlim([-0.1 1.1]);
set(gca,'TickDir','out');

ax = gca;
ax.FontSize = 22; 
xlabel('Distance (normalized)','FontSize',22);
ylabel('Trajectories','FontSize',22);
hold off
