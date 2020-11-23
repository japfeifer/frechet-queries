
HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];
    
limbLenghts = [];
for i=1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4)); 
    for j=1:size(seq,1) % for each seq frame
        HIP_SPIN = CalcPointDist(seq(j,HIP),seq(j,SPIN));
        SPIN_SHO = CalcPointDist(seq(j,SPIN),seq(j,SHO));
        SHO_NECK = CalcPointDist(seq(j,SHO),seq(j,NECK));
        NECK_HEAD = CalcPointDist(seq(j,NECK),seq(j,HEAD));
        SHO_RSHO = CalcPointDist(seq(j,SHO),seq(j,RSHO));
        RSHO_RELB = CalcPointDist(seq(j,RSHO),seq(j,RELB));
        RELB_RWST = CalcPointDist(seq(j,RELB),seq(j,RWST));
        RWST_RHND = CalcPointDist(seq(j,RWST),seq(j,RHND));
        RHND_RTHM = CalcPointDist(seq(j,RHND),seq(j,RTHM));
        RHND_RTIP = CalcPointDist(seq(j,RHND),seq(j,RTIP));
        SHO_LSHO = CalcPointDist(seq(j,SHO),seq(j,LSHO));
        LSHO_LELB = CalcPointDist(seq(j,LSHO),seq(j,LELB));
        LELB_LWST = CalcPointDist(seq(j,LELB),seq(j,LWST));
        LWST_LHND = CalcPointDist(seq(j,LWST),seq(j,LHND));
        LHND_LTHM = CalcPointDist(seq(j,LHND),seq(j,LTHM));
        LHND_LTIP = CalcPointDist(seq(j,LHND),seq(j,LTIP));
        HIP_RHIP = CalcPointDist(seq(j,HIP),seq(j,RHIP));
        RHIP_RKNE = CalcPointDist(seq(j,RHIP),seq(j,RKNE));
        RKNE_RANK = CalcPointDist(seq(j,RKNE),seq(j,RANK));
        RANK_RFOT = CalcPointDist(seq(j,RANK),seq(j,RFOT));
        HIP_LHIP = CalcPointDist(seq(j,HIP),seq(j,LHIP));
        LHIP_LKNE = CalcPointDist(seq(j,LHIP),seq(j,LKNE));
        LKNE_LANK = CalcPointDist(seq(j,LKNE),seq(j,LANK));
        LANK_LFOT = CalcPointDist(seq(j,LANK),seq(j,LFOT));
        
        limbLenghts(end+1,:) = [HIP_SPIN SPIN_SHO SHO_NECK NECK_HEAD ...
                                SHO_RSHO SHO_LSHO RSHO_RELB LSHO_LELB ...
                                RELB_RWST LELB_LWST RWST_RHND LWST_LHND ...
                                RHND_RTHM LHND_LTHM RHND_RTIP LHND_LTIP ...
                                HIP_RHIP HIP_LHIP RHIP_RKNE LHIP_LKNE ...
                                RKNE_RANK LKNE_LANK RANK_RFOT LANK_LFOT];
    end
end

disp(['HIP_SPIN median: ',num2str(round(median(limbLenghts(:,1)),3))]);
disp(['SPIN_SHO median: ',num2str(round(median(limbLenghts(:,2)),3))]);
disp(['SHO_NECK median: ',num2str(round(median(limbLenghts(:,3)),3))]);
disp(['NECK_HEAD median: ',num2str(round(median(limbLenghts(:,4)),3))]);
disp(['SHO_BSHO median: ',num2str(round(median([limbLenghts(:,5); limbLenghts(:,6)]),3))]);
disp(['BSHO_ELB median: ',num2str(round(median([limbLenghts(:,7); limbLenghts(:,8)]),3))]);
disp(['ELB_WST median: ',num2str(round(median([limbLenghts(:,9); limbLenghts(:,10)]),3))]);
disp(['WST_HND median: ',num2str(round(median([limbLenghts(:,11); limbLenghts(:,12)]),3))]);
disp(['HND_THM median: ',num2str(round(median([limbLenghts(:,13); limbLenghts(:,14)]),3))]);
disp(['HND_TIP median: ',num2str(round(median([limbLenghts(:,15); limbLenghts(:,16)]),3))]);
disp(['HIP_BHIP median: ',num2str(round(median([limbLenghts(:,17); limbLenghts(:,18)]),3))]);
disp(['BHIP_KNE median: ',num2str(round(median([limbLenghts(:,19); limbLenghts(:,20)]),3))]);
disp(['KNE_ANK median: ',num2str(round(median([limbLenghts(:,21); limbLenghts(:,22)]),3))]);
disp(['ANK_FOT median: ',num2str(round(median([limbLenghts(:,23); limbLenghts(:,24)]),3))]);

figure;
h1 = histogram(limbLenghts(:,1),40);
hold on