% graph normalized trajectory LB/UB intervals - Results

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
    P = cell2mat(trajData(PID,1)); % get center traj 
    lowBnd = GetBestConstLB(P,Q,Inf,1,PID,Qid);
    upBnd = GetBestUpperBound(P,Q,1,PID,Qid);
    s1StatBnd(i,2:3) = [lowBnd upBnd];
end

% normalize LB, UB
minLB = min(s1StatBnd(:,2));
maxUB = max(s1StatBnd(:,3));
s1StatBnd(:,2) = (s1StatBnd(:,2) - minLB) / (maxUB - minLB); % LB
s1StatBnd(:,3) = (s1StatBnd(:,3) - minLB) / (maxUB - minLB); % UB

% find traj with the kth-smallest UB (SUB).  Search other traj and delete
% them if their LB > SUB.

s1StatBnd = sortrows(s1StatBnd,3,'ascend'); % sort asc by UB
SUB = s1StatBnd(kNum,3);
TF1 = s1StatBnd(1:kNum,3) > Inf; % just get a set of zeros for first k traj, since we do not want to delete these
TF2 = s1StatBnd(kNum+1:end,2) > SUB; % indexes where LB > kth smallest UB, from kNum+1 to end
s1StatBnd([TF1; TF2],:) = []; % delete rows 

% plot all intervals
figure
hold on;
szS1 = size(s1StatBnd,1);
s1StatBnd = sortrows(s1StatBnd,2,'ascend'); % sort asc by LB
SLB = s1StatBnd(kNum,2);
for i=1:szS1
    if s1StatBnd(i,3) < SLB
        plot([s1StatBnd(i,2) s1StatBnd(i,3)],[szS1-i+1 szS1-i+1],'o','linewidth',3,'color',[0 100/255 0],...
                'LineStyle','-','MarkerSize',1,'MarkerEdgeColor',[0 100/255 0]);
    else
        plot([s1StatBnd(i,2) s1StatBnd(i,3)],[szS1-i+1 szS1-i+1],'o-k','linewidth',3,'MarkerSize',1,'color',[30/255 144/255 255/255],'LineStyle','-');
    end
end
i=kNum;
plot([s1StatBnd(i,2) s1StatBnd(i,2)],[szS1-i+1 szS1],'linewidth',3,'color',[0.1,0.1,0.1],'LineStyle',':');
text(s1StatBnd(i,3)*1.03,szS1-i+1.2,'k-th smallest LB','FontSize',22,'color',[0.1,0.1,0.1]);

ylim([0 szS1+1]);
xlim([-0.1 1.1]);
set(gca,'TickDir','out');

ax = gca;
ax.FontSize = 22; 
xlabel('Distance (normalized)','FontSize',22);
ylabel('Trajectories','FontSize',22);
hold off
