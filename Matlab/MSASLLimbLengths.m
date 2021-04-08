
HEAD  = [1,2,3]; SHO = [4,5,6]; RSHO = [7,8,9]; RELB = [10,11,12];
RHND = [13,14,15]; LSHO = [16,17,18]; LELB = [19,20,21]; LHND = [22,23,24];
RHIP = [25,26,27]; RKNE = [28,29,30]; RFOT = [31,32,33]; LHIP = [34,35,36];
LKNE = [37,38,39]; LFOT = [40,41,42]; RHED = [43,44,45]; LHED = [46,47,48];
REAR = [49,50,51]; LEAR = [52,53,54]; 

SHO_HEAD = [];
HEAD_RHED = [];
RHED_REAR = [];
HEAD_LHED = [];
LHED_LEAR = [];
SHO_RSHO = [];
RSHO_RELB = [];
RELB_RHND = [];
SHO_LSHO = [];
LSHO_LELB = [];
LELB_LHND = [];
        
for i=1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4)); 
    for j=1:size(seq,1) % for each seq frame
        if seq(j,SHO(1)) ~= 0 && seq(j,HEAD(1)) ~= 0
            SHO_HEAD(end+1,1) = CalcPointDist(seq(j,SHO),seq(j,HEAD));
        end
        if seq(j,HEAD(1)) ~= 0 && seq(j,RHED(1)) ~= 0
            HEAD_RHED(end+1,1) = CalcPointDist(seq(j,HEAD),seq(j,RHED));
        end
        if seq(j,RHED(1)) ~= 0 && seq(j,REAR(1)) ~= 0
            RHED_REAR(end+1,1) = CalcPointDist(seq(j,RHED),seq(j,REAR));
        end
        if seq(j,HEAD(1)) ~= 0 && seq(j,LHED(1)) ~= 0
            HEAD_LHED(end+1,1) = CalcPointDist(seq(j,HEAD),seq(j,LHED));
        end
        if seq(j,LHED(1)) ~= 0 && seq(j,LEAR(1)) ~= 0
            LHED_LEAR(end+1,1) = CalcPointDist(seq(j,LHED),seq(j,LEAR));
        end
        if seq(j,SHO(1)) ~= 0 && seq(j,RSHO(1)) ~= 0
            SHO_RSHO(end+1,1) = CalcPointDist(seq(j,SHO),seq(j,RSHO));
        end
        if seq(j,RSHO(1)) ~= 0 && seq(j,RELB(1)) ~= 0
            RSHO_RELB(end+1,1) = CalcPointDist(seq(j,RSHO),seq(j,RELB));
        end
        if seq(j,RELB(1)) ~= 0 && seq(j,RHND(1)) ~= 0
            RELB_RHND(end+1,1) = CalcPointDist(seq(j,RELB),seq(j,RHND));
        end
        if seq(j,SHO(1)) ~= 0 && seq(j,LSHO(1)) ~= 0
            SHO_LSHO(end+1,1) = CalcPointDist(seq(j,SHO),seq(j,LSHO));
        end
        if seq(j,LSHO(1)) ~= 0 && seq(j,LELB(1)) ~= 0
            LSHO_LELB(end+1,1) = CalcPointDist(seq(j,LSHO),seq(j,LELB));
        end
        if seq(j,LELB(1)) ~= 0 && seq(j,LHND(1)) ~= 0
            LELB_LHND(end+1,1) = CalcPointDist(seq(j,LELB),seq(j,LHND));
        end


    end
end

disp(['SHO_HEAD median: ',num2str(round(median(SHO_HEAD(:,1)),3))]);
disp(['HEAD_RHED median: ',num2str(round(median(HEAD_RHED(:,1)),3))]);
disp(['RHED_REAR median: ',num2str(round(median(RHED_REAR(:,1)),3))]);
disp(['HEAD_LHED median: ',num2str(round(median(HEAD_LHED(:,1)),3))]);
disp(['LHED_LEAR median: ',num2str(round(median(LHED_LEAR(:,1)),3))]);
disp(['SHO_RSHO median: ',num2str(round(median(SHO_RSHO(:,1)),3))]);
disp(['RSHO_RELB median: ',num2str(round(median(RSHO_RELB(:,1)),3))]);
disp(['RELB_RHND median: ',num2str(round(median(RELB_RHND(:,1)),3))]);
disp(['SHO_LSHO median: ',num2str(round(median(SHO_LSHO(:,1)),3))]);
disp(['LSHO_LELB median: ',num2str(round(median(LSHO_LELB(:,1)),3))]);
disp(['LELB_LHND median: ',num2str(round(median(LELB_LHND(:,1)),3))]);
