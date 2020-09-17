
TORS = [4,5,6];
NECK = [1,2,3];
LSHO = [19,20,21];
LELB = [22,23,24];
LWST = [25,26,27];
LHND = [28,29,30];
RSHO = [7,8,9];
RELB = [10,11,12];
RWST = [13,14,15];
RHND = [16,17,18];
    
limbLenghts = [];
for i=1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4)); 
    for j=1:size(seq,1) % for each seq frame
        NECK_TORS = CalcPointDist(seq(j,NECK),seq(j,TORS));
        NECK_LSHO = CalcPointDist(seq(j,NECK),seq(j,LSHO));
        LSHO_LELB = CalcPointDist(seq(j,LSHO),seq(j,LELB));
        LELB_LWST = CalcPointDist(seq(j,LELB),seq(j,LWST));
        LWST_LHND = CalcPointDist(seq(j,LWST),seq(j,LHND));
        NECK_RSHO = CalcPointDist(seq(j,NECK),seq(j,RSHO));
        RSHO_RELB = CalcPointDist(seq(j,RSHO),seq(j,RELB));
        RELB_RWST = CalcPointDist(seq(j,RELB),seq(j,RWST));
        RWST_RHND = CalcPointDist(seq(j,RWST),seq(j,RHND));
        limbLenghts(end+1,:) = [NECK_TORS NECK_LSHO LSHO_LELB LELB_LWST LWST_LHND NECK_RSHO RSHO_RELB RELB_RWST RWST_RHND];
    end
end

disp(['NECK_TORS median: ',num2str(round(median(limbLenghts(:,1)),3))]);
disp(['NECK_LSHO median: ',num2str(round(median(limbLenghts(:,2)),3))]);
disp(['NECK_RSHO median: ',num2str(round(median(limbLenghts(:,6)),3))]);
disp(['LSHO_LELB median: ',num2str(round(median(limbLenghts(:,3)),3))]);
disp(['RSHO_RELB median: ',num2str(round(median(limbLenghts(:,7)),3))]);
disp(['LELB_LWST median: ',num2str(round(median(limbLenghts(:,4)),3))]);
disp(['RELB_RWST median: ',num2str(round(median(limbLenghts(:,8)),3))]);
disp(['LWST_LHND median: ',num2str(round(median(limbLenghts(:,5)),3))]);
disp(['RWST_RHND median: ',num2str(round(median(limbLenghts(:,9)),3))]);

disp(['NECK_SHO median: ',num2str(round(median([limbLenghts(:,2); limbLenghts(:,6)]),3))]);
disp(['SHO_ELB median: ',num2str(round(median([limbLenghts(:,3); limbLenghts(:,7)]),3))]);
disp(['ELB_WST median: ',num2str(round(median([limbLenghts(:,4); limbLenghts(:,8)]),3))]);
disp(['WST_HND median: ',num2str(round(median([limbLenghts(:,5); limbLenghts(:,9)]),3))]);

figure;
h1 = histogram(limbLenghts(:,4),40);
hold on