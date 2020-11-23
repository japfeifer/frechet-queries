% get NTU sign language sequence
lW = 2;
vW = 4;

seqID = 3002;
seq = cell2mat(CompMoveData(seqID,4));   

seq = seq([7 17 22 ],:); 

HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' seq(:,61)' seq(:,64)'  seq(:,70)' seq(:,73)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' seq(:,62)' seq(:,65)'  seq(:,71)' seq(:,74)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' seq(:,63)' seq(:,66)'  seq(:,72)' seq(:,75)' ];
minxval = min(xval) - 0.1;
maxxval = max(xval) + 0.1;
minyval = min(yval) - 0.1;
maxyval = max(yval) + 0.1;
minzval = min(zval) - 0.1;
maxzval = max(zval) + 0.1;

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

    for j = 1:25
        plot3(seq(i,j*3-2),seq(i,j*3-1),seq(i,j*3-0),'o','MarkerSize',vW,'MarkerFaceColor',currColor,'MarkerEdgeColor',currColor);
        hold on;  
    end
    
    ConnectJoint(seq,i,LTIP,LHND,currColor,lW); ConnectJoint(seq,i,LTHM,LHND,currColor,lW);
    ConnectJoint(seq,i,LHND,LWST,currColor,lW); ConnectJoint(seq,i,LWST,LELB,currColor,lW);
    ConnectJoint(seq,i,LELB,LSHO,currColor,lW); ConnectJoint(seq,i,LSHO,SHO,currColor,lW);
    ConnectJoint(seq,i,RTIP,RHND,currColor,lW); ConnectJoint(seq,i,RTHM,RHND,currColor,lW);
    ConnectJoint(seq,i,RHND,RWST,currColor,lW); ConnectJoint(seq,i,RWST,RELB,currColor,lW);
    ConnectJoint(seq,i,RELB,RSHO,currColor,lW); ConnectJoint(seq,i,RSHO,SHO,currColor,lW);
    ConnectJoint(seq,i,LFOT,LANK,currColor,lW); ConnectJoint(seq,i,LANK,LKNE,currColor,lW);
    ConnectJoint(seq,i,LKNE,LHIP,currColor,lW); ConnectJoint(seq,i,LHIP,HIP,currColor,lW);
    ConnectJoint(seq,i,RFOT,RANK,currColor,lW); ConnectJoint(seq,i,RANK,RKNE,currColor,lW);
    ConnectJoint(seq,i,RKNE,RHIP,currColor,lW); ConnectJoint(seq,i,RHIP,HIP,currColor,lW);
    ConnectJoint(seq,i,HIP,SPIN,currColor,lW); ConnectJoint(seq,i,SPIN,SHO,currColor,lW);
    ConnectJoint(seq,i,SHO,NECK,currColor,lW); ConnectJoint(seq,i,NECK,HEAD,currColor,lW);

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