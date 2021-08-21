
function GraphSubNN2(Qid,level,plotType,subStr)

    global inP queryStrData inpTrajVert inpTrajErr

    P = inP;
    Q = queryStrData(Qid).traj;

    sP = size(P,1);
    sQ = size(Q,1);
    numDisc = 0;
    numKeep = 0;
    
    % plot figure
    if plotType == 1
        f = figure('Name','NN Search','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
        set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
    end

    % plot P
    plot(P(:,1),P(:,2),'linewidth',1,'markerfacecolor','k','Color',[0.7,0.7,0.7],'LineStyle',':');
    hold on;
    plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',5);
    plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',5);
    
    % plot Q
    plot(Q(:,1),Q(:,2),'b','linewidth',5,'markerfacecolor','b');
    plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',10);
    plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',10);
    
    % plot each candidate sub-traj set
    if plotType == 1 || plotType == 2
        subStrSz = size(subStr,1);
        for i = 1:subStrSz % graph traj that are too far in red
            if subStr(i,6) == 1 % sub-traj is too far
                idx1 = inpTrajVert(subStr(i,1),level);
                idx2 = inpTrajVert(subStr(i,2),level);
                R = inP([idx1 idx2],:); % only plot the segment from the candidate start point to end point
                plot(R(:,1),R(:,2),'r','linewidth',2,'markerfacecolor','r');
                numDisc = numDisc + 1;
            end
        end
        for i = 1:subStrSz % graph traj that are not too far in green
            if subStr(i,6) == 0 % sub-traj is not too far
                idx1 = inpTrajVert(subStr(i,1),level);
                idx2 = inpTrajVert(subStr(i,2),level);
                % plot P in black with no dotted line
                R2 = inP(idx1:idx2,:);
                plot(R2(:,1),R2(:,2),'k','linewidth',1,'markerfacecolor','k');
                % now plot candidates
                R = inP([idx1 idx2],:); % only plot the segment from the candidate start point to end point
                plot(R(:,1),R(:,2),'g','linewidth',2,'markerfacecolor','g');
                numKeep = numKeep + 1;
            end
        end
        title(['Level:',num2str(level),'  Size inP (black):',num2str(sP),'  Size Q (blue):',num2str(sQ),...
            '  num c keep (green):',num2str(numKeep),'  num c discard (red): ',num2str(numDisc),' with error ',...
            num2str(inpTrajErr(level))]);
    elseif plotType == 3
        idxP = [inpTrajVert(subStr(1,1):subStr(1,2),level)]';   % just look a first row in subStr
        R = inP(idxP,:); % contiguous list of vertex indices in P (a sub-traj of P)
        sR = size(R,1);
        plot(R(:,1),R(:,2),'color',[0.4660 0.6740 0.1880],'linewidth',4,'markerfacecolor','g');
        cm = ContFrechet(Q,R);
        title(['FINAL Level:',num2str(level),'  Size inP (black):',num2str(sP),'  Size Q (blue):',num2str(sQ),'  Size RESULT R (green):',num2str(sR),'  ConFrechetDist(Q,R): ',num2str(cm),' with error ',num2str(inpTrajErr(level))]);
    end
    
    xyMax = [max(max(P(:,1)),max(Q(:,1))) max(max(P(:,2)),max(Q(:,2)))];
    xyMin = [min(min(P(:,1)),min(Q(:,1))) min(min(P(:,2)),min(Q(:,2)))];
    xyLen = xyMax - xyMin;
    
    if plotType == 3
        text(xyMin(1),xyMin(2)-(xyLen(2)*0.03),'Fréchet Distance');
        line([xyMin(1) cm+xyMin(1)],[xyMin(2)-(xyLen(2)*0.05) xyMin(2)-xyLen(2)*0.05],'color','c','linewidth',3); % CFD line
    end
    text(xyMin(1),xyMin(2)-(xyLen(2)*0.08),'Error Distance');
    line([xyMin(1) inpTrajErr(level)+xyMin(1)],[xyMin(2)-(xyLen(2)*0.1) xyMin(2)-xyLen(2)*0.1],'color','m','linewidth',3); % error line

%     axis equal;
    
    hold off;
    
    % wait for user to press key
    w = waitforbuttonpress;

end