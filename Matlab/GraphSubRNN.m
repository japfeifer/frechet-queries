
function GraphSubRNN(Qid,level,plotType,subStr,tau,resRNN)

    switch nargin
    case 5
        resRNN = [];
    end
    
    global inP queryStrData inpTrajVert inpTrajErr

    P = inP;
    Q = queryStrData(Qid).traj;

    sP = size(P,1);
    sQ = size(Q,1);
    
    % plot figure
    if plotType == 1
        f = figure('Name','NN Search','NumberTitle','off','units','normalized','outerposition',[0 0 1 1]);
        set(gca,'Units','normalized','Position',[0.05,0.1,0.9,0.8]);
    end

    % plot P
    plot(P(:,1),P(:,2),'k','linewidth',1,'markerfacecolor','k');
    hold on;
    plot([P(1,1) P(1,1)],[P(1,2) P(1,2)],'ko','MarkerSize',5);
    plot([P(sP,1) P(sP,1)],[P(sP,2) P(sP,2)],'kx','MarkerSize',5);
    
    % plot Q
    plot(Q(:,1),Q(:,2),'b','linewidth',2,'markerfacecolor','b');
    plot([Q(1,1) Q(1,1)],[Q(1,2) Q(1,2)],'bo','MarkerSize',5);
    plot([Q(sQ,1) Q(sQ,1)],[Q(sQ,2) Q(sQ,2)],'bx','MarkerSize',5);
    
    % plot each candidate sub-traj set
    if plotType == 1 || plotType == 2
        subStrSz = size(subStr,1);
        cm = 0;
        for i = 1:subStrSz % graph traj that are too far in red
            if subStr(i,6) == 1 % sub-traj is too far
                idxP = [inpTrajVert(subStr(i,1):subStr(i,2),level)]';
                R = inP(idxP,:); % contiguous list of vertex indices in P (a sub-traj of P)
                sR = size(R,1);
                plot(R(:,1),R(:,2),'r','linewidth',2,'markerfacecolor','r');
            end
        end
        for i = 1:subStrSz % graph traj that are not too far in green
            if subStr(i,6) == 0 % sub-traj is not too far
                idxP = [inpTrajVert(subStr(i,1):subStr(i,2),level)]';
                R = inP(idxP,:); % contiguous list of vertex indices in P (a sub-traj of P)
                sR = size(R,1);
                plot(R(:,1),R(:,2),'g','linewidth',2,'markerfacecolor','g');
                cm = ContFrechet(Q,R);
            end
        end
        title(['Level:',num2str(level),'  Size inP (black):',num2str(sP),'  Size Q (blue):',num2str(sQ),...
            '  Size Not Discarded R (green):',num2str(sR),'  ConFrechetDist(Q,R): ',num2str(cm),' with error ',...
            num2str(inpTrajErr(level))]);
    elseif plotType == 3
        if size(resRNN,1) > 0
            for i = 1:size(resRNN,1) % graph RNN sub-traj results in thick green
                R = inP(resRNN(i,1):resRNN(i,2),:); % contiguous list of vertex indices in P (a sub-traj of P)
                sR = size(R,1);
                plot(R(:,1),R(:,2),'color',[0.4660 0.6740 0.1880],'linewidth',4,'markerfacecolor','g');
                cm = ContFrechet(Q,R);
            end
        else
            sR = 0;
            cm = 0;
        end
        title(['FINAL Level:',num2str(level),'  Size inP (black):',num2str(sP),'  Size Q (blue):',num2str(sQ),'  Size RESULT R (green):',num2str(sR),'  ConFrechetDist(Q,R): ',num2str(cm),' with error ',num2str(inpTrajErr(level))]);
    end
    
    xyMax = [max(max(P(:,1)),max(Q(:,1))) max(max(P(:,2)),max(Q(:,2)))];
    xyMin = [min(min(P(:,1)),min(Q(:,1))) min(min(P(:,2)),min(Q(:,2)))];
    xyLen = xyMax - xyMin;
    
    text(xyMin(1),xyMin(2)-(xyLen(2)*0.03),'Fréchet Distance');
    line([xyMin(1) cm+xyMin(1)],[xyMin(2)-(xyLen(2)*0.05) xyMin(2)-xyLen(2)*0.05],'color','c','linewidth',3); % CFD line
    text(xyMin(1),xyMin(2)-(xyLen(2)*0.08),'Error Distance');
    line([xyMin(1) inpTrajErr(level)+xyMin(1)],[xyMin(2)-(xyLen(2)*0.1) xyMin(2)-xyLen(2)*0.1],'color','m','linewidth',3); % error line
    text(xyMin(1),xyMin(2)-(xyLen(2)*0.13),'Range Distance');
    line([xyMin(1) tau+xyMin(1)],[xyMin(2)-(xyLen(2)*0.15) xyMin(2)-xyLen(2)*0.15],'color','k','linewidth',3); % error line
%     axis equal;
    
    hold off;
    
    % wait for user to press key
    w = waitforbuttonpress;

end