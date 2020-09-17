% get MSRA sign language sequence
seq = cell2mat(CompMoveData(6,4));   

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' ];
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

    % 
    plot3(seq(i,1),seq(i,2),seq(i,3),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,4),seq(i,5),seq(i,6),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,7),seq(i,8),seq(i,9),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,10),seq(i,11),seq(i,12),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,13),seq(i,14),seq(i,15),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,16),seq(i,17),seq(i,18),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,19),seq(i,20),seq(i,21),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,22),seq(i,23),seq(i,24),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,25),seq(i,26),seq(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,28),seq(i,29),seq(i,30),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,31),seq(i,32),seq(i,33),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,34),seq(i,35),seq(i,36),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,37),seq(i,38),seq(i,39),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,40),seq(i,41),seq(i,42),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,43),seq(i,44),seq(i,45),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,46),seq(i,47),seq(i,48),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,49),seq(i,50),seq(i,51),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,52),seq(i,53),seq(i,54),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,55),seq(i,56),seq(i,57),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,58),seq(i,59),seq(i,60),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
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