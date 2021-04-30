% MS-ASL Animation sign language sequence
% seqID = 1074;  
seqID = 34;  
seq = cell2mat(CompMoveData(seqID,4));  

seq = MSASLNormalizeSeq(seq,[0 1 1 1]);

HEAD = [1,2,3];         NECK = [4,5,6];         RSHO = [7,8,9];        RELB = [10,11,12];
RWST = [13,14,15];      LSHO = [16,17,18];      LELB = [19,20,21];     LWST = [22,23,24];
RHIP = [25,26,27];      RKNE = [28,29,30];      RFOT = [31,32,33];     LHIP = [34,35,36];
LKNE = [37,38,39];      LFOT = [40,41,42];      REYE = [43,44,45];     LEYE = [46,47,48];
REAR = [49,50,51];      LEAR = [52,53,54]; 

LTPR = [61,62,63];      LTDI = [64,65,66];      LTEF = [67,68,69];                            % thumb
LIPR = [70,71,72];      LIME = [73,74,75];      LIDI = [76,77,78];     LIEF = [79,80,81];     % index finger
LMPR = [82,83,84];      LMME = [85,86,87];      LMDI = [88,89,90];     LMEF = [91,92,93];     % middle finger
LRPR = [94,95,96];      LRME = [97,98,99];      LRDI = [100,101,102];  LREF = [103,104,105];  % ring finger
LPPR = [106,107,108];   LPME = [109,110,111];   LPDI = [112,113,114];  LPEF = [115,116,117];  % pinky finger
LPAL = [55,56,57];      LTPA = [58,59,60];                                                    % palm and thumb palm

RTPR = [124,125,126];   RTDI = [127,128,129];   RTEF = [130,131,132];                         % thumb
RIPR = [133,134,135];   RIME = [136,137,138];   RIDI = [139,140,141];  RIEF = [142,143,144];  % index finger
RMPR = [145,146,147];   RMME = [148,149,150];   RMDI = [151,152,153];  RMEF = [154,155,156];  % middle finger
RRPR = [157,158,159];   RRME = [160,161,162];   RRDI = [163,164,165];  RREF = [166,167,168];  % ring finger
RPPR = [169,170,171];   RPME = [172,173,174];   RPDI = [175,176,177];  RPEF = [178,179,180];  % pinky finger
RPAL = [118,119,120];   RTPA = [121,122,123];                                                 % palm and thumb palm

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' ...
        seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' ... 
        seq(:,61)' seq(:,64)' seq(:,67)' seq(:,70)' seq(:,73)' seq(:,76)' seq(:,79)' seq(:,82)' seq(:,85)' seq(:,88)' ...
        seq(:,91)' seq(:,94)' seq(:,97)' seq(:,100)' seq(:,103)' seq(:,106)' seq(:,109)' seq(:,112)' seq(:,115)' seq(:,118)' ...
        seq(:,121)' seq(:,124)' seq(:,127)' seq(:,130)' seq(:,133)' seq(:,136)' seq(:,139)' seq(:,142)' seq(:,145)' ...
        seq(:,148)' seq(:,151)' seq(:,154)' seq(:,157)' seq(:,160)' seq(:,163)' seq(:,166)' seq(:,169)' seq(:,172)' seq(:,175)' seq(:,178)'];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' ...
        seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' ...
        seq(:,62)' seq(:,65)' seq(:,68)' seq(:,71)' seq(:,74)' seq(:,77)' seq(:,80)' seq(:,83)' seq(:,86)' seq(:,89)' ...
        seq(:,92)' seq(:,95)' seq(:,98)' seq(:,101)' seq(:,104)' seq(:,107)' seq(:,110)' seq(:,113)' seq(:,116)' seq(:,119)' ...
        seq(:,122)' seq(:,125)' seq(:,128)' seq(:,131)' seq(:,134)' seq(:,137)' seq(:,140)' seq(:,143)' seq(:,146)' ...
        seq(:,149)' seq(:,152)' seq(:,155)' seq(:,158)' seq(:,161)' seq(:,164)' seq(:,167)' seq(:,170)' seq(:,173)' seq(:,176)' seq(:,179)'];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' ...
        seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' ...
        seq(:,63)' seq(:,66)' seq(:,69)' seq(:,72)' seq(:,75)' seq(:,78)' seq(:,81)' seq(:,84)' seq(:,87)' seq(:,90)' ...
        seq(:,93)' seq(:,96)' seq(:,99)' seq(:,102)' seq(:,105)' seq(:,108)' seq(:,111)' seq(:,114)' seq(:,117)' seq(:,120)' ...
        seq(:,123)' seq(:,126)' seq(:,129)' seq(:,132)' seq(:,135)' seq(:,138)' seq(:,141)' seq(:,144)' seq(:,147)' ...
        seq(:,150)' seq(:,153)' seq(:,156)' seq(:,159)' seq(:,162)' seq(:,165)' seq(:,168)' seq(:,171)' seq(:,174)' seq(:,177)' seq(:,180)'];
