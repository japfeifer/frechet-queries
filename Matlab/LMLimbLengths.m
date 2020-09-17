
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

CompMoveData = sortrows(CompMoveData,[2,1,3]);
limbLenghts = [];
% for i=1:size(CompMoveData,1) % for each seq
for i=1:14
    seq = cell2mat(CompMoveData(i,4)); 
    for j=1:size(seq,1) % for each seq frame
        a_b = CalcPointDist(seq(j,RWST),seq(j,RELB));
        limbLenghts(end+1,:) = [a_b];
    end
end

CompMoveData = sortrows(CompMoveData,[1,2,3]);

disp(['a_b median: ',num2str(round(median(limbLenghts(:,1)),3))]);

figure(5);
h1 = histogram(limbLenghts(:,1),40);
