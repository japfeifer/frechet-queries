queryResultID = 1365;

queryID = queryResults(queryResultID,1);
NNID = queryResults(queryResultID,2);
CorrectID = queryResults(queryResultID,3);

% get sequences
Seq1 = cell2mat(CompMoveData(queryID,4));  
Seq2 = cell2mat(CompMoveData(NNID,4)); 
Seq3 = cell2mat(CompMoveData(CorrectID,4)); 
% normalize seq
% Seq2 = KinTransNormalizeSeq(Seq2,[1 1 1 1 1]);
% Seq1 = KinTransNormalizeSeq(Seq1,[1 1 1 1 1]);
% Seq3 = KinTransNormalizeSeq(Seq3,[1 1 1 1 1]);
dist1 = ContFrechet(Seq1,Seq2); % query to NN Result distance
dist2 = ContFrechet(Seq1,Seq3); % query to Correct Result distance

% make all three sequences the same number of frames
maxSeqSize = max(max(size(Seq1,1),size(Seq2,1)),size(Seq3,1));

sz = size(Seq1,1);
for i = sz + 1 : maxSeqSize
    Seq1(i,:) = Seq1(sz,:);
end

sz = size(Seq2,1);
for i = sz + 1 : maxSeqSize
    Seq2(i,:) = Seq2(sz,:);
end

sz = size(Seq3,1);
for i = sz + 1 : maxSeqSize
    Seq3(i,:) = Seq3(sz,:);
end

% set plot coordinate min/max values
xval1 = [Seq1(:,1)' Seq1(:,4)' Seq1(:,7)' Seq1(:,10)' Seq1(:,13)' Seq1(:,16)' Seq1(:,19)' Seq1(:,22)' Seq1(:,25)' Seq1(:,28)' ];
yval1 = [Seq1(:,2)' Seq1(:,5)' Seq1(:,8)' Seq1(:,11)' Seq1(:,14)' Seq1(:,17)' Seq1(:,20)' Seq1(:,23)' Seq1(:,26)' Seq1(:,29)' ];
zval1 = [Seq1(:,3)' Seq1(:,6)' Seq1(:,9)' Seq1(:,12)' Seq1(:,15)' Seq1(:,18)' Seq1(:,21)' Seq1(:,24)' Seq1(:,27)' Seq1(:,30)' ];
minxval1 = min(xval1) - 0.1;
maxxval1 = max(xval1) + 0.1;
minyval1 = min(yval1) - 0.1;
maxyval1 = max(yval1) + 0.1;
minzval1 = min(zval1) - 0.1;
maxzval1 = max(zval1) + 0.1;

xval2 = [Seq2(:,1)' Seq2(:,4)' Seq2(:,7)' Seq2(:,10)' Seq2(:,13)' Seq2(:,16)' Seq2(:,19)' Seq2(:,22)' Seq2(:,25)' Seq2(:,28)' ];
yval2 = [Seq2(:,2)' Seq2(:,5)' Seq2(:,8)' Seq2(:,11)' Seq2(:,14)' Seq2(:,17)' Seq2(:,20)' Seq2(:,23)' Seq2(:,26)' Seq2(:,29)' ];
zval2 = [Seq2(:,3)' Seq2(:,6)' Seq2(:,9)' Seq2(:,12)' Seq2(:,15)' Seq2(:,18)' Seq2(:,21)' Seq2(:,24)' Seq2(:,27)' Seq2(:,30)' ];
minxval2 = min(xval2) - 0.1;
maxxval2 = max(xval2) + 0.1;
minyval2 = min(yval2) - 0.1;
maxyval2 = max(yval2) + 0.1;
minzval2 = min(zval2) - 0.1;
maxzval2 = max(zval2) + 0.1;

xval3 = [Seq3(:,1)' Seq3(:,4)' Seq3(:,7)' Seq3(:,10)' Seq3(:,13)' Seq3(:,16)' Seq3(:,19)' Seq3(:,22)' Seq3(:,25)' Seq3(:,28)' ];
yval3 = [Seq3(:,2)' Seq3(:,5)' Seq3(:,8)' Seq3(:,11)' Seq3(:,14)' Seq3(:,17)' Seq3(:,20)' Seq3(:,23)' Seq3(:,26)' Seq3(:,29)' ];
zval3 = [Seq3(:,3)' Seq3(:,6)' Seq3(:,9)' Seq3(:,12)' Seq3(:,15)' Seq3(:,18)' Seq3(:,21)' Seq3(:,24)' Seq3(:,27)' Seq3(:,30)' ];
minxval3 = min(xval3) - 0.1;
maxxval3 = max(xval3) + 0.1;
minyval3 = min(yval3) - 0.1;
maxyval3 = max(yval3) + 0.1;
minzval3 = min(zval3) - 0.1;
maxzval3 = max(zval3) + 0.1;

