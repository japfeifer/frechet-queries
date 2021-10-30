function seq2 = MSASLExtractFeatures(seq,extractMethod)

    HEAD = [1,2,3];         NECK = [4,5,6];         RSHO = [7,8,9];        RELB = [10,11,12];
    RWST = [13,14,15];      LSHO = [16,17,18];      LELB = [19,20,21];     LWST = [22,23,24];
    RHIP = [25,26,27];      RKNE = [28,29,30];      RFOT = [31,32,33];     LHIP = [34,35,36];
    LKNE = [37,38,39];      LFOT = [40,41,42];      REYE = [43,44,45];     LEYE = [46,47,48];
    REAR = [49,50,51];      LEAR = [52,53,54]; 

    LTPR = [61,62,63];      LTDI = [64,65,66];      LTEF = [67,68,69];                            % thumb
    LIPR = [70,71,72];      LIME = [73,74,75];      LIDI = [76,77,78];     LIEF = [79,80,81];     % index finger
    LMPR = [82,83,84];      LMME = [85,86,87];      LMDI = [88,89,90];     LMEF = [91,92,93];     % middle finger
    LRPR = [94,95,96];      LRME = [97,98,99];      LRDI = [100,101,102];  LREF = [103,104,105];  % ring finger
    LPPR = [106,107,108];   LPME = [109,110,111];   LPDI = [112,113,114];  LPEF = [115,116,117];  % pinky finger
    LPAL = [55,56,57];      LTPA = [58,59,60];                                                    % palm and thumb palm

    RTPR = [124,125,126];   RTDI = [127,128,129];   RTEF = [130,131,132];                         % thumb
    RIPR = [133,134,135];   RIME = [136,137,138];   RIDI = [139,140,141];  RIEF = [142,143,144];  % index finger
    RMPR = [145,146,147];   RMME = [148,149,150];   RMDI = [151,152,153];  RMEF = [154,155,156];  % middle finger
    RRPR = [157,158,159];   RRME = [160,161,162];   RRDI = [163,164,165];  RREF = [166,167,168];  % ring finger
    RPPR = [169,170,171];   RPME = [172,173,174];   RPDI = [175,176,177];  RPEF = [178,179,180];  % pinky finger
    RPAL = [118,119,120];   RTPA = [121,122,123];                                                 % palm and thumb palm
    
    seq2 = [];
    a = 1;
    
    if extractMethod == 1 
        % just keep sequence as-is
        seq2 = seq;
    elseif extractMethod == 2
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 3
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LELB); a=a+3;
    elseif extractMethod == 4
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LEAR); a=a+3;
    elseif extractMethod == 5
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 6
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 7
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
    elseif extractMethod == 8
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR); a=a+3;
    elseif extractMethod == 9
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
    elseif extractMethod == 10
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LEAR); a=a+3;
    elseif extractMethod == 11
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 12
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RWST); a=a+3;
    elseif extractMethod == 13
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 14
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 15
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RWST); a=a+3;
    elseif extractMethod == 16
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 17
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 18
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 19
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 20
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LWST); a=a+3;
    elseif extractMethod == 21
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 22
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 23
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 24
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LWST); a=a+3;
    elseif extractMethod == 25
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 26
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 27
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 28
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 29
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 30
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 31
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 32
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RELB); a=a+3;
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LSHO); a=a+3;

    elseif extractMethod == 1001
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
    elseif extractMethod == 1002
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
    elseif extractMethod == 1003
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 1004
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 1005
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 1006
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod == 1007
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 1008
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 1009
        seq2(:,a:a+2) = seq(:,REYE); a=a+3;
    elseif extractMethod == 1010
        seq2(:,a:a+2) = seq(:,LEYE); a=a+3;
    elseif extractMethod == 1011
        seq2(:,a:a+2) = seq(:,REAR); a=a+3;
    elseif extractMethod == 1012
        seq2(:,a:a+2) = seq(:,LEAR); a=a+3;

    elseif extractMethod == 1013
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1014
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1015
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1016
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1017
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1018
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1019
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1020
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1021
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1022
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1023
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 1024
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,HEAD); a=a+3;

    elseif extractMethod == 1025
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1026
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1027
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1028
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1029
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1030
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1031
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1032
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1033
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1034
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1035
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,NECK); a=a+3;
    elseif extractMethod == 1036
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,NECK); a=a+3;

    elseif extractMethod == 1037
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1038
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1039
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1040
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1041
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1042
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1043
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1044
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1045
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1046
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1047
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RWST); a=a+3;
    elseif extractMethod == 1048
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RWST); a=a+3;

    elseif extractMethod == 1049
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1050
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1051
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1052
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1053
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1054
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1055
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1056
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1057
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1058
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1059
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LWST); a=a+3;
    elseif extractMethod == 1060
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LWST); a=a+3;

    elseif extractMethod == 1061
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1062
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1063
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1064
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1065
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1066
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1067
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1068
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1069
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1070
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1071
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RSHO); a=a+3;
    elseif extractMethod == 1072
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RSHO); a=a+3;

    elseif extractMethod == 1073
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1074
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1075
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1076
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1077
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1078
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1079
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1080
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1081
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LSHO); a=a+3;  
    elseif extractMethod == 1082
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1083
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LSHO); a=a+3;
    elseif extractMethod == 1084
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LSHO); a=a+3;

    elseif extractMethod == 1085
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1086
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1087
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1088
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1089
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1090
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1091
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1092
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1093
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1094
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1095
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RELB); a=a+3;
    elseif extractMethod == 1096
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RELB); a=a+3;

    elseif extractMethod == 1097
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1098
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1099
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1100
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1101
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1102
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1103
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1104
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1105
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1106
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1107
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LELB); a=a+3;
    elseif extractMethod == 1108
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LELB); a=a+3;
        
        
    elseif extractMethod == 2001
        seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
    elseif extractMethod == 2002
        seq2(:,a:a+2) = seq(:,NECK); a=a+3;
    elseif extractMethod == 2003
        seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
    elseif extractMethod == 2004
        seq2(:,a:a+2) = seq(:,RELB); a=a+3;
    elseif extractMethod == 2005
        seq2(:,a:a+2) = seq(:,RWST); a=a+3;
    elseif extractMethod == 2006
        seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
    elseif extractMethod == 2007
        seq2(:,a:a+2) = seq(:,LELB); a=a+3;
    elseif extractMethod == 2008
        seq2(:,a:a+2) = seq(:,LWST); a=a+3;
    elseif extractMethod == 2009
        seq2(:,a:a+2) = seq(:,REYE); a=a+3;
    elseif extractMethod == 2010
        seq2(:,a:a+2) = seq(:,LEYE); a=a+3;
    elseif extractMethod == 2011
        seq2(:,a:a+2) = seq(:,REAR); a=a+3;
    elseif extractMethod == 2012
        seq2(:,a:a+2) = seq(:,LEAR); a=a+3;
    elseif extractMethod == 2013
        seq2(:,a:a+2) = seq(:,RTPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF); a=a+3;
    elseif extractMethod == 2014
        seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
    elseif extractMethod == 2015
        seq2(:,a:a+2) = seq(:,RMPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
    elseif extractMethod == 2016
        seq2(:,a:a+2) = seq(:,RRPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF); a=a+3;
    elseif extractMethod == 2017
        seq2(:,a:a+2) = seq(:,RPPR); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF); a=a+3;
    elseif extractMethod == 2018
        seq2(:,a:a+2) = seq(:,LTPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF); a=a+3;
    elseif extractMethod == 2019
        seq2(:,a:a+2) = seq(:,LIPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
    elseif extractMethod == 2020
        seq2(:,a:a+2) = seq(:,LMPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
    elseif extractMethod == 2021
        seq2(:,a:a+2) = seq(:,LRPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF); a=a+3;
    elseif extractMethod == 2022
        seq2(:,a:a+2) = seq(:,LPPR); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF); a=a+3;

    elseif extractMethod == 2101
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2102
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2103
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2104
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2105
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2106
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2107
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2108
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2109
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2110
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2111
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2112
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2113
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2114
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2115
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2116
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2117
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2118
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2119
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2120
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2121
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,HEAD); a=a+3;
    elseif extractMethod == 2122
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,HEAD); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,HEAD); a=a+3;

    elseif extractMethod == 2201
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2202
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2203
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2204
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2205
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2206
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2207
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2208
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2209
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2210
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2211
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2212
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2213
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2214
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2215
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2216
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2217
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2218
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2219
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2220
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2221
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,NECK); a=a+3;
    elseif extractMethod == 2222
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,NECK); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,NECK); a=a+3;

    elseif extractMethod == 2301
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2302
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2303
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2304
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2305
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2306
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2307
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2308
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2309
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2310
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2311
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2312
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2313
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2314
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2315
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2316
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2317
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2318
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2319
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2320
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2321
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,RWST); a=a+3;
    elseif extractMethod == 2322
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,RWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,RWST); a=a+3;

    elseif extractMethod == 2401
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2402
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2403
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2404
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2405
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2406
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2407
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2408
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2409
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2410
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2411
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2412
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2413
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2414
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2415
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2416
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2417
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2418
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2419
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2420
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2421
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,RPAL); a=a+3;
    elseif extractMethod == 2422
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,RPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,RPAL); a=a+3;

    elseif extractMethod == 2501
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2502
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2503
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2504
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2505
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2506
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2507
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2508
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2509
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2510
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2511
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2512
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2513
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2514
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2515
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2516
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2517
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2518
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2519
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2520
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2521
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,RIEF); a=a+3;
    elseif extractMethod == 2522
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,RIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,RIEF); a=a+3;

    elseif extractMethod == 2601
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2602
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2603
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2604
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2605
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2606
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2607
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2608
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2609
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2610
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2611
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2612
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2613
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2614
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2615
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2616
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2617
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2618
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2619
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2620
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2621
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LWST); a=a+3;
    elseif extractMethod == 2622
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,LWST); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LWST); a=a+3;

    elseif extractMethod == 2701
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2702
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2703
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2704
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2705
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2706
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2707
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2708
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2709
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2710
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2711
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2712
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2713
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2714
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RIEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2715
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2716
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2717
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2718
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2719
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2720
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2721
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LPAL); a=a+3;
    elseif extractMethod == 2722
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,LPAL); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPAL); a=a+3;

    elseif extractMethod == 2801
        seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2802
        seq2(:,a:a+2) = seq(:,NECK) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2803
        seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2804
        seq2(:,a:a+2) = seq(:,RELB) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2805
        seq2(:,a:a+2) = seq(:,RWST) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2806
        seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2807
        seq2(:,a:a+2) = seq(:,LELB) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2808
        seq2(:,a:a+2) = seq(:,LWST) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2809
        seq2(:,a:a+2) = seq(:,REYE) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2810
        seq2(:,a:a+2) = seq(:,LEYE) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2811
        seq2(:,a:a+2) = seq(:,REAR) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2812
        seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2813
        seq2(:,a:a+2) = seq(:,RTPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RTEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2814
        seq2(:,a:a+2) = seq(:,RIPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RIDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2815
        seq2(:,a:a+2) = seq(:,RMPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RMEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2816
        seq2(:,a:a+2) = seq(:,RRPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RRME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RRDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RREF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2817
        seq2(:,a:a+2) = seq(:,RPPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,RPEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2818
        seq2(:,a:a+2) = seq(:,LTPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LTDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2819
        seq2(:,a:a+2) = seq(:,LIPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2820
        seq2(:,a:a+2) = seq(:,LMPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LMME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LMDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2821
        seq2(:,a:a+2) = seq(:,LRPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LRME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LRDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LREF) - seq(:,LIEF); a=a+3;
    elseif extractMethod == 2822
        seq2(:,a:a+2) = seq(:,LPPR) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LPME) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LPDI) - seq(:,LIEF); a=a+3;
        seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LIEF); a=a+3;
        
  
    end

    
end