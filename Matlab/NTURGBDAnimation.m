% get NTURGBD sign language sequence
seqID = 559;   
seq = cell2mat(CompMoveData(seqID,4));  

if size(seq,2) == 75
    seq(1:numSeqRows,76:150) = 0;
end

HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];

HIP2 = HIP+75; SPIN2 = SPIN+75; NECK2 = NECK+75; HEAD2 = HEAD+75;
LSHO2 = LSHO+75; LELB2 = LELB+75; LWST2 = LWST+75; LHND2 = LHND+75;
RSHO2 = RSHO+75; RELB2 = RELB+75; RWST2 = RWST+75; RHND2 = RHND+75;
LHIP2 = LHIP+75; LKNE2 = LKNE+75; LANK2 = LANK+75; LFOT2 = LFOT+75;
RHIP2 = RHIP+75; RKNE2 = RKNE+75; RANK2 = RANK+75; RFOT2 = RFOT+75;
SHO2 = SHO+75; LTIP2 = LTIP+75; LTHM2 = LTHM+75; RTIP2 = RTIP+75; RTHM2 = RTHM+75;

% set plot coordinate min/max values
xval = [seq(:,1)' seq(:,4)' seq(:,7)' seq(:,10)' seq(:,13)' seq(:,16)' seq(:,19)' seq(:,22)' seq(:,25)' seq(:,28)' seq(:,31)' seq(:,34)' seq(:,37)' seq(:,40)' seq(:,43)' seq(:,46)' seq(:,49)' seq(:,52)' seq(:,55)' seq(:,58)' seq(:,61)' seq(:,64)' seq(:,67)' seq(:,70)' seq(:,73)' seq(:,76)' seq(:,79)' seq(:,82)' seq(:,85)' seq(:,88)' seq(:,91)' seq(:,94)' seq(:,97)' seq(:,100)' seq(:,103)' seq(:,106)' seq(:,109)' seq(:,112)' seq(:,115)' seq(:,118)' seq(:,121)' seq(:,124)' seq(:,127)' seq(:,130)' seq(:,133)' seq(:,136)' seq(:,139)' seq(:,142)' seq(:,145)' seq(:,148)'];
yval = [seq(:,2)' seq(:,5)' seq(:,8)' seq(:,11)' seq(:,14)' seq(:,17)' seq(:,20)' seq(:,23)' seq(:,26)' seq(:,29)' seq(:,32)' seq(:,35)' seq(:,37)' seq(:,41)' seq(:,44)' seq(:,47)' seq(:,50)' seq(:,53)' seq(:,56)' seq(:,59)' seq(:,62)' seq(:,65)' seq(:,68)' seq(:,71)' seq(:,74)' seq(:,77)' seq(:,80)' seq(:,83)' seq(:,86)' seq(:,89)' seq(:,92)' seq(:,95)' seq(:,98)' seq(:,101)' seq(:,104)' seq(:,107)' seq(:,110)' seq(:,113)' seq(:,116)' seq(:,119)' seq(:,122)' seq(:,125)' seq(:,128)' seq(:,131)' seq(:,134)' seq(:,137)' seq(:,140)' seq(:,143)' seq(:,146)' seq(:,149)'];
zval = [seq(:,3)' seq(:,6)' seq(:,9)' seq(:,12)' seq(:,15)' seq(:,18)' seq(:,21)' seq(:,24)' seq(:,27)' seq(:,30)' seq(:,33)' seq(:,36)' seq(:,39)' seq(:,42)' seq(:,45)' seq(:,48)' seq(:,51)' seq(:,54)' seq(:,57)' seq(:,60)' seq(:,63)' seq(:,66)' seq(:,69)' seq(:,72)' seq(:,75)' seq(:,78)' seq(:,81)' seq(:,84)' seq(:,87)' seq(:,90)' seq(:,93)' seq(:,96)' seq(:,99)' seq(:,102)' seq(:,105)' seq(:,108)' seq(:,111)' seq(:,114)' seq(:,117)' seq(:,120)' seq(:,123)' seq(:,126)' seq(:,129)' seq(:,132)' seq(:,135)' seq(:,138)' seq(:,141)' seq(:,144)' seq(:,147)' seq(:,150)'];
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

    plot3(seq(i,HIP(1)),seq(i,HIP(2)),seq(i,HIP(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,SPIN(1)),seq(i,SPIN(2)),seq(i,SPIN(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,NECK(1)),seq(i,NECK(2)),seq(i,NECK(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,HEAD(1)),seq(i,HEAD(2)),seq(i,HEAD(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LSHO(1)),seq(i,LSHO(2)),seq(i,LSHO(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LELB(1)),seq(i,LELB(2)),seq(i,LELB(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LWST(1)),seq(i,LWST(2)),seq(i,LWST(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LHND(1)),seq(i,LHND(2)),seq(i,LHND(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RSHO(1)),seq(i,RSHO(2)),seq(i,RSHO(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RELB(1)),seq(i,RELB(2)),seq(i,RELB(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RWST(1)),seq(i,RWST(2)),seq(i,RWST(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RHND(1)),seq(i,RHND(2)),seq(i,RHND(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LHIP(1)),seq(i,LHIP(2)),seq(i,LHIP(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LKNE(1)),seq(i,LKNE(2)),seq(i,LKNE(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LANK(1)),seq(i,LANK(2)),seq(i,LANK(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LFOT(1)),seq(i,LFOT(2)),seq(i,LFOT(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RHIP(1)),seq(i,RHIP(2)),seq(i,RHIP(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RKNE(1)),seq(i,RKNE(2)),seq(i,RKNE(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RANK(1)),seq(i,RANK(2)),seq(i,RANK(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RFOT(1)),seq(i,RFOT(2)),seq(i,RFOT(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,SHO(1)),seq(i,SHO(2)),seq(i,SHO(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LTIP(1)),seq(i,LTIP(2)),seq(i,LTIP(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,LTHM(1)),seq(i,LTHM(2)),seq(i,LTHM(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RTIP(1)),seq(i,RTIP(2)),seq(i,RTIP(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,RTHM(1)),seq(i,RTHM(2)),seq(i,RTHM(3)),'o','MarkerSize',3,'MarkerFaceColor','k','MarkerEdgeColor','k'); hold on;

    p1 = HEAD; p2 = NECK; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = NECK; p2 = SHO; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SHO; p2 = RSHO; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RSHO; p2 = RELB; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RELB; p2 = RWST; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RWST; p2 = RHND; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RHND; p2 = RTHM; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RHND; p2 = RTIP; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SHO; p2 = LSHO; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LSHO; p2 = LELB; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LELB; p2 = LWST; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LWST; p2 = LHND; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LHND; p2 = LTHM; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LHND; p2 = LTIP; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SHO; p2 = SPIN; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SPIN; p2 = HIP; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = HIP; p2 = RHIP; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RHIP; p2 = RKNE; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RKNE; p2 = RANK; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RANK; p2 = RFOT; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = HIP; p2 = LHIP; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LHIP; p2 = LKNE; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LKNE; p2 = LANK; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LANK; p2 = LFOT; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;

    plot3(seq(i,HIP2(1)),seq(i,HIP2(2)),seq(i,HIP2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,SPIN2(1)),seq(i,SPIN2(2)),seq(i,SPIN2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','k'); hold on;
    plot3(seq(i,NECK2(1)),seq(i,NECK2(2)),seq(i,NECK2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,HEAD2(1)),seq(i,HEAD2(2)),seq(i,HEAD2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LSHO2(1)),seq(i,LSHO2(2)),seq(i,LSHO2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LELB2(1)),seq(i,LELB2(2)),seq(i,LELB2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LWST2(1)),seq(i,LWST2(2)),seq(i,LWST2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LHND2(1)),seq(i,LHND2(2)),seq(i,LHND2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RSHO2(1)),seq(i,RSHO2(2)),seq(i,RSHO2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RELB2(1)),seq(i,RELB2(2)),seq(i,RELB2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RWST2(1)),seq(i,RWST2(2)),seq(i,RWST2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RHND2(1)),seq(i,RHND2(2)),seq(i,RHND2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LHIP2(1)),seq(i,LHIP2(2)),seq(i,LHIP2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LKNE2(1)),seq(i,LKNE2(2)),seq(i,LKNE2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LANK2(1)),seq(i,LANK2(2)),seq(i,LANK2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LFOT2(1)),seq(i,LFOT2(2)),seq(i,LFOT2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RHIP2(1)),seq(i,RHIP2(2)),seq(i,RHIP2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RKNE2(1)),seq(i,RKNE2(2)),seq(i,RKNE2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RANK2(1)),seq(i,RANK2(2)),seq(i,RANK2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RFOT2(1)),seq(i,RFOT2(2)),seq(i,RFOT2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,SHO2(1)),seq(i,SHO2(2)),seq(i,SHO2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LTIP2(1)),seq(i,LTIP2(2)),seq(i,LTIP2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,LTHM2(1)),seq(i,LTHM2(2)),seq(i,LTHM2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RTIP2(1)),seq(i,RTIP2(2)),seq(i,RTIP2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;
    plot3(seq(i,RTHM2(1)),seq(i,RTHM2(2)),seq(i,RTHM2(3)),'o','MarkerSize',3,'MarkerFaceColor','b','MarkerEdgeColor','b'); hold on;

    p1 = HEAD2; p2 = NECK2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = NECK2; p2 = SHO2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SHO2; p2 = RSHO2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RSHO2; p2 = RELB2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RELB2; p2 = RWST2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RWST2; p2 = RHND2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RHND2; p2 = RTHM2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RHND2; p2 = RTIP2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SHO2; p2 = LSHO2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LSHO2; p2 = LELB2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LELB2; p2 = LWST2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LWST2; p2 = LHND2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LHND2; p2 = LTHM2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LHND2; p2 = LTIP2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SHO2; p2 = SPIN2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = SPIN2; p2 = HIP2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = HIP2; p2 = RHIP2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RHIP2; p2 = RKNE2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RKNE2; p2 = RANK2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = RANK2; p2 = RFOT2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = HIP2; p2 = LHIP2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LHIP2; p2 = LKNE2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LKNE2; p2 = LANK2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;
    p1 = LANK2; p2 = LFOT2; xplot=[seq(i,p1(1)) seq(i,p2(1))]; yplot=[seq(i,p1(2)) seq(i,p2(2))]; zplot=[seq(i,p1(3)) seq(i,p2(3))]; plot3(xplot,yplot,zplot,'-k','linewidth',2,'Markerfacecolor','k'); hold on;

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