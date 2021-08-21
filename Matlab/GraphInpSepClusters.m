
function GraphInpSepClusters(Qid)

    global inpSep queryStrData inpTrajErr

    Q = queryStrData(Qid).traj; % query trajectory
    sQ = size(Q,1);
    lb = size(inpTrajErr,2); % number resolution levels
    minLevel = min([inpSep(:).level]);

    % plot figure
    f = figure('Name','Cluster Center Trajectories','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
    set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
    
    % plot Q
    plot(Q(:,1),Q(:,2),'b','linewidth',5,'markerfacecolor','b');
    hold on;
    plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',10);
    plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',10);
    
    % plot each cluster center candidate 
    sz = size(inpSep,2);
    cm = 0;
    lev = Inf;
    err = 0;
    cnt = 0;
    xMax = 0; yMax = 0; xMin = Inf; yMin = Inf;
    for i = 1:sz
        if minLevel == inpSep(i).level
            R = GetSimpP(inpSep(i).stidx,inpSep(i).enidx,inpSep(i).level - 1,lb); % get the simplified candidate traj
            plot(R(:,1),R(:,2),'marker','*','markersize',3,'linewidth',2,'color',rand(1,3));
            cm = max(ContFrechet(Q,R),cm); % keep track of max frechet distance
            lev = min(inpSep(i).level,lev); % keep track of min level
            err = max(inpSep(i).err,err); % keep track of max error
            xMax = max(max(R(:,1)),xMax); yMax = max(max(R(:,2)),yMax);
            xMin = min(min(R(:,1)),xMin); yMin = min(min(R(:,2)),yMin);
            cnt = cnt + 1;
        end
    end
    
    title(['level:',num2str(lev),'  size Q (blue):',num2str(sQ),...
        '  num candiate clusters:',num2str(cnt),'  max Frechet dist: ',num2str(cm),'  max error:',...
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