minxval = min(xval) - 0.1;
maxxval = max(xval) + 0.1;
minyval = min(yval) - 0.1;
maxyval = max(yval) + 0.1;
minzval = min(zval) - 0.1;
maxzval = max(zval) + 0.1;

figure(100);
set(gcf, 'Position',  [100, 100, 600, 600]); % set figure window position and size

% ax = gca;
% ax.XDir = 'reverse';
% ax.YDir = 'reverse';

% Animation Loop
for i = 1:size(seq,1)

    % 18 coco joints
    plot3(seq(i,HEAD(1)),seq(i,HEAD(2)),seq(i,HEAD(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,NECK(1)),seq(i,NECK(2)),seq(i,NECK(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RSHO(1)),seq(i,RSHO(2)),seq(i,RSHO(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RELB(1)),seq(i,RELB(2)),seq(i,RELB(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RWST(1)),seq(i,RWST(2)),seq(i,RWST(3)),'+','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LSHO(1)),seq(i,LSHO(2)),seq(i,LSHO(3)),'x','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LELB(1)),seq(i,LELB(2)),seq(i,LELB(3)),'x','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LWST(1)),seq(i,LWST(2)),seq(i,LWST(3)),'x','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RHIP(1)),seq(i,RHIP(2)),seq(i,RHIP(3)),'s','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RKNE(1)),seq(i,RKNE(2)),seq(i,RKNE(3)),'s','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RFOT(1)),seq(i,RFOT(2)),seq(i,RFOT(3)),'s','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LHIP(1)),seq(i,LHIP(2)),seq(i,LHIP(3)),'d','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LKNE(1)),seq(i,LKNE(2)),seq(i,LKNE(3)),'d','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LFOT(1)),seq(i,LFOT(2)),seq(i,LFOT(3)),'d','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,REYE(1)),seq(i,REYE(2)),seq(i,REYE(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LEYE(1)),seq(i,LEYE(2)),seq(i,LEYE(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,REAR(1)),seq(i,REAR(2)),seq(i,REAR(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LEAR(1)),seq(i,LEAR(2)),seq(i,LEAR(3)),'^','MarkerSize',5,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,HEAD,REYE);
    ConnectJoint(seq,i,HEAD,LEYE);
    ConnectJoint(seq,i,REYE,REAR);
    ConnectJoint(seq,i,LEYE,LEAR);
    ConnectJoint(seq,i,HEAD,NECK);
    ConnectJoint(seq,i,NECK,RSHO);
    ConnectJoint(seq,i,NECK,LSHO);
    ConnectJoint(seq,i,RSHO,RELB);
    ConnectJoint(seq,i,LSHO,LELB);
    ConnectJoint(seq,i,RELB,RWST);
    ConnectJoint(seq,i,LELB,LWST);
    
    % 21 left hand joints
    ConnectJoint(seq,i,LWST,LPAL);
    plot3(seq(i,LPAL(1)),seq(i,LPAL(2)),seq(i,LPAL(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LTPA(1)),seq(i,LTPA(2)),seq(i,LTPA(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LPAL,LTPA);
    plot3(seq(i,LTPR(1)),seq(i,LTPR(2)),seq(i,LTPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LTDI(1)),seq(i,LTDI(2)),seq(i,LTDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LTEF(1)),seq(i,LTEF(2)),seq(i,LTEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LTPA,LTPR);
    ConnectJoint(seq,i,LTPR,LTDI);
    ConnectJoint(seq,i,LTDI,LTEF);
    plot3(seq(i,LIPR(1)),seq(i,LIPR(2)),seq(i,LIPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LIME(1)),seq(i,LIME(2)),seq(i,LIME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LIDI(1)),seq(i,LIDI(2)),seq(i,LIDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LIEF(1)),seq(i,LIEF(2)),seq(i,LIEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LPAL,LIPR);
    ConnectJoint(seq,i,LIPR,LIME);
    ConnectJoint(seq,i,LIME,LIDI);
    ConnectJoint(seq,i,LIDI,LIEF);
    plot3(seq(i,LMPR(1)),seq(i,LMPR(2)),seq(i,LMPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LMME(1)),seq(i,LMME(2)),seq(i,LMME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LMDI(1)),seq(i,LMDI(2)),seq(i,LMDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LMEF(1)),seq(i,LMEF(2)),seq(i,LMEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LPAL,LMPR);
    ConnectJoint(seq,i,LMPR,LMME);
    ConnectJoint(seq,i,LMME,LMDI);
    ConnectJoint(seq,i,LMDI,LMEF);
    plot3(seq(i,LRPR(1)),seq(i,LRPR(2)),seq(i,LRPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LRME(1)),seq(i,LRME(2)),seq(i,LRME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LRDI(1)),seq(i,LRDI(2)),seq(i,LRDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LREF(1)),seq(i,LREF(2)),seq(i,LREF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LPAL,LRPR);
    ConnectJoint(seq,i,LRPR,LRME);
    ConnectJoint(seq,i,LRME,LRDI);
    ConnectJoint(seq,i,LRDI,LREF);
    plot3(seq(i,LIPR(1)),seq(i,LIPR(2)),seq(i,LIPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LIME(1)),seq(i,LIME(2)),seq(i,LIME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LIDI(1)),seq(i,LIDI(2)),seq(i,LIDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LIEF(1)),seq(i,LIEF(2)),seq(i,LIEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LPAL,LIPR);
    ConnectJoint(seq,i,LIPR,LIME);
    ConnectJoint(seq,i,LIME,LIDI);
    ConnectJoint(seq,i,LIDI,LIEF);
    plot3(seq(i,LPPR(1)),seq(i,LPPR(2)),seq(i,LPPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LPME(1)),seq(i,LPME(2)),seq(i,LPME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LPDI(1)),seq(i,LPDI(2)),seq(i,LPDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LPEF(1)),seq(i,LPEF(2)),seq(i,LPEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,LPAL,LPPR);
    ConnectJoint(seq,i,LPPR,LPME);
    ConnectJoint(seq,i,LPME,LPDI);
    ConnectJoint(seq,i,LPDI,LPEF);
    
    % 21 right hand joints
    ConnectJoint(seq,i,RWST,RPAL);
    plot3(seq(i,RPAL(1)),seq(i,RPAL(2)),seq(i,RPAL(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RTPA(1)),seq(i,RTPA(2)),seq(i,RTPA(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RPAL,RTPA);
    plot3(seq(i,RTPR(1)),seq(i,RTPR(2)),seq(i,RTPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RTDI(1)),seq(i,RTDI(2)),seq(i,RTDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RTEF(1)),seq(i,RTEF(2)),seq(i,RTEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RTPA,RTPR);
    ConnectJoint(seq,i,RTPR,RTDI);
    ConnectJoint(seq,i,RTDI,RTEF);
    plot3(seq(i,RIPR(1)),seq(i,RIPR(2)),seq(i,RIPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RIME(1)),seq(i,RIME(2)),seq(i,RIME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RIDI(1)),seq(i,RIDI(2)),seq(i,RIDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RIEF(1)),seq(i,RIEF(2)),seq(i,RIEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RPAL,RIPR);
    ConnectJoint(seq,i,RIPR,RIME);
    ConnectJoint(seq,i,RIME,RIDI);
    ConnectJoint(seq,i,RIDI,RIEF);
    plot3(seq(i,RMPR(1)),seq(i,RMPR(2)),seq(i,RMPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RMME(1)),seq(i,RMME(2)),seq(i,RMME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RMDI(1)),seq(i,RMDI(2)),seq(i,RMDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RMEF(1)),seq(i,RMEF(2)),seq(i,RMEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RPAL,RMPR);
    ConnectJoint(seq,i,RMPR,RMME);
    ConnectJoint(seq,i,RMME,RMDI);
    ConnectJoint(seq,i,RMDI,RMEF);
    plot3(seq(i,RRPR(1)),seq(i,RRPR(2)),seq(i,RRPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RRME(1)),seq(i,RRME(2)),seq(i,RRME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RRDI(1)),seq(i,RRDI(2)),seq(i,RRDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RREF(1)),seq(i,RREF(2)),seq(i,RREF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RPAL,RRPR);
    ConnectJoint(seq,i,RRPR,RRME);
    ConnectJoint(seq,i,RRME,RRDI);
    ConnectJoint(seq,i,RRDI,RREF);
    plot3(seq(i,RIPR(1)),seq(i,RIPR(2)),seq(i,RIPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RIME(1)),seq(i,RIME(2)),seq(i,RIME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RIDI(1)),seq(i,RIDI(2)),seq(i,RIDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RIEF(1)),seq(i,RIEF(2)),seq(i,RIEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RPAL,RIPR);
    ConnectJoint(seq,i,RIPR,RIME);
    ConnectJoint(seq,i,RIME,RIDI);
    ConnectJoint(seq,i,RIDI,RIEF);
    plot3(seq(i,RPPR(1)),seq(i,RPPR(2)),seq(i,RPPR(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RPME(1)),seq(i,RPME(2)),seq(i,RPME(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RPDI(1)),seq(i,RPDI(2)),seq(i,RPDI(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RPEF(1)),seq(i,RPEF(2)),seq(i,RPEF(3)),'o','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    ConnectJoint(seq,i,RPAL,RPPR);
    ConnectJoint(seq,i,RPPR,RPME);
    ConnectJoint(seq,i,RPME,RPDI);
    ConnectJoint(seq,i,RPDI,RPEF);

    hold off;

    % set the graph x/y/z coordinate min/max values
    xlim([minxval maxxval]);
    ylim([minyval maxyval]);
    zlim([minzval maxzval]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
    view(0,-90); % set the azimuth and elevation for viewing the 3D data

    drawnow;
%     pause(0.1);
%     w = waitforbuttonpress;
end