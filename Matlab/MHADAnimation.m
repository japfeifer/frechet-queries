% get MHAD sign language sequence
seqID = 71;   
seq = cell2mat(CompMoveData(seqID,4));  

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' seq(:,61)' seq(:,64)' seq(:,67)' seq(:,70)' seq(:,73)' seq(:,76)' seq(:,79)' seq(:,82)' seq(:,85)' seq(:,88)' seq(:,91)' seq(:,94)' seq(:,97)' seq(:,100)' seq(:,103)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' seq(:,62)' seq(:,65)' seq(:,68)' seq(:,71)' seq(:,74)' seq(:,77)' seq(:,80)' seq(:,83)' seq(:,86)' seq(:,89)' seq(:,92)' seq(:,95)' seq(:,98)' seq(:,101)' seq(:,104)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' seq(:,63)' seq(:,66)' seq(:,69)' seq(:,72)' seq(:,75)' seq(:,78)' seq(:,81)' seq(:,84)' seq(:,87)' seq(:,90)' seq(:,93)' seq(:,96)' seq(:,99)' seq(:,102)' seq(:,105)' ];
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
    plot3(seq(i,1),seq(i,2),seq(i,3),'o','MarkerSize',7,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,4),seq(i,5),seq(i,6),'o','MarkerSize',9,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,7),seq(i,8),seq(i,9),'o','MarkerSize',11,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,10),seq(i,11),seq(i,12),'o','MarkerSize',13,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,13),seq(i,14),seq(i,15),'o','MarkerSize',15,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,16),seq(i,17),seq(i,18),'o','MarkerSize',17,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
%     % 
%     plot3(seq(i,19),seq(i,20),seq(i,21),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
    % 
    plot3(seq(i,22),seq(i,23),seq(i,24),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,25),seq(i,26),seq(i,27),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,28),seq(i,29),seq(i,30),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,31),seq(i,32),seq(i,33),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,34),seq(i,35),seq(i,36),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,37),seq(i,38),seq(i,39),'o','MarkerSize',5,'MarkerFaceColor','b','MarkerEdgeColor','k');
    hold on;
%     % 
%     plot3(seq(i,40),seq(i,41),seq(i,42),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
    % 
    plot3(seq(i,43),seq(i,44),seq(i,45),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,46),seq(i,47),seq(i,48),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,49),seq(i,50),seq(i,51),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,52),seq(i,53),seq(i,54),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,55),seq(i,56),seq(i,57),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,58),seq(i,59),seq(i,60),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
%     % 
%     plot3(seq(i,61),seq(i,62),seq(i,63),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
    % 
    plot3(seq(i,64),seq(i,65),seq(i,66),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,67),seq(i,68),seq(i,69),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,70),seq(i,71),seq(i,72),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,73),seq(i,74),seq(i,75),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,76),seq(i,77),seq(i,78),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,79),seq(i,80),seq(i,81),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
%     % 
%     plot3(seq(i,82),seq(i,83),seq(i,84),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;
    % 
    plot3(seq(i,85),seq(i,86),seq(i,87),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,88),seq(i,89),seq(i,90),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,91),seq(i,92),seq(i,93),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,94),seq(i,95),seq(i,96),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,97),seq(i,98),seq(i,99),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
    % 
    plot3(seq(i,100),seq(i,101),seq(i,102),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
    hold on;
%     % 
%     plot3(seq(i,103),seq(i,104),seq(i,105),'o','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k');
%     hold on;

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