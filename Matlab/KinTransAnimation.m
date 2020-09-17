% get KinTrans sign language sequence
seqID = 1030;
seq = cell2mat(CompMoveData(seqID,4));   

% seq = KinTransNormalizeSeq(seq,[1 1 1 1 1]);

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' ];
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

    % connect left wrist to left hand
    xplot = [seq(i,25) seq(i,28)];
    yplot = [seq(i,26) seq(i,29)];
    zplot = [seq(i,27) seq(i,30)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'markerfacecolor','b');
    hold on;
    
    % connect shoulder center to hip
    xplot = [seq(i,1) seq(i,4)];
    yplot = [seq(i,2) seq(i,5)];
    zplot = [seq(i,3) seq(i,6)];
    plot3(xplot,yplot,zplot,'-k','linewidth',5,'Markerfacecolor','b');
    hold on;
    
    % connect shoulder center to right shoulder
    xplot = [seq(i,1) seq(i,7)];
    yplot = [seq(i,2) seq(i,8)];
    zplot = [seq(i,3) seq(i,9)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect right shoulder to right elbow
    xplot = [seq(i,7) seq(i,10)];
    yplot = [seq(i,8) seq(i,11)];
    zplot = [seq(i,9) seq(i,12)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect right elbow to right wrist
    xplot = [seq(i,10) seq(i,13)];
    yplot = [seq(i,11) seq(i,14)];
    zplot = [seq(i,12) seq(i,15)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;

    % connect right wrist to right hand
    xplot = [seq(i,13) seq(i,16)];
    yplot = [seq(i,14) seq(i,17)];
    zplot = [seq(i,15) seq(i,18)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'Markerfacecolor','b');
    hold on;

    % connect shoulder center to left shoulder
    xplot = [seq(i,1) seq(i,19)];
    yplot = [seq(i,2) seq(i,20)];
    zplot = [seq(i,3) seq(i,21)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect left shoulder to left elbow
    xplot = [seq(i,19) seq(i,22)];
    yplot = [seq(i,20) seq(i,23)];
    zplot = [seq(i,21) seq(i,24)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect left elbow to left wrist
    xplot = [seq(i,22) seq(i,25)];
    yplot = [seq(i,23) seq(i,26)];
    zplot = [seq(i,24) seq(i,27)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;
    
    % shoulder center
    plot3(seq(i,1),seq(i,2),seq(i,3),'o','MarkerSize',13,'MarkerFaceColor','g','MarkerEdgeColor','k');
    hold on;
    
    % hip
    plot3(seq(i,4),seq(i,5),seq(i,6),'o','MarkerSize',15,'MarkerFaceColor','r','MarkerEdgeColor','k');
    hold on;

    % right shoulder
    plot3(seq(i,7),seq(i,8),seq(i,9),'o','MarkerSize',11,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right elbow
    plot3(seq(i,10),seq(i,11),seq(i,12),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right wrist
    plot3(seq(i,13),seq(i,14),seq(i,15),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right hand
    plot3(seq(i,16),seq(i,17),seq(i,18),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;

    % left shoulder
    plot3(seq(i,19),seq(i,20),seq(i,21),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left elbow
    plot3(seq(i,22),seq(i,23),seq(i,24),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left wrist
    plot3(seq(i,25),seq(i,26),seq(i,27),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
       
    % left hand
    plot3(seq(i,28),seq(i,29),seq(i,30),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;

    hold off;
    
    % set the graph x/y/z coordinate min/max values
    xlim([minxval maxxval]);
    ylim([minyval maxyval]);
    zlim([minzval maxzval]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
%     view(160,-70); % set the azimuth and elevation for viewing the 3D data
%     view(78,14);
    view(-200,-50);
%     view(180,-10);

    drawnow;
%     pause(0.1);
%     w = waitforbuttonpress;
end