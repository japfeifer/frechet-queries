
TORS = [1,2,3];
NECK = [13,14,15];
HEAD = [16,17,18];
RSHO = [22,23,24];
RELB = [28,29,30];
RHND = [37,38,39];
LSHO = [43,44,45];
LELB = [49,50,51];
LHND = [58,59,60];
RHIP = [64,65,66];
RKNE = [70,71,72];
RFOT = [76,77,78];
LHIP = [85,86,87];
LKNE = [91,92,93];
LFOT = [97,98,99];

numLenghts = 0;
limbLenghts = [];
for i=1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4));
    numLenghts = numLenghts + size(seq,1);
end
limbLenghts(1:numLenghts,1:14) = 0;
lenCnt = 1;
for i=1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4)); 
    for j=1:size(seq,1) % for each seq frame
        HEAD_NECK = CalcPointDist(seq(j,HEAD),seq(j,NECK));
        NECK_TORS = CalcPointDist(seq(j,NECK),seq(j,TORS));
        NECK_LSHO = CalcPointDist(seq(j,NECK),seq(j,LSHO));
        LSHO_LELB = CalcPointDist(seq(j,LSHO),seq(j,LELB));
        LELB_LHND = CalcPointDist(seq(j,LELB),seq(j,LHND));
        NECK_RSHO = CalcPointDist(seq(j,NECK),seq(j,RSHO));
        RSHO_RELB = CalcPointDist(seq(j,RSHO),seq(j,RELB));
        RELB_RHND = CalcPointDist(seq(j,RELB),seq(j,RHND));
        TORS_LHIP = CalcPointDist(seq(j,TORS),seq(j,LHIP));
        LHIP_LKNE = CalcPointDist(seq(j,LHIP),seq(j,LKNE));
        LKNE_LFOT = CalcPointDist(seq(j,LKNE),seq(j,LFOT));
        TORS_RHIP = CalcPointDist(seq(j,TORS),seq(j,RHIP));
        RHIP_RKNE = CalcPointDist(seq(j,RHIP),seq(j,RKNE));
        RKNE_RFOT = CalcPointDist(seq(j,RKNE),seq(j,RFOT));
        limbLenghts(lenCnt,:) = [HEAD_NECK NECK_TORS NECK_LSHO LSHO_LELB LELB_LHND NECK_RSHO RSHO_RELB ...
                                RELB_RHND TORS_LHIP LHIP_LKNE LKNE_LFOT TORS_RHIP RHIP_RKNE RKNE_RFOT];
        lenCnt = lenCnt + 1;
    end
end

disp(['HEAD_NECK median: ',num2str(round(median(limbLenghts(:,1)),3))]);
disp(['NECK_TORS median: ',num2str(round(median(limbLenghts(:,2)),3))]);
disp(['NECK_LSHO median: ',num2str(round(median(limbLenghts(:,3)),3))]);
disp(['LSHO_LELB median: ',num2str(round(median(limbLenghts(:,4)),3))]);
disp(['LELB_LHND median: ',num2str(round(median(limbLenghts(:,5)),3))]);
disp(['NECK_RSHO median: ',num2str(round(median(limbLenghts(:,6)),3))]);
disp(['RSHO_RELB median: ',num2str(round(median(limbLenghts(:,7)),3))]);
disp(['RELB_RHND median: ',num2str(round(median(limbLenghts(:,8)),3))]);
disp(['TORS_LHIP median: ',num2str(round(median(limbLenghts(:,9)),3))]);
disp(['LHIP_LKNE median: ',num2str(round(median(limbLenghts(:,10)),3))]);
disp(['LKNE_LFOT median: ',num2str(round(median(limbLenghts(:,11)),3))]);
disp(['TORS_RHIP median: ',num2str(round(median(limbLenghts(:,12)),3))]);
disp(['RHIP_RKNE median: ',num2str(round(median(limbLenghts(:,13)),3))]);
disp(['RKNE_RFOT median: ',num2str(round(median(limbLenghts(:,14)),3))]);

disp(['NECK_SHO median: ',num2str(round(median([limbLenghts(:,3); limbLenghts(:,6)]),3))]);
disp(['SHO_ELB median: ',num2str(round(median([limbLenghts(:,4); limbLenghts(:,7)]),3))]);
disp(['ELB_HND median: ',num2str(round(median([limbLenghts(:,5); limbLenghts(:,8)]),3))]);
disp(['TOR_HIP median: ',num2str(round(median([limbLenghts(:,9); limbLenghts(:,12)]),3))]);
disp(['HIP_KNE median: ',num2str(round(median([limbLenghts(:,10); limbLenghts(:,13)]),3))]);
disp(['KNE_FOT median: ',num2str(round(median([limbLenghts(:,11); limbLenghts(:,14)]),3))]);

figure;
h1 = histogram(limbLenghts(:,2),40);
hold on