figure(100);
set(gcf, 'Position',  [100, 100, 1400, 500]); % set figure window position and size

% Animation Loop
for i = 1:maxSeqSize
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot the query animation
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    subplot(1,3,1)

    % connect left wrist to left hand
    xplot = [Seq1(i,25) Seq1(i,28)];
    yplot = [Seq1(i,26) Seq1(i,29)];
    zplot = [Seq1(i,27) Seq1(i,30)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'markerfacecolor','b');
    hold on;
    
    % connect shoulder center to hip
    xplot = [Seq1(i,1) Seq1(i,4)];
    yplot = [Seq1(i,2) Seq1(i,5)];
    zplot = [Seq1(i,3) Seq1(i,6)];
    plot3(xplot,yplot,zplot,'-k','linewidth',5,'Markerfacecolor','b');
    hold on;
    
    % connect shoulder center to right shoulder
    xplot = [Seq1(i,1) Seq1(i,7)];
    yplot = [Seq1(i,2) Seq1(i,8)];
    zplot = [Seq1(i,3) Seq1(i,9)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect right shoulder to right elbow
    xplot = [Seq1(i,7) Seq1(i,10)];
    yplot = [Seq1(i,8) Seq1(i,11)];
    zplot = [Seq1(i,9) Seq1(i,12)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect right elbow to right wrist
    xplot = [Seq1(i,10) Seq1(i,13)];
    yplot = [Seq1(i,11) Seq1(i,14)];
    zplot = [Seq1(i,12) Seq1(i,15)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;

    % connect right wrist to right hand
    xplot = [Seq1(i,13) Seq1(i,16)];
    yplot = [Seq1(i,14) Seq1(i,17)];
    zplot = [Seq1(i,15) Seq1(i,18)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'Markerfacecolor','b');
    hold on;

    % connect shoulder center to left shoulder
    xplot = [Seq1(i,1) Seq1(i,19)];
    yplot = [Seq1(i,2) Seq1(i,20)];
    zplot = [Seq1(i,3) Seq1(i,21)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect left shoulder to left elbow
    xplot = [Seq1(i,19) Seq1(i,22)];
    yplot = [Seq1(i,20) Seq1(i,23)];
    zplot = [Seq1(i,21) Seq1(i,24)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect left elbow to left wrist
    xplot = [Seq1(i,22) Seq1(i,25)];
    yplot = [Seq1(i,23) Seq1(i,26)];
    zplot = [Seq1(i,24) Seq1(i,27)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;
    
    % shoulder center
    plot3(Seq1(i,1),Seq1(i,2),Seq1(i,3),'o','MarkerSize',13,'MarkerFaceColor','g','MarkerEdgeColor','k');
    hold on;
    
    % hip
    plot3(Seq1(i,4),Seq1(i,5),Seq1(i,6),'o','MarkerSize',15,'MarkerFaceColor','r','MarkerEdgeColor','k');
    hold on;

    % right shoulder
    plot3(Seq1(i,7),Seq1(i,8),Seq1(i,9),'o','MarkerSize',11,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right elbow
    plot3(Seq1(i,10),Seq1(i,11),Seq1(i,12),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right wrist
    plot3(Seq1(i,13),Seq1(i,14),Seq1(i,15),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right hand
    plot3(Seq1(i,16),Seq1(i,17),Seq1(i,18),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;

    % left shoulder
    plot3(Seq1(i,19),Seq1(i,20),Seq1(i,21),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left elbow
    plot3(Seq1(i,22),Seq1(i,23),Seq1(i,24),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left wrist
    plot3(Seq1(i,25),Seq1(i,26),Seq1(i,27),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
       
    % left hand
    plot3(Seq1(i,28),Seq1(i,29),Seq1(i,30),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;

    hold off;
    
    % set the graph x/y/z coordinate min/max values
    xlim([minxval1 maxxval1]);
    ylim([minyval1 maxyval1]);
    zlim([minzval1 maxzval1]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
    view(-200,-50); % set the azimuth and elevation for viewing the 3D data
    
    title(['Query, Word: ' char(CompMoveData(queryResults(queryResultID,3),1)) ])
    
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot the NN result animation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    subplot(1,3,2)

    % connect left wrist to left hand
    xplot = [Seq2(i,25) Seq2(i,28)];
    yplot = [Seq2(i,26) Seq2(i,29)];
    zplot = [Seq2(i,27) Seq2(i,30)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'markerfacecolor','b');
    hold on;
    
    % connect shoulder center to hip
    xplot = [Seq2(i,1) Seq2(i,4)];
    yplot = [Seq2(i,2) Seq2(i,5)];
    zplot = [Seq2(i,3) Seq2(i,6)];
    plot3(xplot,yplot,zplot,'-k','linewidth',5,'Markerfacecolor','b');
    hold on;
    
    % connect shoulder center to right shoulder
    xplot = [Seq2(i,1) Seq2(i,7)];
    yplot = [Seq2(i,2) Seq2(i,8)];
    zplot = [Seq2(i,3) Seq2(i,9)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect right shoulder to right elbow
    xplot = [Seq2(i,7) Seq2(i,10)];
    yplot = [Seq2(i,8) Seq2(i,11)];
    zplot = [Seq2(i,9) Seq2(i,12)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect right elbow to right wrist
    xplot = [Seq2(i,10) Seq2(i,13)];
    yplot = [Seq2(i,11) Seq2(i,14)];
    zplot = [Seq2(i,12) Seq2(i,15)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;

    % connect right wrist to right hand
    xplot = [Seq2(i,13) Seq2(i,16)];
    yplot = [Seq2(i,14) Seq2(i,17)];
    zplot = [Seq2(i,15) Seq2(i,18)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'Markerfacecolor','b');
    hold on;

    % connect shoulder center to left shoulder
    xplot = [Seq2(i,1) Seq2(i,19)];
    yplot = [Seq2(i,2) Seq2(i,20)];
    zplot = [Seq2(i,3) Seq2(i,21)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect left shoulder to left elbow
    xplot = [Seq2(i,19) Seq2(i,22)];
    yplot = [Seq2(i,20) Seq2(i,23)];
    zplot = [Seq2(i,21) Seq2(i,24)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect left elbow to left wrist
    xplot = [Seq2(i,22) Seq2(i,25)];
    yplot = [Seq2(i,23) Seq2(i,26)];
    zplot = [Seq2(i,24) Seq2(i,27)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;
    
    % shoulder center
    plot3(Seq2(i,1),Seq2(i,2),Seq2(i,3),'o','MarkerSize',13,'MarkerFaceColor','g','MarkerEdgeColor','k');
    hold on;
    
    % hip
    plot3(Seq2(i,4),Seq2(i,5),Seq2(i,6),'o','MarkerSize',15,'MarkerFaceColor','r','MarkerEdgeColor','k');
    hold on;

    % right shoulder
    plot3(Seq2(i,7),Seq2(i,8),Seq2(i,9),'o','MarkerSize',11,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right elbow
    plot3(Seq2(i,10),Seq2(i,11),Seq2(i,12),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right wrist
    plot3(Seq2(i,13),Seq2(i,14),Seq2(i,15),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right hand
    plot3(Seq2(i,16),Seq2(i,17),Seq2(i,18),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;

    % left shoulder
    plot3(Seq2(i,19),Seq2(i,20),Seq2(i,21),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left elbow
    plot3(Seq2(i,22),Seq2(i,23),Seq2(i,24),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left wrist
    plot3(Seq2(i,25),Seq2(i,26),Seq2(i,27),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
       
    % left hand
    plot3(Seq2(i,28),Seq2(i,29),Seq2(i,30),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;

    hold off;
    
    % set the graph x/y/z coordinate min/max values
    xlim([minxval2 maxxval2]);
    ylim([minyval2 maxyval2]);
    zlim([minzval2 maxzval2]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
    view(-200,-50); % set the azimuth and elevation for viewing the 3D data
    
    title(['NN Result, Word: ' char(CompMoveData(queryResults(queryResultID,2),1)) ', Dist: ' num2str(dist1)])

    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot the correct result animation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    subplot(1,3,3)

    % connect left wrist to left hand
    xplot = [Seq3(i,25) Seq3(i,28)];
    yplot = [Seq3(i,26) Seq3(i,29)];
    zplot = [Seq3(i,27) Seq3(i,30)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'markerfacecolor','b');
    hold on;
    
    % connect shoulder center to hip
    xplot = [Seq3(i,1) Seq3(i,4)];
    yplot = [Seq3(i,2) Seq3(i,5)];
    zplot = [Seq3(i,3) Seq3(i,6)];
    plot3(xplot,yplot,zplot,'-k','linewidth',5,'Markerfacecolor','b');
    hold on;
    
    % connect shoulder center to right shoulder
    xplot = [Seq3(i,1) Seq3(i,7)];
    yplot = [Seq3(i,2) Seq3(i,8)];
    zplot = [Seq3(i,3) Seq3(i,9)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect right shoulder to right elbow
    xplot = [Seq3(i,7) Seq3(i,10)];
    yplot = [Seq3(i,8) Seq3(i,11)];
    zplot = [Seq3(i,9) Seq3(i,12)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect right elbow to right wrist
    xplot = [Seq3(i,10) Seq3(i,13)];
    yplot = [Seq3(i,11) Seq3(i,14)];
    zplot = [Seq3(i,12) Seq3(i,15)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;

    % connect right wrist to right hand
    xplot = [Seq3(i,13) Seq3(i,16)];
    yplot = [Seq3(i,14) Seq3(i,17)];
    zplot = [Seq3(i,15) Seq3(i,18)];
    plot3(xplot,yplot,zplot,'-k','linewidth',1,'Markerfacecolor','b');
    hold on;

    % connect shoulder center to left shoulder
    xplot = [Seq3(i,1) Seq3(i,19)];
    yplot = [Seq3(i,2) Seq3(i,20)];
    zplot = [Seq3(i,3) Seq3(i,21)];
    plot3(xplot,yplot,zplot,'-k','linewidth',4,'Markerfacecolor','b');
    hold on;
    
    % connect left shoulder to left elbow
    xplot = [Seq3(i,19) Seq3(i,22)];
    yplot = [Seq3(i,20) Seq3(i,23)];
    zplot = [Seq3(i,21) Seq3(i,24)];
    plot3(xplot,yplot,zplot,'-k','linewidth',3,'Markerfacecolor','b');
    hold on;
    
    % connect left elbow to left wrist
    xplot = [Seq3(i,22) Seq3(i,25)];
    yplot = [Seq3(i,23) Seq3(i,26)];
    zplot = [Seq3(i,24) Seq3(i,27)];
    plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','b');
    hold on;
    
    % shoulder center
    plot3(Seq3(i,1),Seq3(i,2),Seq3(i,3),'o','MarkerSize',13,'MarkerFaceColor','g','MarkerEdgeColor','k');
    hold on;
    
    % hip
    plot3(Seq3(i,4),Seq3(i,5),Seq3(i,6),'o','MarkerSize',15,'MarkerFaceColor','r','MarkerEdgeColor','k');
    hold on;

    % right shoulder
    plot3(Seq3(i,7),Seq3(i,8),Seq3(i,9),'o','MarkerSize',11,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right elbow
    plot3(Seq3(i,10),Seq3(i,11),Seq3(i,12),'o','MarkerSize',9,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right wrist
    plot3(Seq3(i,13),Seq3(i,14),Seq3(i,15),'o','MarkerSize',7,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;
    
    % right hand
    plot3(Seq3(i,16),Seq3(i,17),Seq3(i,18),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','b');
    hold on;

    % left shoulder
    plot3(Seq3(i,19),Seq3(i,20),Seq3(i,21),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left elbow
    plot3(Seq3(i,22),Seq3(i,23),Seq3(i,24),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    
    % left wrist
    plot3(Seq3(i,25),Seq3(i,26),Seq3(i,27),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
       
    % left hand
    plot3(Seq3(i,28),Seq3(i,29),Seq3(i,30),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;

    hold off;
    
    % set the graph x/y/z coordinate min/max values
    xlim([minxval3 maxxval3]);
    ylim([minyval3 maxyval3]);
    zlim([minzval3 maxzval3]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
    view(-200,-50); % set the azimuth and elevation for viewing the 3D data
    
    title(['Correct Result, Word: ' char(CompMoveData(queryResults(queryResultID,3),1)) ', Dist: ' num2str(dist2)])
    
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    ax.Position = [left bottom ax_width ax_height];
    

    drawnow;
    pause(0.1);
%     w = waitforbuttonpress;
end