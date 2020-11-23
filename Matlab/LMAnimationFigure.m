% get ASLLM American Sign Language Leap Motion sequence 
% seqID = 1500;
% seqID = 2000; 

lW = 2;
vW = 4;

% seqID = 3500; 
% seq = cell2mat(CompMoveData(seqID,4)); 
% seq = seq([ 4 8 9 10],:); 

seqID = 6000; 
seq = cell2mat(CompMoveData(seqID,4)); 
seq = seq([ 10 12  15],:);

% seq = LMNormalizeSeq(seq,[0 0 0 0 0 1]);

LTPR = [1,2,3];       LTDI = [4,5,6];       LTEF = [7,8,9];
LIPR = [10,11,12];    LIME = [13,14,15];    LIDI = [16,17,18];    LIEF = [19,20,21];
LMPR = [22,23,24];    LMME = [25,26,27];    LMDI = [28,29,30];    LMEF = [31,32,33];
LRPR = [34,35,36];    LRME = [37,38,39];    LRDI = [40,41,42];    LREF = [43,44,45];
LPPR = [46,47,48];    LPME = [49,50,51];    LPDI = [52,53,54];    LPEF = [55,56,57];
LPAL = [58,59,60];    LWST = [61,62,63];    LHND = [64,65,66];    % LELB = [67,68,69];
LAFR = [70,71,72];    LAFU = [73,74,75];    % LABL = [76,77,78];    LABM = [79,80,81];
RTPR = [82,83,84];    RTDI = [85,86,87];    RTEF = [88,89,90];
RIPR = [91,92,93];    RIME = [94,95,96];    RIDI = [97,98,99];    RIEF = [100,101,102];
RMPR = [103,104,105]; RMME = [106,107,108]; RMDI = [109,110,111]; RMEF = [112,113,114];
RRPR = [115,116,117]; RRME = [118,119,120]; RRDI = [121,122,123]; RREF = [124,125,126];
RPPR = [127,128,129]; RPME = [130,131,132]; RPDI = [133,134,135]; RPEF = [136,137,138];
RPAL = [139,140,141]; RWST = [142,143,144]; RHND = [145,146,147]; % RELB = [148,149,150];
RAFR = [151,152,153]; RAFU = [154,155,156]; % RABL = [157,158,159]; RABM = [160,161,162];

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' seq(:,61)' seq(:,64)'  seq(:,70)' seq(:,73)'   seq(:,82)' seq(:,85)' seq(:,88)' seq(:,91)' seq(:,94)' seq(:,97)' seq(:,100)' seq(:,103)' seq(:,106)' seq(:,109)' seq(:,112)' seq(:,115)' seq(:,118)' seq(:,121)' seq(:,124)' seq(:,127)' seq(:,130)' seq(:,133)' seq(:,136)' seq(:,139)' seq(:,142)' seq(:,145)'  seq(:,151)' seq(:,154)'  ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' seq(:,62)' seq(:,65)'  seq(:,71)' seq(:,74)'   seq(:,83)' seq(:,86)' seq(:,89)' seq(:,92)' seq(:,95)' seq(:,98)' seq(:,101)' seq(:,104)' seq(:,107)' seq(:,110)' seq(:,113)' seq(:,116)' seq(:,119)' seq(:,122)' seq(:,125)' seq(:,128)' seq(:,131)' seq(:,134)' seq(:,137)' seq(:,140)' seq(:,143)' seq(:,146)'  seq(:,152)' seq(:,155)'  ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' seq(:,63)' seq(:,66)'  seq(:,72)' seq(:,75)'   seq(:,84)' seq(:,87)' seq(:,90)' seq(:,93)' seq(:,96)' seq(:,99)' seq(:,102)' seq(:,105)' seq(:,108)' seq(:,111)' seq(:,114)' seq(:,117)' seq(:,120)' seq(:,123)' seq(:,126)' seq(:,129)' seq(:,132)' seq(:,135)' seq(:,138)' seq(:,141)' seq(:,144)' seq(:,147)'  seq(:,153)' seq(:,156)'  ];
% xval = [   seq(:,82)' seq(:,85)' seq(:,88)' seq(:,91)' seq(:,94)' seq(:,97)' seq(:,100)' seq(:,103)' seq(:,106)' seq(:,109)' seq(:,112)' seq(:,115)' seq(:,118)' seq(:,121)' seq(:,124)' seq(:,127)' seq(:,130)' seq(:,133)' seq(:,136)' seq(:,139)' seq(:,142)' seq(:,145)'  seq(:,151)' seq(:,154)'  ];
% yval = [   seq(:,83)' seq(:,86)' seq(:,89)' seq(:,92)' seq(:,95)' seq(:,98)' seq(:,101)' seq(:,104)' seq(:,107)' seq(:,110)' seq(:,113)' seq(:,116)' seq(:,119)' seq(:,122)' seq(:,125)' seq(:,128)' seq(:,131)' seq(:,134)' seq(:,137)' seq(:,140)' seq(:,143)' seq(:,146)'  seq(:,152)' seq(:,155)'  ];
% zval = [   seq(:,84)' seq(:,87)' seq(:,90)' seq(:,93)' seq(:,96)' seq(:,99)' seq(:,102)' seq(:,105)' seq(:,108)' seq(:,111)' seq(:,114)' seq(:,117)' seq(:,120)' seq(:,123)' seq(:,126)' seq(:,129)' seq(:,132)' seq(:,135)' seq(:,138)' seq(:,141)' seq(:,144)' seq(:,147)'  seq(:,153)' seq(:,156)'  ];
minxval = min(xval) - 0.04;
maxxval = max(xval) + 0.04;
minyval = min(yval) - 0.04;
maxyval = max(yval) + 0.04;
minzval = min(zval) - 0.04;
maxzval = max(zval) + 0.04;

