
function GraphInpSepSingleCluster(Qid,Cid)

    global inpSep queryStrData inpTrajErr

    Q = queryStrData(Qid).traj; % query trajectory
    sQ = size(Q,1);
    lb = size(inpTrajErr,2); % number resolution levels

    % plot figure
    f = figure('Name','Single Cluster Trajectories','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
    set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
    
    % plot Q
    plot(Q(:,1),Q(:,2),'b','linewidth',5,'markerfacecolor','b');
    hold on;
    plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',10);
    plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',10);
    
    % plot each cluster center candidate 
    leafs = inpSep(Cid).leafs;
    sz = size(leafs,1);
    cm = 0;
    lev = inpSep(Cid).level;
    err = inpSep(Cid).err;
    xMax = 0; yMax = 0; xMin = Inf; yMin = Inf;
    for i = 1:sz 
        R = GetSimpP(leafs(i,1),leafs(i,2),leafs(i,10) - 1,lb); % get the simplified candidate traj
        plot(R(:,1),R(:,2),'marker','*','markersize',3,'linewidth',2,'color',rand(1,3));
        cm = max(ContFrechet(Q,R),cm); % keep track of max frechet distance
        xMax = max(max(R(:,1)),xMax); yMax = max(max(R(:,2)),yMax);
        xMin = min(min(R(:,1)),xMin); yMin = min(min(R(:,2)),yMin);
%         w = waitforbuttonpress;
    end
    % plot cluster center candidate
    R = GetSimpP(inpSep(Cid).stidx,inpSep(Cid).enidx,inpSep(Cid).level - 1,lb); % get the simplified candidate traj
    plot(R(:,1),R(:,2),'k','linewidth',5,'marker','*','markersize',5);
    
    title(['level:',num2str(lev),'  size Q (blue):',num2str(sQ),...
        '  num candiates in cluster:',num2str(sz),'  max Frechet dist: ',num2str(cm),'  max error:',...
        num2str(err)]);

    xyMax = [max(xMax,max(Q(:,1))) max(yMax,max(Q(:,2)))];
    xyMin = [min(xMin,min(Q(:,1))) min(yMin,min(Q(:,2)))];
    xyLen = xyMax - xyMin;
    
    text(xyMin(1),xyMin(2)-(xyLen(2)*0.03),'Fréchet Distance');
    line([xyMin(1) cm+xyMin(1)],[xyMin(2)-(xyLen(2)*0.05) xyMin(2)-xyLen(2)*0.05],'color','c','linewidth',3); % CFD line

    text(xyMin(1),xyMin(2)-(xyLen(2)*0.08),'Error Distance');
    line([xyMin(1) err+xyMin(1)],[xyMin(2)-(xyLen(2)*0.1) xyMin(2)-xyLen(2)*0.1],'color','m','linewidth',3); % error line

    axis equal;
    
    hold off;

end