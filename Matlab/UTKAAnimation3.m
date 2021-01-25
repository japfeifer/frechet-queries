queryResultID = 84;

queryID = queryResults(queryResultID,1);
NNID = queryResults(queryResultID,2);
CorrectID = queryResults(queryResultID,3);

% get cont frechet dist
Q = cell2mat(queryTraj(queryResultID,1));
P = trajStrData(cell2mat(queryTraj(queryResultID,12))).traj;
dist1 = ContFrechet(P,Q); % query to NN Result distance

queryWordID = queryResults(queryResultID,4); % Correct Result word ID
P = trajStrData(find(wordIDs==queryWordID,1)).traj;
dist2 = ContFrechet(P,Q); % query to Correct Result distance

% get sequences
Seq1 = cell2mat(CompMoveData(queryID,4));  
Seq2 = cell2mat(CompMoveData(NNID,4)); 
Seq3 = cell2mat(CompMoveData(CorrectID,4)); 

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
xval1 = [Seq1(:,1)' Seq1(:,4)' Seq1(:,7)' Seq1(:,10)' Seq1(:,13)' Seq1(:,16)' Seq1(:,19)' Seq1(:,22)' Seq1(:,25)' Seq1(:,28)' Seq1(:,31)' Seq1(:,34)' Seq1(:,37)' Seq1(:,40)' Seq1(:,43)' Seq1(:,46)' Seq1(:,49)' Seq1(:,52)' Seq1(:,55)' Seq1(:,58)' ];
yval1 = [Seq1(:,2)' Seq1(:,5)' Seq1(:,8)' Seq1(:,11)' Seq1(:,14)' Seq1(:,17)' Seq1(:,20)' Seq1(:,23)' Seq1(:,26)' Seq1(:,29)' Seq1(:,32)' Seq1(:,35)' Seq1(:,37)' Seq1(:,41)' Seq1(:,44)' Seq1(:,47)' Seq1(:,50)' Seq1(:,53)' Seq1(:,56)' Seq1(:,59)' ];
zval1 = [Seq1(:,3)' Seq1(:,6)' Seq1(:,9)' Seq1(:,12)' Seq1(:,15)' Seq1(:,18)' Seq1(:,21)' Seq1(:,24)' Seq1(:,27)' Seq1(:,30)' Seq1(:,33)' Seq1(:,36)' Seq1(:,39)' Seq1(:,42)' Seq1(:,45)' Seq1(:,48)' Seq1(:,51)' Seq1(:,54)' Seq1(:,57)' Seq1(:,60)' ];
minxval1 = min(xval1) - 0.1;
maxxval1 = max(xval1) + 0.1;
minyval1 = min(yval1) - 0.1;
maxyval1 = max(yval1) + 0.1;
minzval1 = min(zval1) - 0.1;
maxzval1 = max(zval1) + 0.1;

xval2 = [Seq2(:,1)' Seq2(:,4)' Seq2(:,7)' Seq2(:,10)' Seq2(:,13)' Seq2(:,16)' Seq2(:,19)' Seq2(:,22)' Seq2(:,25)' Seq2(:,28)' Seq2(:,31)' Seq2(:,34)' Seq2(:,37)' Seq2(:,40)' Seq2(:,43)' Seq2(:,46)' Seq2(:,49)' Seq2(:,52)' Seq2(:,55)' Seq2(:,58)' ];
yval2 = [Seq2(:,2)' Seq2(:,5)' Seq2(:,8)' Seq2(:,11)' Seq2(:,14)' Seq2(:,17)' Seq2(:,20)' Seq2(:,23)' Seq2(:,26)' Seq2(:,29)' Seq2(:,32)' Seq2(:,35)' Seq2(:,37)' Seq2(:,41)' Seq2(:,44)' Seq2(:,47)' Seq2(:,50)' Seq2(:,53)' Seq2(:,56)' Seq2(:,59)' ];
zval2 = [Seq2(:,3)' Seq2(:,6)' Seq2(:,9)' Seq2(:,12)' Seq2(:,15)' Seq2(:,18)' Seq2(:,21)' Seq2(:,24)' Seq2(:,27)' Seq2(:,30)' Seq2(:,33)' Seq2(:,36)' Seq2(:,39)' Seq2(:,42)' Seq2(:,45)' Seq2(:,48)' Seq2(:,51)' Seq2(:,54)' Seq2(:,57)' Seq2(:,60)' ];
minxval2 = min(xval2) - 0.1;
maxxval2 = max(xval2) + 0.1;
minyval2 = min(yval2) - 0.1;
maxyval2 = max(yval2) + 0.1;
minzval2 = min(zval2) - 0.1;
maxzval2 = max(zval2) + 0.1;

