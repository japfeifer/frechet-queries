% get UTKA sign language sequence
UTKASeq = cell2mat(CompMoveData(200,4));   

% set plot coordinate min/max values
xval = [UTKASeq(:,1)' UTKASeq(:,4)' UTKASeq(:,7)' UTKASeq(:,10)' UTKASeq(:,13)' UTKASeq(:,16)' UTKASeq(:,19)' UTKASeq(:,22)' UTKASeq(:,25)' UTKASeq(:,28)' UTKASeq(:,31)' UTKASeq(:,34)' UTKASeq(:,37)' UTKASeq(:,40)' UTKASeq(:,43)' UTKASeq(:,46)' UTKASeq(:,49)' UTKASeq(:,52)' UTKASeq(:,55)' UTKASeq(:,58)' ];
yval = [UTKASeq(:,2)' UTKASeq(:,5)' UTKASeq(:,8)' UTKASeq(:,11)' UTKASeq(:,14)' UTKASeq(:,17)' UTKASeq(:,20)' UTKASeq(:,23)' UTKASeq(:,26)' UTKASeq(:,29)' UTKASeq(:,32)' UTKASeq(:,35)' UTKASeq(:,37)' UTKASeq(:,41)' UTKASeq(:,44)' UTKASeq(:,47)' UTKASeq(:,50)' UTKASeq(:,53)' UTKASeq(:,56)' UTKASeq(:,59)' ];
zval = [UTKASeq(:,3)' UTKASeq(:,6)' UTKASeq(:,9)' UTKASeq(:,12)' UTKASeq(:,15)' UTKASeq(:,18)' UTKASeq(:,21)' UTKASeq(:,24)' UTKASeq(:,27)' UTKASeq(:,30)' UTKASeq(:,33)' UTKASeq(:,36)' UTKASeq(:,39)' UTKASeq(:,42)' UTKASeq(:,45)' UTKASeq(:,48)' UTKASeq(:,51)' UTKASeq(:,54)' UTKASeq(:,57)' UTKASeq(:,60)' ];
minxval = min(xval) - 0.1;
maxxval = max(xval) + 0.1;
minyval = min(yval) - 0.1;
maxyval = max(yval) + 0.1;
minzval = min(zval) - 0.1;
maxzval = max(zval) + 0.1;

figure(100);
set(gcf, 'Position',  [100, 100, 600, 600]); % set figure window position and size

% Animation Loop

for i = 1:size(UTKASeq,1)

    % 
    plot3(UTKASeq(i,1),UTKASeq(i,2),UTKASeq(i,3),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,4),UTKASeq(i,5),UTKASeq(i,6),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,7),UTKASeq(i,8),UTKASeq(i,9),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,10),UTKASeq(i,11),UTKASeq(i,12),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,13),UTKASeq(i,14),UTKASeq(i,15),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,16),UTKASeq(i,17),UTKASeq(i,18),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,19),UTKASeq(i,20),UTKASeq(i,21),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,22),UTKASeq(i,23),UTKASeq(i,24),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,25),UTKASeq(i,26),UTKASeq(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,28),UTKASeq(i,29),UTKASeq(i,30),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,31),UTKASeq(i,32),UTKASeq(i,33),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,34),UTKASeq(i,35),UTKASeq(i,36),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,37),UTKASeq(i,38),UTKASeq(i,39),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,40),UTKASeq(i,41),UTKASeq(i,42),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,43),UTKASeq(i,44),UTKASeq(i,45),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,46),UTKASeq(i,47),UTKASeq(i,48),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,49),UTKASeq(i,50),UTKASeq(i,51),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,52),UTKASeq(i,53),UTKASeq(i,54),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,55),UTKASeq(i,56),UTKASeq(i,57),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(UTKASeq(i,58),UTKASeq(i,59),UTKASeq(i,60),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
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