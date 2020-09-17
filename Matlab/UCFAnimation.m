% get UCF sign language sequence
seqID = 911;
seq = cell2mat(CompMoveData(seqID,4));   

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)'];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,38)' seq(:,41)' seq(:,44)'];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)'];
minxval = min(xval) - 0.1;
maxxval = max(xval) + 0.1;
minyval = min(yval) - 0.1;
maxyval = max(yval) + 0.1;
minzval = min(zval) - 0.1;
maxzval = max(zval) + 0.1;

figure(100);
set(gcf, 'Position',  [100, 100, 600, 600]); % set figure window position and size

% Animation Loop
for i = 1:size(seq,1)

    % connect HEAD to NECK
    xplot = [seq(i,1) seq(i,4)];
    yplot = [seq(i,2) seq(i,5)];
    zplot = [seq(i,3) seq(i,6)];
    plot3(xplot,yplot,zplot,'-k','linewidth',5,'Markerfacecolor','k');
    hold on;
    
    % connect NECK to TORS
    xplot = [seq(i,4) seq(i,7)];
    yplot = [seq(i,5) seq(i,8)];
    zplot = [seq(i,6) seq(i,9)];
    plot3(xplot,yplot,zplot,'-k','linewidth',5,'Markerfacecolor','k');
    hold on;
    
    % connect NECK to RSHO
    xplot = [seq(i,4) seq(i,19)];
    yplot = [seq(i,5) seq(i,20)];
    zplot = [seq(i,6) seq(i,21)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','k');
    hold on;
    
    % connect RSHO to RELB
    xplot = [seq(i,19) seq(i,22)];
    yplot = [seq(i,20) seq(i,23)];
    zplot = [seq(i,21) seq(i,24)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','k');
    hold on;
    
    % connect RELB to RHND
    xplot = [seq(i,22) seq(i,25)];
    yplot = [seq(i,23) seq(i,26)];
    zplot = [seq(i,24) seq(i,27)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k');
    hold on;
    
    % connect TORS to RHIP
    xplot = [seq(i,7) seq(i,37)];
    yplot = [seq(i,8) seq(i,38)];
    zplot = [seq(i,9) seq(i,39)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','k');
    hold on;
    
    % connect RHIP to RKNE
    xplot = [seq(i,37) seq(i,40)];
    yplot = [seq(i,38) seq(i,41)];
    zplot = [seq(i,39) seq(i,42)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','k');
    hold on;
    
    % connect RKNE to RFOT
    xplot = [seq(i,40) seq(i,43)];
    yplot = [seq(i,41) seq(i,44)];
    zplot = [seq(i,42) seq(i,45)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k');
    hold on;
    
    % connect NECK to LSHO
    xplot = [seq(i,4) seq(i,10)];
    yplot = [seq(i,5) seq(i,11)];
    zplot = [seq(i,6) seq(i,12)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','k');
    hold on;
    
    % connect LSHO to LELB
    xplot = [seq(i,10) seq(i,13)];
    yplot = [seq(i,11) seq(i,14)];
    zplot = [seq(i,12) seq(i,15)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','k');
    hold on;
    
    % connect LELB to LHND
    xplot = [seq(i,13) seq(i,16)];
    yplot = [seq(i,14) seq(i,17)];
    zplot = [seq(i,15) seq(i,18)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k');
    hold on;
    
    % connect TORS to LHIP
    xplot = [seq(i,7) seq(i,28)];
    yplot = [seq(i,8) seq(i,29)];
    zplot = [seq(i,9) seq(i,30)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','k');
    hold on;
    
    % connect LHIP to LKNE
    xplot = [seq(i,28) seq(i,31)];
    yplot = [seq(i,29) seq(i,32)];
    zplot = [seq(i,30) seq(i,33)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','k');
    hold on;
    
    % connect LKNE to LFOT
    xplot = [seq(i,31) seq(i,34)];
    yplot = [seq(i,32) seq(i,35)];
    zplot = [seq(i,33) seq(i,36)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k');
    hold on;
    
    plot3(seq(i,1),seq(i,2),seq(i,3),'o','MarkerSize',13,'MarkerFaceColor','g','MarkerEdgeColor','k'); % HEAD
    hold on;
    
    plot3(seq(i,4),seq(i,5),seq(i,6),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k'); % NECK
    hold on;
    
    plot3(seq(i,7),seq(i,8),seq(i,9),'o','MarkerSize',11,'MarkerFaceColor','r','MarkerEdgeColor','k'); % TORS
    hold on;
    
    plot3(seq(i,10),seq(i,11),seq(i,12),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k'); % LSHO
    hold on;
    
    plot3(seq(i,13),seq(i,14),seq(i,15),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k'); % LELB
    hold on;
    
    plot3(seq(i,16),seq(i,17),seq(i,18),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); % LHND
    hold on;
    
    plot3(seq(i,19),seq(i,20),seq(i,21),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b'); % RSHO
    hold on;
    
    plot3(seq(i,22),seq(i,23),seq(i,24),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b'); % RELB
    hold on;
    
    plot3(seq(i,25),seq(i,26),seq(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b'); % RHND
    hold on;
    
    plot3(seq(i,28),seq(i,29),seq(i,30),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k'); % LHIP
    hold on;
    
    plot3(seq(i,31),seq(i,32),seq(i,33),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k'); % LKNE
    hold on;
    
    plot3(seq(i,34),seq(i,35),seq(i,36),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); % LFOT
    hold on;
    
    plot3(seq(i,37),seq(i,38),seq(i,39),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b'); % RHIP
    hold on;
    
    plot3(seq(i,40),seq(i,41),seq(i,42),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b'); % RKNE
    hold on;
    
    plot3(seq(i,43),seq(i,44),seq(i,45),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b'); % RFOT
    hold on;
    
%     % shoulder center
%     plot3(seq(i,1),seq(i,2),seq(i,3),'o','MarkerSize',13,'MarkerFaceColor','g','MarkerEdgeColor','k');
%     hold on;
%     
%     % hip
%     plot3(seq(i,4),seq(i,5),seq(i,6),'o','MarkerSize',15,'MarkerFaceColor','r','MarkerEdgeColor','k');
%     hold on;
% 
%     % right shoulder
%     plot3(seq(i,7),seq(i,8),seq(i,9),'o','MarkerSize',11,'MarkerFaceColor','b','MarkerEdgeColor','b');
%     hold on;
%     
%     % right elbow
%     plot3(seq(i,10),seq(i,11),seq(i,12),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b');
%     hold on;
%     
%     % right wrist
%     plot3(seq(i,13),seq(i,14),seq(i,15),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b');
%     hold on;
%     
%     % right hand
%     plot3(seq(i,16),seq(i,17),seq(i,18),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b');
%     hold on;
% 
%     % left shoulder
%     plot3(seq(i,19),seq(i,20),seq(i,21),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
%     
%     % left elbow
%     plot3(seq(i,22),seq(i,23),seq(i,24),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
%     
%     % left wrist
%     plot3(seq(i,25),seq(i,26),seq(i,27),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
%        
%     % left hand
%     plot3(seq(i,28),seq(i,29),seq(i,30),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;

    hold off;
    
    % set the graph x/y/z coordinate min/max values
    xlim([minxval maxxval]);
    ylim([minyval maxyval]);
    zlim([minzval maxzval]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
    % set the azimuth and elevation for viewing the 3D data
    view(-200,-50);

    drawnow;
    pause(0.1);
%     w = waitforbuttonpress;
end