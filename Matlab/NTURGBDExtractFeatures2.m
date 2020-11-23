function seq2 = NTURGBDExtractFeatures2(seq,def)

    HIP  = [1,2,3]; SPIN = [4,5,6]; NECK = [7,8,9]; HEAD = [10,11,12];
    LSHO = [13,14,15]; LELB = [16,17,18]; LWST = [19,20,21]; LHND = [22,23,24];
    RSHO = [25,26,27]; RELB = [28,29,30]; RWST = [31,32,33]; RHND = [34,35,36];
    LHIP = [37,38,39]; LKNE = [40,41,42]; LANK = [43,44,45]; LFOT = [46,47,48];
    RHIP = [49,50,51]; RKNE = [52,53,54]; RANK = [55,56,57]; RFOT = [58,59,60];
    SHO  = [61,62,63]; LTIP = [64,65,66]; LTHM = [67,68,69]; RTIP = [70,71,72]; RTHM = [73,74,75];
    
    seq2 = [];
    a = 1;
    
    for i = 1:size(def,2)
        switch def(i)
            case 1001
                seq2(:,a:a+2) = seq(:,HIP); a=a+3;
            case 1002
                seq2(:,a:a+2) = seq(:,SPIN); a=a+3;
            case 1003
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
            case 1004
                seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
            case 1005
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
            case 1006
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 1007
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
            case 1008
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 1009
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
            case 1010
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 1011
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
            case 1012
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 1013
                seq2(:,a:a+2) = seq(:,LHIP); a=a+3;
            case 1014
                seq2(:,a:a+2) = seq(:,LKNE); a=a+3;
            case 1015
                seq2(:,a:a+2) = seq(:,LANK); a=a+3;
            case 1016
                seq2(:,a:a+2) = seq(:,LFOT); a=a+3;
            case 1017
                seq2(:,a:a+2) = seq(:,RHIP); a=a+3;
            case 1018
                seq2(:,a:a+2) = seq(:,RKNE); a=a+3;
            case 1019
                seq2(:,a:a+2) = seq(:,RANK); a=a+3;
            case 1020
                seq2(:,a:a+2) = seq(:,RFOT); a=a+3;
            case 1021
                seq2(:,a:a+2) = seq(:,SHO); a=a+3; 
            case 1022
                seq2(:,a:a+2) = seq(:,LTIP); a=a+3;
            case 1023
                seq2(:,a:a+2) = seq(:,LTHM); a=a+3;
            case 1024
                seq2(:,a:a+2) = seq(:,RTIP); a=a+3;
            case 1025
                seq2(:,a:a+2) = seq(:,RTHM); a=a+3;
            case 1026
                seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HIP); a=a+3;
            case 1027
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,HIP); a=a+3;
            case 1028
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,HIP); a=a+3;
            case 1029
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HIP); a=a+3;
            case 1030
                seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HIP); a=a+3;
            case 1031
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,HIP); a=a+3;
            case 1032
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,HIP); a=a+3;
            case 1033
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HIP); a=a+3;
            case 1034
                seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HIP); a=a+3;
            case 1035
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,HIP); a=a+3;
            case 1036
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HIP); a=a+3;
            case 1037
                seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
            case 1038
                seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HIP); a=a+3;
            case 1039
                seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HIP); a=a+3;
            case 1040
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HIP); a=a+3;
            case 1041
                seq2(:,a:a+2) = seq(:,RTIP) - seq(:,HEAD); a=a+3;
            case 1042
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
            case 1043
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
            case 1044
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
            case 1045
                seq2(:,a:a+2) = seq(:,LTIP) - seq(:,HEAD); a=a+3;
            case 1046
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
            case 1047
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
            case 1048
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
            case 1049
                seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HEAD); a=a+3;
            case 1050
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,HEAD); a=a+3;
            case 1051
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,HEAD); a=a+3;
            case 1052
                seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HEAD); a=a+3;
            case 1053
                seq2(:,a:a+2) = seq(:,LKNE) - seq(:,HEAD); a=a+3;
            case 1054
                seq2(:,a:a+2) = seq(:,LFOT) - seq(:,HEAD); a=a+3;
            case 1055
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,RANK); a=a+3;
            case 1056
                seq2(:,a:a+2) = seq(:,RANK) - seq(:,RKNE); a=a+3;
            case 1057
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,RHIP); a=a+3;
            case 1058
                seq2(:,a:a+2) = seq(:,RHIP) - seq(:,HIP); a=a+3;
            case 1059
                seq2(:,a:a+2) = seq(:,LFOT) - seq(:,LANK); a=a+3;
            case 1060
                seq2(:,a:a+2) = seq(:,LANK) - seq(:,LKNE); a=a+3;
            case 1061
                seq2(:,a:a+2) = seq(:,LKNE) - seq(:,LHIP); a=a+3;
            case 1062
                seq2(:,a:a+2) = seq(:,LHIP) - seq(:,HIP); a=a+3;
            case 1063
                seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RHND); a=a+3;
            case 1064
                seq2(:,a:a+2) = seq(:,RTHM) - seq(:,RHND); a=a+3;
            case 1065
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RWST); a=a+3;
            case 1066
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3;
            case 1067
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 1068
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,SHO); a=a+3;
            case 1069
                seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LHND); a=a+3;
            case 1070
                seq2(:,a:a+2) = seq(:,LTHM) - seq(:,LHND); a=a+3;
            case 1071
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LWST); a=a+3;
            case 1072
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3;
            case 1073
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 1074
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,SHO); a=a+3;
            case 1075
                seq2(:,a:a+2) = seq(:,HIP) - seq(:,SPIN); a=a+3;
            case 1076
                seq2(:,a:a+2) = seq(:,SPIN) - seq(:,SHO); a=a+3;
            case 1077
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,NECK); a=a+3;
            case 1078
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,HEAD); a=a+3;
            case 1079
                seq2(:,a:a+2) = seq(:,RTIP) - seq(:,LTIP); a=a+3;
            case 1080
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
            case 1081
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;  
            case 1082
                seq2(:,a:a+2) = seq(:,RKNE) - seq(:,LKNE); a=a+3;
            case 1083
                seq2(:,a:a+2) = seq(:,RANK) - seq(:,LANK); a=a+3;
            case 1084
                seq2(:,a:a+2) = seq(:,RFOT) - seq(:,LFOT); a=a+3;
            case 1085
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LELB); a=a+3;
            case 1086
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
            case 1087
                seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RANK); a=a+3;
            case 1088
                seq2(:,a:a+2) = seq(:,RTIP) - seq(:,RFOT); a=a+3;
            case 1089
                seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LANK); a=a+3;
            case 1090
                seq2(:,a:a+2) = seq(:,LTIP) - seq(:,LFOT); a=a+3;


        end
    end
end