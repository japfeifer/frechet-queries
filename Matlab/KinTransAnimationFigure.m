% get KinTrans sign language sequence
lW = 2;
vW = 4;

seqID = 1208;
seq = cell2mat(CompMoveData(seqID,4));   

% seq = KinTransNormalizeSeq(seq,[1 1 1 1 1]);

seq = seq([1 3  7 11 15],:); 
% seq = seq([1 3 4 5 6  ],:); 

TORS = [4,5,6]; NECK = [1,2,3]; 
LSHO = [19,20,21]; LELB = [22,23,24]; LWST = [25,26,27]; LHND = [28,29,30]; 
RSHO = [7,8,9]; RELB = [10,11,12]; RWST = [13,14,15]; RHND = [16,17,18];

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' ];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' ];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' ];
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

    for j = 1:10
        plot3(seq(i,j*3-2),seq(i,j*3-1),seq(i,j*3-0),'o','MarkerSize',vW,'MarkerFaceColor',currColor,'MarkerEdgeColor',currColor);
        hold on;  
    end
    
    ConnectJoint(seq,i,LWST,LHND,currColor,lW); ConnectJoint(seq,i,LELB,LWST,currColor,lW);
    ConnectJoint(seq,i,LSHO,LELB,currColor,lW); ConnectJoint(seq,i,NECK,LSHO,currColor,lW);
    ConnectJoint(seq,i,RWST,RHND,currColor,lW); ConnectJoint(seq,i,RELB,RWST,currColor,lW);
    ConnectJoint(seq,i,RSHO,RELB,currColor,lW); ConnectJoint(seq,i,NECK,RSHO,currColor,lW);
    ConnectJoint(seq,i,NECK,TORS,currColor,lW);

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