xval3 = [Seq3(:,1)' Seq3(:,4)' Seq3(:,7)' Seq3(:,10)' Seq3(:,13)' Seq3(:,16)' Seq3(:,19)' Seq3(:,22)' Seq3(:,25)' Seq3(:,28)' Seq3(:,31)' Seq3(:,34)' Seq3(:,37)' Seq3(:,40)' Seq3(:,43)' Seq3(:,46)' Seq3(:,49)' Seq3(:,52)' Seq3(:,55)' Seq3(:,58)' ];
yval3 = [Seq3(:,2)' Seq3(:,5)' Seq3(:,8)' Seq3(:,11)' Seq3(:,14)' Seq3(:,17)' Seq3(:,20)' Seq3(:,23)' Seq3(:,26)' Seq3(:,29)' Seq3(:,32)' Seq3(:,35)' Seq3(:,37)' Seq3(:,41)' Seq3(:,44)' Seq3(:,47)' Seq3(:,50)' Seq3(:,53)' Seq3(:,56)' Seq3(:,59)' ];
zval3 = [Seq3(:,3)' Seq3(:,6)' Seq3(:,9)' Seq3(:,12)' Seq3(:,15)' Seq3(:,18)' Seq3(:,21)' Seq3(:,24)' Seq3(:,27)' Seq3(:,30)' Seq3(:,33)' Seq3(:,36)' Seq3(:,39)' Seq3(:,42)' Seq3(:,45)' Seq3(:,48)' Seq3(:,51)' Seq3(:,54)' Seq3(:,57)' Seq3(:,60)' ];
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

    % 
    plot3(Seq1(i,1),Seq1(i,2),Seq1(i,3),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,4),Seq1(i,5),Seq1(i,6),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,7),Seq1(i,8),Seq1(i,9),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,10),Seq1(i,11),Seq1(i,12),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,13),Seq1(i,14),Seq1(i,15),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,16),Seq1(i,17),Seq1(i,18),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,19),Seq1(i,20),Seq1(i,21),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,22),Seq1(i,23),Seq1(i,24),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,25),Seq1(i,26),Seq1(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,28),Seq1(i,29),Seq1(i,30),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,31),Seq1(i,32),Seq1(i,33),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,34),Seq1(i,35),Seq1(i,36),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,37),Seq1(i,38),Seq1(i,39),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,40),Seq1(i,41),Seq1(i,42),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,43),Seq1(i,44),Seq1(i,45),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,46),Seq1(i,47),Seq1(i,48),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,49),Seq1(i,50),Seq1(i,51),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,52),Seq1(i,53),Seq1(i,54),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,55),Seq1(i,56),Seq1(i,57),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq1(i,58),Seq1(i,59),Seq1(i,60),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
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

    % 
    plot3(Seq2(i,1),Seq2(i,2),Seq2(i,3),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,4),Seq2(i,5),Seq2(i,6),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,7),Seq2(i,8),Seq2(i,9),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,10),Seq2(i,11),Seq2(i,12),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,13),Seq2(i,14),Seq2(i,15),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,16),Seq2(i,17),Seq2(i,18),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,19),Seq2(i,20),Seq2(i,21),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,22),Seq2(i,23),Seq2(i,24),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,25),Seq2(i,26),Seq2(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,28),Seq2(i,29),Seq2(i,30),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,31),Seq2(i,32),Seq2(i,33),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,34),Seq2(i,35),Seq2(i,36),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,37),Seq2(i,38),Seq2(i,39),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,40),Seq2(i,41),Seq2(i,42),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,43),Seq2(i,44),Seq2(i,45),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,46),Seq2(i,47),Seq2(i,48),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,49),Seq2(i,50),Seq2(i,51),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,52),Seq2(i,53),Seq2(i,54),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,55),Seq2(i,56),Seq2(i,57),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq2(i,58),Seq2(i,59),Seq2(i,60),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
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

    % 
    plot3(Seq3(i,1),Seq3(i,2),Seq3(i,3),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,4),Seq3(i,5),Seq3(i,6),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,7),Seq3(i,8),Seq3(i,9),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,10),Seq3(i,11),Seq3(i,12),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,13),Seq3(i,14),Seq3(i,15),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,16),Seq3(i,17),Seq3(i,18),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,19),Seq3(i,20),Seq3(i,21),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,22),Seq3(i,23),Seq3(i,24),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,25),Seq3(i,26),Seq3(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,28),Seq3(i,29),Seq3(i,30),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,31),Seq3(i,32),Seq3(i,33),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,34),Seq3(i,35),Seq3(i,36),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,37),Seq3(i,38),Seq3(i,39),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,40),Seq3(i,41),Seq3(i,42),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,43),Seq3(i,44),Seq3(i,45),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,46),Seq3(i,47),Seq3(i,48),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,49),Seq3(i,50),Seq3(i,51),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,52),Seq3(i,53),Seq3(i,54),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,55),Seq3(i,56),Seq3(i,57),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(Seq3(i,58),Seq3(i,59),Seq3(i,60),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
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