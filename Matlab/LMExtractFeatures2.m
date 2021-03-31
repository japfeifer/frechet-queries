function seq2 = LMExtractFeatures2(seq,def,idx)

    global CompMoveData

    % seq joints
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
    
    seq2 = [];
    a = 1;
    
    for i = 1:size(def,2)
        switch def(i)
            case 1 
                seq2(:,a:a+2) = seq(:,LTPR); a=a+3;
            case 2
                seq2(:,a:a+2) = seq(:,LTDI); a=a+3;
            case 3
                seq2(:,a:a+2) = seq(:,LTEF); a=a+3;
            case 4
                seq2(:,a:a+2) = seq(:,LIPR); a=a+3;
            case 5
                seq2(:,a:a+2) = seq(:,LIME); a=a+3;
            case 6
                seq2(:,a:a+2) = seq(:,LIDI); a=a+3;
            case 7
                seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
            case 8
                seq2(:,a:a+2) = seq(:,LMPR); a=a+3;
            case 9
                seq2(:,a:a+2) = seq(:,LMME); a=a+3;
            case 10
                seq2(:,a:a+2) = seq(:,LMDI); a=a+3;
            case 11
                seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
            case 12
                seq2(:,a:a+2) = seq(:,LRPR); a=a+3;
            case 13
                seq2(:,a:a+2) = seq(:,LRME); a=a+3;
            case 14
                seq2(:,a:a+2) = seq(:,LRDI); a=a+3;
            case 15
                seq2(:,a:a+2) = seq(:,LREF); a=a+3;
            case 16
                seq2(:,a:a+2) = seq(:,LPPR); a=a+3;
            case 17
                seq2(:,a:a+2) = seq(:,LPME); a=a+3;
            case 18
                seq2(:,a:a+2) = seq(:,LPDI); a=a+3;
            case 19
                seq2(:,a:a+2) = seq(:,LPEF); a=a+3;
            case 20
                seq2(:,a:a+2) = seq(:,LPAL); a=a+3;
            case 21
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
            case 22
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 23
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 24
                seq2(:,a:a+2) = seq(:,LAFR); a=a+3;
            case 25
                seq2(:,a:a+2) = seq(:,LAFU); a=a+3;
            case 26
                seq2(:,a:a+2) = seq(:,LABL); a=a+3;
            case 27
                seq2(:,a:a+2) = seq(:,LABM); a=a+3;

            case 28 
                seq2(:,a:a+2) = seq(:,RTPR); a=a+3;
            case 29
                seq2(:,a:a+2) = seq(:,RTDI); a=a+3;
            case 30
                seq2(:,a:a+2) = seq(:,RTEF); a=a+3;
            case 31
                seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
            case 32
                seq2(:,a:a+2) = seq(:,RIME); a=a+3;
            case 33
                seq2(:,a:a+2) = seq(:,RIDI); a=a+3;
            case 34
                seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
            case 35
                seq2(:,a:a+2) = seq(:,RMPR); a=a+3;
            case 36
                seq2(:,a:a+2) = seq(:,RMME); a=a+3;
            case 37
                seq2(:,a:a+2) = seq(:,RMDI); a=a+3;
            case 38
                seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
            case 39
                seq2(:,a:a+2) = seq(:,RRPR); a=a+3;
            case 40
                seq2(:,a:a+2) = seq(:,RRME); a=a+3;
            case 41
                seq2(:,a:a+2) = seq(:,RRDI); a=a+3;
            case 42
                seq2(:,a:a+2) = seq(:,RREF); a=a+3;
            case 43
                seq2(:,a:a+2) = seq(:,RPPR); a=a+3;
            case 44
                seq2(:,a:a+2) = seq(:,RPME); a=a+3;
            case 45
                seq2(:,a:a+2) = seq(:,RPDI); a=a+3;
            case 46
                seq2(:,a:a+2) = seq(:,RPEF); a=a+3;
            case 47
                seq2(:,a:a+2) = seq(:,RPAL); a=a+3;
            case 48
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
            case 49
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 50
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 51
                seq2(:,a:a+2) = seq(:,RAFR); a=a+3;
            case 52
                seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
            case 53
                seq2(:,a:a+2) = seq(:,RABL); a=a+3;
            case 54
                seq2(:,a:a+2) = seq(:,RABM); a=a+3;                
                
            case 55
                seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LHND);  a=a+3;
            case 56
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
            case 57
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LMPR);  a=a+3;
            case 58
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,LRPR);  a=a+3;
            case 59
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPPR);  a=a+3;
            case 60
                seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
            case 61
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
            case 62
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
            case 63
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,RRPR);  a=a+3;
            case 64
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
                
            case 65
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
            case 66
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
            case 67
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
            case 68
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
            case 69
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
            case 70
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
            case 71
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
            case 72
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
                
            case 73
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,LMPR);  a=a+3;
                
            case 101
                seq2(:,a:a+2) = seq(:,LTPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LTDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LTEF); a=a+3;
            case 102
                seq2(:,a:a+2) = seq(:,LIPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LIME); a=a+3;
                seq2(:,a:a+2) = seq(:,LIDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
            case 103
                seq2(:,a:a+2) = seq(:,LMPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LMME); a=a+3;
                seq2(:,a:a+2) = seq(:,LMDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
            case 104
                seq2(:,a:a+2) = seq(:,LRPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LRME); a=a+3;
                seq2(:,a:a+2) = seq(:,LRDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LREF); a=a+3;
            case 105
                seq2(:,a:a+2) = seq(:,LPPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LPME); a=a+3;
                seq2(:,a:a+2) = seq(:,LPDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF); a=a+3;
            case 106
                seq2(:,a:a+2) = seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFR); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFU); a=a+3;
                seq2(:,a:a+2) = seq(:,LABL); a=a+3;
                seq2(:,a:a+2) = seq(:,LABM); a=a+3;
            case 107
                seq2(:,a:a+2) = seq(:,RTPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RTDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RTEF); a=a+3;
            case 108
                seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RIME); a=a+3;
                seq2(:,a:a+2) = seq(:,RIDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
            case 109
                seq2(:,a:a+2) = seq(:,RMPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RMME); a=a+3;
                seq2(:,a:a+2) = seq(:,RMDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
            case 110
                seq2(:,a:a+2) = seq(:,RRPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RRME); a=a+3;
                seq2(:,a:a+2) = seq(:,RRDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RREF); a=a+3;
            case 111
                seq2(:,a:a+2) = seq(:,RPPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RPME); a=a+3;
                seq2(:,a:a+2) = seq(:,RPDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF); a=a+3;
            case 112
                seq2(:,a:a+2) = seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFR); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
                seq2(:,a:a+2) = seq(:,RABL); a=a+3;
                seq2(:,a:a+2) = seq(:,RABM); a=a+3;
            case 113
                seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LHND);  a=a+3;
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LIPR);  a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LMPR);  a=a+3;
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,LRPR);  a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPPR);  a=a+3;
            case 114
                seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RHND);  a=a+3;
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RIPR);  a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RMPR);  a=a+3;
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,RRPR);  a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPPR);  a=a+3;
            case 115
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LTEF);  a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LTEF);  a=a+3;
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,LTEF);  a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LTEF);  a=a+3;
            case 116
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RTEF);  a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RTEF);  a=a+3;
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,RTEF);  a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RTEF);  a=a+3;
                
            case 1001
                seq2(:,a:a+2) = seq(:,LTPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LTDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LTEF); a=a+3;
            case 1002
                seq2(:,a:a+2) = seq(:,LIPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LIME); a=a+3;
                seq2(:,a:a+2) = seq(:,LIDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LIEF); a=a+3;
            case 1003
                seq2(:,a:a+2) = seq(:,LMPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LMME); a=a+3;
                seq2(:,a:a+2) = seq(:,LMDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF); a=a+3;
            case 1004
                seq2(:,a:a+2) = seq(:,LRPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LRME); a=a+3;
                seq2(:,a:a+2) = seq(:,LRDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LREF); a=a+3;
            case 1005
                seq2(:,a:a+2) = seq(:,LPPR); a=a+3;
                seq2(:,a:a+2) = seq(:,LPME); a=a+3;
                seq2(:,a:a+2) = seq(:,LPDI); a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF); a=a+3;
            case 1006
                seq2(:,a:a+2) = seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 1007
                seq2(:,a:a+2) = seq(:,LAFR); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFU); a=a+3;
                seq2(:,a:a+2) = seq(:,LABL); a=a+3;
                seq2(:,a:a+2) = seq(:,LABM); a=a+3;
            case 1008
                seq2(:,a:a+2) = seq(:,RTPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RTDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RTEF); a=a+3;
            case 1009
                seq2(:,a:a+2) = seq(:,RIPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RIME); a=a+3;
                seq2(:,a:a+2) = seq(:,RIDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RIEF); a=a+3;
            case 1010
                seq2(:,a:a+2) = seq(:,RMPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RMME); a=a+3;
                seq2(:,a:a+2) = seq(:,RMDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF); a=a+3;
            case 1011
                seq2(:,a:a+2) = seq(:,RRPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RRME); a=a+3;
                seq2(:,a:a+2) = seq(:,RRDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RREF); a=a+3;
            case 1012
                seq2(:,a:a+2) = seq(:,RPPR); a=a+3;
                seq2(:,a:a+2) = seq(:,RPME); a=a+3;
                seq2(:,a:a+2) = seq(:,RPDI); a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF); a=a+3;
            case 1013
                seq2(:,a:a+2) = seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 1014
                seq2(:,a:a+2) = seq(:,RAFR); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFU); a=a+3;
                seq2(:,a:a+2) = seq(:,RABL); a=a+3;
                seq2(:,a:a+2) = seq(:,RABM); a=a+3;
                
            case 1015
                seq2(:,a:a+2) = seq(:,LTPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LTDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LPAL); a=a+3;
            case 1016
                seq2(:,a:a+2) = seq(:,LIPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LIME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LIDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,LPAL); a=a+3;
            case 1017
                seq2(:,a:a+2) = seq(:,LMPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LMME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LMDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LPAL); a=a+3;
            case 1018
                seq2(:,a:a+2) = seq(:,LRPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LRME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LRDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,LPAL); a=a+3;
            case 1019
                seq2(:,a:a+2) = seq(:,LPPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LPME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LPDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LPAL); a=a+3;
            case 1020
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LPAL); a=a+3;
            case 1021
                seq2(:,a:a+2) = seq(:,LAFR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFU) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LABL) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LABM) - seq(:,LPAL); a=a+3;
            case 1022
                seq2(:,a:a+2) = seq(:,RTPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RTDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RTEF) - seq(:,LPAL); a=a+3;
            case 1023
                seq2(:,a:a+2) = seq(:,RIPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RIME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RIDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,LPAL); a=a+3;
            case 1024
                seq2(:,a:a+2) = seq(:,RMPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RMME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RMDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,LPAL); a=a+3;
            case 1025
                seq2(:,a:a+2) = seq(:,RRPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RRME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RRDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,LPAL); a=a+3;
            case 1026
                seq2(:,a:a+2) = seq(:,RPPR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RPME) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RPDI) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,LPAL); a=a+3;
            case 1027
                seq2(:,a:a+2) = seq(:,RPAL) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LPAL); a=a+3;
            case 1028
                seq2(:,a:a+2) = seq(:,RAFR) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFU) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RABL) - seq(:,LPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RABM) - seq(:,LPAL); a=a+3;
                
            case 1029
                seq2(:,a:a+2) = seq(:,LTPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LTDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LTEF) - seq(:,RPAL); a=a+3;
            case 1030
                seq2(:,a:a+2) = seq(:,LIPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LIME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LIDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,RPAL); a=a+3;
            case 1031
                seq2(:,a:a+2) = seq(:,LMPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LMME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LMDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,RPAL); a=a+3;
            case 1032
                seq2(:,a:a+2) = seq(:,LRPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LRME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LRDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,RPAL); a=a+3;
            case 1033
                seq2(:,a:a+2) = seq(:,LPPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LPME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LPDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,RPAL); a=a+3;
            case 1034
                seq2(:,a:a+2) = seq(:,LPAL) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RPAL); a=a+3;
            case 1035
                seq2(:,a:a+2) = seq(:,LAFR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFU) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LABL) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,LABM) - seq(:,RPAL); a=a+3;
            case 1036
                seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RPAL); a=a+3;
            case 1037
                seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RIME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,RPAL); a=a+3;
            case 1038
                seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RMME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RPAL); a=a+3;
            case 1039
                seq2(:,a:a+2) = seq(:,RRPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RRME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RRDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,RPAL); a=a+3;
            case 1040
                seq2(:,a:a+2) = seq(:,RPPR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RPME) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RPDI) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RPAL); a=a+3;
            case 1041
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RPAL); a=a+3;
            case 1042
                seq2(:,a:a+2) = seq(:,RAFR) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFU) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RABL) - seq(:,RPAL); a=a+3;
                seq2(:,a:a+2) = seq(:,RABM) - seq(:,RPAL); a=a+3;
                
            case 1043
                seq2(:,a:a+2) = seq(:,LTPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LTDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LTEF) - seq(:,LIEF); a=a+3;
            case 1044
                seq2(:,a:a+2) = seq(:,LIPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LIME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LIDI) - seq(:,LIEF); a=a+3;
            case 1045
                seq2(:,a:a+2) = seq(:,LMPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LMME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LMDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,LIEF); a=a+3;
            case 1046
                seq2(:,a:a+2) = seq(:,LRPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LRME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LRDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,LIEF); a=a+3;
            case 1047
                seq2(:,a:a+2) = seq(:,LPPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LPME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LPDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,LIEF); a=a+3;
            case 1048
                seq2(:,a:a+2) = seq(:,LPAL) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LIEF); a=a+3;
            case 1049
                seq2(:,a:a+2) = seq(:,LAFR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFU) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LABL) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LABM) - seq(:,LIEF); a=a+3;
            case 1050
                seq2(:,a:a+2) = seq(:,RTPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RTDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RTEF) - seq(:,LIEF); a=a+3;
            case 1051
                seq2(:,a:a+2) = seq(:,RIPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RIME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RIDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RIEF) - seq(:,LIEF); a=a+3;
            case 1052
                seq2(:,a:a+2) = seq(:,RMPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RMME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RMDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,LIEF); a=a+3;
            case 1053
                seq2(:,a:a+2) = seq(:,RRPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RRME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RRDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,LIEF); a=a+3;
            case 1054
                seq2(:,a:a+2) = seq(:,RPPR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RPME) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RPDI) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,LIEF); a=a+3;
            case 1055
                seq2(:,a:a+2) = seq(:,RPAL) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LIEF); a=a+3;
            case 1056
                seq2(:,a:a+2) = seq(:,RAFR) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFU) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RABL) - seq(:,LIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RABM) - seq(:,LIEF); a=a+3;
                
            case 1057
                seq2(:,a:a+2) = seq(:,LTPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LTDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LTEF) - seq(:,RIEF); a=a+3;
            case 1058
                seq2(:,a:a+2) = seq(:,LIPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LIME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LIDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LIEF) - seq(:,RIEF); a=a+3;
            case 1059
                seq2(:,a:a+2) = seq(:,LMPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LMME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LMDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LMEF) - seq(:,RIEF); a=a+3;
            case 1060
                seq2(:,a:a+2) = seq(:,LRPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LRME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LRDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LREF) - seq(:,RIEF); a=a+3;
            case 1061
                seq2(:,a:a+2) = seq(:,LPPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LPME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LPDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LPEF) - seq(:,RIEF); a=a+3;
            case 1062
                seq2(:,a:a+2) = seq(:,LPAL) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RIEF); a=a+3;
            case 1063
                seq2(:,a:a+2) = seq(:,LAFR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LAFU) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LABL) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,LABM) - seq(:,RIEF); a=a+3;
            case 1064
                seq2(:,a:a+2) = seq(:,RTPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RTDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RTEF) - seq(:,RIEF); a=a+3;
            case 1065
                seq2(:,a:a+2) = seq(:,RIPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RIME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RIDI) - seq(:,RIEF); a=a+3;
            case 1066
                seq2(:,a:a+2) = seq(:,RMPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RMME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RMDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RMEF) - seq(:,RIEF); a=a+3;
            case 1067
                seq2(:,a:a+2) = seq(:,RRPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RRME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RRDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RREF) - seq(:,RIEF); a=a+3;
            case 1068
                seq2(:,a:a+2) = seq(:,RPPR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RPME) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RPDI) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RPEF) - seq(:,RIEF); a=a+3;
            case 1069
                seq2(:,a:a+2) = seq(:,RPAL) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RIEF); a=a+3;
            case 1070
                seq2(:,a:a+2) = seq(:,RAFR) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RAFU) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RABL) - seq(:,RIEF); a=a+3;
                seq2(:,a:a+2) = seq(:,RABM) - seq(:,RIEF); a=a+3;

  
                
        end
    end
end