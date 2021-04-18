% MS-ASL Animation sign language sequence
seqID = 3;   
seq = cell2mat(CompMoveData(seqID,4));  

HEAD  = [1,2,3]; SHO = [4,5,6]; RSHO = [7,8,9]; RELB = [10,11,12];
RHND = [13,14,15]; LSHO = [16,17,18]; LELB = [19,20,21]; LHND = [22,23,24];
RHIP = [25,26,27]; RKNE = [28,29,30]; RFOT = [31,32,33]; LHIP = [34,35,36];
LKNE = [37,38,39]; LFOT = [40,41,42]; RHED = [43,44,45]; LHED = [46,47,48];
REAR = [49,50,51]; LEAR = [52,53,54]; 

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' ];
minxval = min(xval) - 0.1;
maxxval = max(xval) + 100;
minyval = min(yval) - 0.1;
maxyval = max(yval) + 100;
minzval = min(zval) - 0.1;
maxzval = max(zval) + 0.1;

figure(100);
set(gcf, 'Position',  [100, 100, 600, 600]); % set figure window position and size

% ax = gca;
% ax.XDir = 'reverse';
% ax.YDir = 'reverse';

% Animation Loop
for i = 1:size(seq,1)

    plot3(seq(i,HEAD(1)),seq(i,HEAD(2)),seq(i,HEAD(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,SHO(1)),seq(i,SHO(2)),seq(i,SHO(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RSHO(1)),seq(i,RSHO(2)),seq(i,RSHO(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RELB(1)),seq(i,RELB(2)),seq(i,RELB(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RHND(1)),seq(i,RHND(2)),seq(i,RHND(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LSHO(1)),seq(i,LSHO(2)),seq(i,LSHO(3)),'x','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LELB(1)),seq(i,LELB(2)),seq(i,LELB(3)),'x','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LHND(1)),seq(i,LHND(2)),seq(i,LHND(3)),'x','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RHIP(1)),seq(i,RHIP(2)),seq(i,RHIP(3)),'s','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RKNE(1)),seq(i,RKNE(2)),seq(i,RKNE(3)),'s','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RFOT(1)),seq(i,RFOT(2)),seq(i,RFOT(3)),'s','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LHIP(1)),seq(i,LHIP(2)),seq(i,LHIP(3)),'d','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LKNE(1)),seq(i,LKNE(2)),seq(i,LKNE(3)),'d','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LFOT(1)),seq(i,LFOT(2)),seq(i,LFOT(3)),'d','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RHED(1)),seq(i,RHED(2)),seq(i,RHED(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LHED(1)),seq(i,LHED(2)),seq(i,LHED(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,REAR(1)),seq(i,REAR(2)),seq(i,REAR(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LEAR(1)),seq(i,LEAR(2)),seq(i,LEAR(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    
    if seq(i,HEAD(1)) ~= 0 && seq(i,RHED(1)) ~= 0
        ConnectJoint(seq,i,HEAD,RHED);
    end
    if seq(i,HEAD(1)) ~= 0 && seq(i,LHED(1)) ~= 0
        ConnectJoint(seq,i,HEAD,LHED);
    end
    if seq(i,RHED(1)) ~= 0 && seq(i,REAR(1)) ~= 0
        ConnectJoint(seq,i,RHED,REAR);
    end
    if seq(i,LHED(1)) ~= 0 && seq(i,LEAR(1)) ~= 0
        ConnectJoint(seq,i,LHED,LEAR);
    end
    if seq(i,HEAD(1)) ~= 0 && seq(i,SHO(1)) ~= 0
        ConnectJoint(seq,i,HEAD,SHO);
    end
    if seq(i,SHO(1)) ~= 0 && seq(i,RSHO(1)) ~= 0
        ConnectJoint(seq,i,SHO,RSHO);
    end
    if seq(i,SHO(1)) ~= 0 && seq(i,LSHO(1)) ~= 0
        ConnectJoint(seq,i,SHO,LSHO);
    end
    if seq(i,RSHO(1)) ~= 0 && seq(i,RELB(1)) ~= 0
        ConnectJoint(seq,i,RSHO,RELB);
    end
    if seq(i,LSHO(1)) ~= 0 && seq(i,LELB(1)) ~= 0
        ConnectJoint(seq,i,LSHO,LELB);
    end
    if seq(i,RELB(1)) ~= 0 && seq(i,RHND(1)) ~= 0
        ConnectJoint(seq,i,RELB,RHND);
    end
    if seq(i,LELB(1)) ~= 0 && seq(i,LHND(1)) ~= 0
        ConnectJoint(seq,i,LELB,LHND);
    end
    if seq(i,SHO(1)) ~= 0 && seq(i,RHIP(1)) ~= 0
        ConnectJoint(seq,i,SHO,RHIP);
    end
    if seq(i,SHO(1)) ~= 0 && seq(i,LHIP(1)) ~= 0
        ConnectJoint(seq,i,SHO,LHIP);
    end
    if seq(i,RHIP(1)) ~= 0 && seq(i,RKNE(1)) ~= 0
        ConnectJoint(seq,i,RHIP,RKNE);
    end
    if seq(i,LHIP(1)) ~= 0 && seq(i,LKNE(1)) ~= 0
        ConnectJoint(seq,i,LHIP,LKNE);
    end
    if seq(i,RKNE(1)) ~= 0 && seq(i,RFOT(1)) ~= 0
        ConnectJoint(seq,i,RKNE,RFOT);
    end
    if seq(i,LKNE(1)) ~= 0 && seq(i,LFOT(1)) ~= 0
        ConnectJoint(seq,i,LKNE,LFOT);
    end

    hold off;

    % set the graph x/y/z coordinate min/max values
    xlim([minxval maxxval]);
    ylim([minyval maxyval]);
    zlim([minzval maxzval]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
    view(0,-90); % set the azimuth and elevation for viewing the 3D data

    drawnow;
%     pause(0.1);
    w = waitforbuttonpress;
end