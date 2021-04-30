
HEAD = [1,2,3];         NECK = [4,5,6];         RSHO = [7,8,9];        RELB = [10,11,12];
RWST = [13,14,15];      LSHO = [16,17,18];      LELB = [19,20,21];     LWST = [22,23,24];
RHIP = [25,26,27];      RKNE = [28,29,30];      RFOT = [31,32,33];     LHIP = [34,35,36];
LKNE = [37,38,39];      LFOT = [40,41,42];      REYE = [43,44,45];     LEYE = [46,47,48];
REAR = [49,50,51];      LEAR = [52,53,54];

NECK_HEAD = [];
HEAD_REYE = [];
REYE_REAR = [];
HEAD_LEYE = [];
LEYE_LEAR = [];
NECK_RSHO = [];
RSHO_RELB = [];
RELB_RWST = [];
NECK_LSHO = [];
LSHO_LELB = [];
LELB_LWST = [];
        
for i=1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4)); 
    for j=1:size(seq,1) % for each seq frame
        if seq(j,NECK(1)) ~= 0 && seq(j,HEAD(1)) ~= 0
            NECK_HEAD(end+1,1) = CalcPointDist(seq(j,NECK),seq(j,HEAD));
        end
        if seq(j,HEAD(1)) ~= 0 && seq(j,REYE(1)) ~= 0
            HEAD_REYE(end+1,1) = CalcPointDist(seq(j,HEAD),seq(j,REYE));
        end
        if seq(j,REYE(1)) ~= 0 && seq(j,REAR(1)) ~= 0
            REYE_REAR(end+1,1) = CalcPointDist(seq(j,REYE),seq(j,REAR));
        end
        if seq(j,HEAD(1)) ~= 0 && seq(j,LEYE(1)) ~= 0
            HEAD_LEYE(end+1,1) = CalcPointDist(seq(j,HEAD),seq(j,LEYE));
        end
        if seq(j,LEYE(1)) ~= 0 && seq(j,LEAR(1)) ~= 0
            LEYE_LEAR(end+1,1) = CalcPointDist(seq(j,LEYE),seq(j,LEAR));
        end
        if seq(j,NECK(1)) ~= 0 && seq(j,RSHO(1)) ~= 0
            NECK_RSHO(end+1,1) = CalcPointDist(seq(j,NECK),seq(j,RSHO));
        end
        if seq(j,RSHO(1)) ~= 0 && seq(j,RELB(1)) ~= 0
            RSHO_RELB(end+1,1) = CalcPointDist(seq(j,RSHO),seq(j,RELB));
        end
        if seq(j,RELB(1)) ~= 0 && seq(j,RWST(1)) ~= 0
            RELB_RWST(end+1,1) = CalcPointDist(seq(j,RELB),seq(j,RWST));
        end
        if seq(j,NECK(1)) ~= 0 && seq(j,LSHO(1)) ~= 0
            NECK_LSHO(end+1,1) = CalcPointDist(seq(j,NECK),seq(j,LSHO));
        end
        if seq(j,LSHO(1)) ~= 0 && seq(j,LELB(1)) ~= 0
            LSHO_LELB(end+1,1) = CalcPointDist(seq(j,LSHO),seq(j,LELB));
        end
        if seq(j,LELB(1)) ~= 0 && seq(j,LWST(1)) ~= 0
            LELB_LWST(end+1,1) = CalcPointDist(seq(j,LELB),seq(j,LWST));
        end


    end
end

disp(['NECK_HEAD median: ',num2str(round(median(NECK_HEAD(:,1)),3))]);
disp(['HEAD_REYE median: ',num2str(round(median(HEAD_REYE(:,1)),3))]);
disp(['REYE_REAR median: ',num2str(round(median(REYE_REAR(:,1)),3))]);
disp(['HEAD_LEYE median: ',num2str(round(median(HEAD_LEYE(:,1)),3))]);
disp(['LEYE_LEAR median: ',num2str(round(median(LEYE_LEAR(:,1)),3))]);
disp(['NECK_RSHO median: ',num2str(round(median(NECK_RSHO(:,1)),3))]);
disp(['RSHO_RELB median: ',num2str(round(median(RSHO_RELB(:,1)),3))]);
disp(['RELB_RWST median: ',num2str(round(median(RELB_RWST(:,1)),3))]);
disp(['NECK_LSHO median: ',num2str(round(median(NECK_LSHO(:,1)),3))]);
disp(['LSHO_LELB median: ',num2str(round(median(LSHO_LELB(:,1)),3))]);
disp(['LELB_LWST median: ',num2str(round(median(LELB_LWST(:,1)),3))]);