f1 = figure;
set(gcf, 'Position',  [100, 100, 600, 600]); % set figure window position and size

% Animation Loop
szSeq = size(seq,1);
for i = 1:szSeq
    if i == szSeq
        currColor = [0 0 0];
    else
        tmpCol = 0.95 - ((i/szSeq) * 0.7);
        currColor = [tmpCol tmpCol tmpCol];
    end
    
    for j = 1:54
        plot3(seq(i,j*3-2),seq(i,j*3-1),seq(i,j*3-0),'o','MarkerSize',vW,'MarkerFaceColor',currColor,'MarkerEdgeColor',currColor);
        hold on;  
    end
    
%     for j = 28:54
%         plot3(seq(i,j*3-2),seq(i,j*3-1),seq(i,j*3-0),'o','MarkerSize',vW,'MarkerFaceColor',currColor,'MarkerEdgeColor',currColor);
%         hold on;  
%     end
    
    ConnectJoint(seq,i,LTPR,LTDI,currColor,lW); ConnectJoint(seq,i,LTDI,LTEF,currColor,lW);
    ConnectJoint(seq,i,LIPR,LIME,currColor,lW); ConnectJoint(seq,i,LIME,LIDI,currColor,lW); ConnectJoint(seq,i,LIDI,LIEF,currColor,lW);
    ConnectJoint(seq,i,LMPR,LMME,currColor,lW); ConnectJoint(seq,i,LMME,LMDI,currColor,lW); ConnectJoint(seq,i,LMDI,LMEF,currColor,lW);
    ConnectJoint(seq,i,LRPR,LRME,currColor,lW); ConnectJoint(seq,i,LRME,LRDI,currColor,lW); ConnectJoint(seq,i,LRDI,LREF,currColor,lW);
    ConnectJoint(seq,i,LPPR,LPME,currColor,lW); ConnectJoint(seq,i,LPME,LPDI,currColor,lW); ConnectJoint(seq,i,LPDI,LPEF,currColor,lW);
    ConnectJoint(seq,i,LIPR,LPAL,currColor,lW); ConnectJoint(seq,i,LMPR,LPAL,currColor,lW); ConnectJoint(seq,i,LRPR,LPAL,currColor,lW); ConnectJoint(seq,i,LPPR,LPAL,currColor,lW);
    ConnectJoint(seq,i,LPAL,LWST,currColor,lW); ConnectJoint(seq,i,LHND,LWST,currColor,lW); ConnectJoint(seq,i,LHND,LTPR,currColor,lW);
%     ConnectJoint(seq,i,LELB,LWST,currColor,lW); 
    ConnectJoint(seq,i,LAFR,LWST,currColor,lW); ConnectJoint(seq,i,LAFU,LWST,currColor,lW);
%     ConnectJoint(seq,i,LABL,LAFR,currColor,lW); ConnectJoint(seq,i,LABM,LAFU,currColor,lW);
    
    ConnectJoint(seq,i,RTPR,RTDI,currColor,lW); ConnectJoint(seq,i,RTDI,RTEF,currColor,lW);
    ConnectJoint(seq,i,RIPR,RIME,currColor,lW); ConnectJoint(seq,i,RIME,RIDI,currColor,lW); ConnectJoint(seq,i,RIDI,RIEF,currColor,lW);
    ConnectJoint(seq,i,RMPR,RMME,currColor,lW); ConnectJoint(seq,i,RMME,RMDI,currColor,lW); ConnectJoint(seq,i,RMDI,RMEF,currColor,lW);
    ConnectJoint(seq,i,RRPR,RRME,currColor,lW); ConnectJoint(seq,i,RRME,RRDI,currColor,lW); ConnectJoint(seq,i,RRDI,RREF,currColor,lW);
    ConnectJoint(seq,i,RPPR,RPME,currColor,lW); ConnectJoint(seq,i,RPME,RPDI,currColor,lW); ConnectJoint(seq,i,RPDI,RPEF,currColor,lW);
    ConnectJoint(seq,i,RIPR,RPAL,currColor,lW); ConnectJoint(seq,i,RMPR,RPAL,currColor,lW); ConnectJoint(seq,i,RRPR,RPAL,currColor,lW); ConnectJoint(seq,i,RPPR,RPAL,currColor,lW);
    ConnectJoint(seq,i,RPAL,RWST,currColor,lW); ConnectJoint(seq,i,RHND,RWST,currColor,lW); ConnectJoint(seq,i,RHND,RTPR,currColor,lW);
%     ConnectJoint(seq,i,RELB,RWST,currColor,lW); 
    ConnectJoint(seq,i,RAFR,RWST,currColor,lW); ConnectJoint(seq,i,RAFU,RWST,currColor,lW);
%     ConnectJoint(seq,i,RABL,RAFR,currColor,lW); ConnectJoint(seq,i,RABM,RAFU,currColor,lW);

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