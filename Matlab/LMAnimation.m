% get ASLLM American Sign Language Leap Motion sequence
% seq = [];
seqID = 1772;   
seq = cell2mat(CompMoveData(seqID,4));   

seq = LMNormalizeSeq(seq,[0 0 0 0 0 1]);

LTPR = [1,2,3];       LTDI = [4,5,6];       LTEF = [7,8,9];
LIPR = [10,11,12];    LIME = [13,14,15];    LIDI = [16,17,18];    LIEF = [19,20,21];
LMPR = [22,23,24];    LMME = [25,26,27];    LMDI = [28,29,30];    LMEF = [31,32,33];
LRPR = [34,35,36];    LRME = [37,38,39];    LRDI = [40,41,42];    LREF = [43,44,45];
LPPR = [46,47,48];    LPME = [49,50,51];    LPDI = [52,53,54];    LPEF = [55,56,57];
LPAL = [58,59,60];    LWST = [61,62,63];    LHND = [64,65,66];    LELB = [67,68,69];
LAFR = [70,71,72];    LAFU = [73,74,75];    LABL = [76,77,78];    LABM = [79,80,81];
RTPR = [82,83,84];    RTDI = [85,86,87];    RTEF = [88,89,90];
RIPR = [91,92,93];    RIME = [94,95,96];    RIDI = [97,98,99];    RIEF = [100,101,102];
RMPR = [103,104,105]; RMME = [106,107,108]; RMDI = [109,110,111]; RMEF = [112,113,114];
RRPR = [115,116,117]; RRME = [118,119,120]; RRDI = [121,122,123]; RREF = [124,125,126];
RPPR = [127,128,129]; RPME = [130,131,132]; RPDI = [133,134,135]; RPEF = [136,137,138];
RPAL = [139,140,141]; RWST = [142,143,144]; RHND = [145,146,147]; RELB = [148,149,150];
RAFR = [151,152,153]; RAFU = [154,155,156]; RABL = [157,158,159]; RABM = [160,161,162];

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' seq(:,61)' seq(:,64)' seq(:,67)' seq(:,70)' seq(:,73)' seq(:,76)' seq(:,79)' seq(:,82)' seq(:,85)' seq(:,88)' seq(:,91)' seq(:,94)' seq(:,97)' seq(:,100)' seq(:,103)' seq(:,106)' seq(:,109)' seq(:,112)' seq(:,115)' seq(:,118)' seq(:,121)' seq(:,124)' seq(:,127)' seq(:,130)' seq(:,133)' seq(:,136)' seq(:,139)' seq(:,142)' seq(:,145)' seq(:,148)' seq(:,151)' seq(:,154)' seq(:,157)' seq(:,160)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' seq(:,62)' seq(:,65)' seq(:,68)' seq(:,71)' seq(:,74)' seq(:,77)' seq(:,80)' seq(:,83)' seq(:,86)' seq(:,89)' seq(:,92)' seq(:,95)' seq(:,98)' seq(:,101)' seq(:,104)' seq(:,107)' seq(:,110)' seq(:,113)' seq(:,116)' seq(:,119)' seq(:,122)' seq(:,125)' seq(:,128)' seq(:,131)' seq(:,134)' seq(:,137)' seq(:,140)' seq(:,143)' seq(:,146)' seq(:,149)' seq(:,152)' seq(:,155)' seq(:,158)' seq(:,161)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' seq(:,63)' seq(:,66)' seq(:,69)' seq(:,72)' seq(:,75)' seq(:,78)' seq(:,81)' seq(:,84)' seq(:,87)' seq(:,90)' seq(:,93)' seq(:,96)' seq(:,99)' seq(:,102)' seq(:,105)' seq(:,108)' seq(:,111)' seq(:,114)' seq(:,117)' seq(:,120)' seq(:,123)' seq(:,126)' seq(:,129)' seq(:,132)' seq(:,135)' seq(:,138)' seq(:,141)' seq(:,144)' seq(:,147)' seq(:,150)' seq(:,153)' seq(:,156)' seq(:,159)' seq(:,162)' ];
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
    for j = 1:54
        plot3(seq(i,j*3-2),seq(i,j*3-1),seq(i,j*3-0),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k');
        hold on;  
    end
    
    plot3(seq(i,RTEF(1)),seq(i,RTEF(2)),seq(i,RTEF(3)),'o','MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');
    plot3(seq(i,RIEF(1)),seq(i,RIEF(2)),seq(i,RIEF(3)),'o','MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');
    plot3(seq(i,RMEF(1)),seq(i,RMEF(2)),seq(i,RMEF(3)),'o','MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');
    plot3(seq(i,RREF(1)),seq(i,RREF(2)),seq(i,RREF(3)),'o','MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');
    plot3(seq(i,RPEF(1)),seq(i,RPEF(2)),seq(i,RPEF(3)),'o','MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');
    plot3(seq(i,RWST(1)),seq(i,RWST(2)),seq(i,RWST(3)),'o','MarkerSize',8,'MarkerFaceColor','k','MarkerEdgeColor','k');

    ConnectJoint(seq,i,LTPR,LTDI); ConnectJoint(seq,i,LTDI,LTEF);
    ConnectJoint(seq,i,LIPR,LIME); ConnectJoint(seq,i,LIME,LIDI); ConnectJoint(seq,i,LIDI,LIEF);
    ConnectJoint(seq,i,LMPR,LMME); ConnectJoint(seq,i,LMME,LMDI); ConnectJoint(seq,i,LMDI,LMEF);
    ConnectJoint(seq,i,LRPR,LRME); ConnectJoint(seq,i,LRME,LRDI); ConnectJoint(seq,i,LRDI,LREF);
    ConnectJoint(seq,i,LPPR,LPME); ConnectJoint(seq,i,LPME,LPDI); ConnectJoint(seq,i,LPDI,LPEF);
    ConnectJoint(seq,i,LIPR,LPAL); ConnectJoint(seq,i,LMPR,LPAL); ConnectJoint(seq,i,LRPR,LPAL); ConnectJoint(seq,i,LPPR,LPAL);
    ConnectJoint(seq,i,LPAL,LWST); ConnectJoint(seq,i,LHND,LWST); ConnectJoint(seq,i,LHND,LTPR);
    ConnectJoint(seq,i,LELB,LWST); ConnectJoint(seq,i,LAFR,LWST); ConnectJoint(seq,i,LAFU,LWST);
    ConnectJoint(seq,i,LABL,LAFR); ConnectJoint(seq,i,LABM,LAFU);
    
    ConnectJoint(seq,i,RTPR,RTDI); ConnectJoint(seq,i,RTDI,RTEF);
    ConnectJoint(seq,i,RIPR,RIME); ConnectJoint(seq,i,RIME,RIDI); ConnectJoint(seq,i,RIDI,RIEF);
    ConnectJoint(seq,i,RMPR,RMME); ConnectJoint(seq,i,RMME,RMDI); ConnectJoint(seq,i,RMDI,RMEF);
    ConnectJoint(seq,i,RRPR,RRME); ConnectJoint(seq,i,RRME,RRDI); ConnectJoint(seq,i,RRDI,RREF);
    ConnectJoint(seq,i,RPPR,RPME); ConnectJoint(seq,i,RPME,RPDI); ConnectJoint(seq,i,RPDI,RPEF);
    ConnectJoint(seq,i,RIPR,RPAL); ConnectJoint(seq,i,RMPR,RPAL); ConnectJoint(seq,i,RRPR,RPAL); ConnectJoint(seq,i,RPPR,RPAL);
    ConnectJoint(seq,i,RPAL,RWST); ConnectJoint(seq,i,RHND,RWST); ConnectJoint(seq,i,RHND,RTPR);
    ConnectJoint(seq,i,RELB,RWST); ConnectJoint(seq,i,RAFR,RWST); ConnectJoint(seq,i,RAFU,RWST);
    ConnectJoint(seq,i,RABL,RAFR); ConnectJoint(seq,i,RABM,RAFU);
      
    hold off;
    
    % set the graph x/y/z coordinate min/max values
    xlim([minxval maxxval]);
    ylim([minyval maxyval]);
    zlim([minzval maxzval]);
    
    daspect([1 1 1]); % axis length ratio - equal data units in all directions
    
%     view(160,-70); % set the azimuth and elevation for viewing the 3D data
    view(-200,-50);

    drawnow;
%     pause(0.1);
%     w = waitforbuttonpress;
end