function seq2 = KinTransExtractFeatures2(seq,def)

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
    
    seq2 = [];
    a = 1;
    
    for i = 1:size(def,2)
        switch def(i)
            case 1 
                seq2(:,a:a+2) = seq(:,TORS); a=a+3;
            case 2
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
            case 3
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
            case 4
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 5
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
            case 6
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 7
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
            case 8
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 9
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
            case 10
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 11
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
            case 12
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
            case 13
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 14
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
            case 15
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
            case 16
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
            case 17
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 18
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
            case 19
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;
            case 20
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
            case 21
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
            case 22
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
            case 23
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
            case 24
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
                
            case 101
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 102
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 103
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,TORS); a=a+3;
            case 104
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 105
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 106
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
            case 107
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
            case 108
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
 
            case 401
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 402
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 403
                seq2(:,a:a+2) = seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
            case 404
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
            case 405
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
            case 406
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHND); a=a+3;
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,LHND); a=a+3;
            case 407
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
            case 408
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
            case 409
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
            case 410
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,TORS); a=a+3;
            case 411
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,TORS); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;
            case 412
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;
            case 413
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,NECK); a=a+3;
            case 414
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,NECK); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,NECK); a=a+3;
            case 415
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
            case 416
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
            case 417
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
            case 418
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
            case 419
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
            case 420
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
            case 421
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,RSHO); a=a+3;
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,RSHO); a=a+3;
                
            case 1001
                seq2(:,a:a+2) = seq(:,TORS); a=a+3;
            case 1002
                seq2(:,a:a+2) = seq(:,NECK); a=a+3;
            case 1003
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
            case 1004
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 1005
                seq2(:,a:a+2) = seq(:,LWST); a=a+3;
            case 1006
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 1007
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
            case 1008
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 1009
                seq2(:,a:a+2) = seq(:,RWST); a=a+3;
            case 1010
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 1011
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,TORS); a=a+3;  
            case 1012
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,NECK); a=a+3;
            case 1013
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,LSHO); a=a+3;
            case 1014
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,LELB); a=a+3;
            case 1015
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,LWST); a=a+3;
            case 1016
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,LHND); a=a+3;
            case 1017
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,RSHO); a=a+3;
            case 1018
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,RELB); a=a+3;
            case 1019
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,RWST); a=a+3;
            case 1020
                seq2(:,a:a+2) = seq(:,TORS) - seq(:,RHND); a=a+3;
            case 1021
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,TORS); a=a+3;  
            case 1022
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,NECK); a=a+3;
            case 1023
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,LSHO); a=a+3;
            case 1024
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,LELB); a=a+3;
            case 1025
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,LWST); a=a+3;
            case 1026
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,LHND); a=a+3;
            case 1027
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,RSHO); a=a+3;
            case 1028
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,RELB); a=a+3;
            case 1029
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,RWST); a=a+3;
            case 1030
                seq2(:,a:a+2) = seq(:,NECK) - seq(:,RHND); a=a+3;
            case 1031
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,TORS); a=a+3;  
            case 1032
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,NECK); a=a+3;
            case 1033
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LSHO); a=a+3;
            case 1034
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
            case 1035
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LWST); a=a+3;
            case 1036
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
            case 1037
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
            case 1038
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RELB); a=a+3;
            case 1039
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RWST); a=a+3;
            case 1040
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
            case 1041
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,TORS); a=a+3;  
            case 1042
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,NECK); a=a+3;
            case 1043
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 1044
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LELB); a=a+3;
            case 1045
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LWST); a=a+3;
            case 1046
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
            case 1047
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
            case 1048
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
            case 1049
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RWST); a=a+3;
            case 1050
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
            case 1051
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,TORS); a=a+3;  
            case 1052
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,NECK); a=a+3;
            case 1053
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LSHO); a=a+3;
            case 1054
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LELB); a=a+3;
            case 1055
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LWST); a=a+3;
            case 1056
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,LHND); a=a+3;
            case 1057
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RSHO); a=a+3;
            case 1058
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RELB); a=a+3;
            case 1059
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RWST); a=a+3;
            case 1060
                seq2(:,a:a+2) = seq(:,LWST) - seq(:,RHND); a=a+3;
            case 1061
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,TORS); a=a+3;  
            case 1062
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,NECK); a=a+3;
            case 1063
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
            case 1064
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
            case 1065
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LWST); a=a+3;
            case 1066
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LHND); a=a+3;
            case 1067
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
            case 1068
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
            case 1069
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RWST); a=a+3;
            case 1070
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
            case 1071
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,TORS); a=a+3;  
            case 1072
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,NECK); a=a+3;
            case 1073
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LSHO); a=a+3;
            case 1074
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LELB); a=a+3;
            case 1075
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LWST); a=a+3;
            case 1076
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LHND); a=a+3;
            case 1077
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RSHO); a=a+3;
            case 1078
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RELB); a=a+3;
            case 1079
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RWST); a=a+3;
            case 1080
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
            case 1081
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,TORS); a=a+3;  
            case 1082
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,NECK); a=a+3;
            case 1083
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LSHO); a=a+3;
            case 1084
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;
            case 1085
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LWST); a=a+3;
            case 1086
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LHND); a=a+3;
            case 1087
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 1088
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RELB); a=a+3;
            case 1089
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RWST); a=a+3;
            case 1090
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
            case 1091
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,TORS); a=a+3;  
            case 1092
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,NECK); a=a+3;
            case 1093
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LSHO); a=a+3;
            case 1094
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LELB); a=a+3;
            case 1095
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LWST); a=a+3;
            case 1096
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,LHND); a=a+3;
            case 1097
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RSHO); a=a+3;
            case 1098
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RELB); a=a+3;
            case 1099
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RWST); a=a+3;
            case 1100
                seq2(:,a:a+2) = seq(:,RWST) - seq(:,RHND); a=a+3;
            case 1101
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,TORS); a=a+3;  
            case 1102
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,NECK); a=a+3;
            case 1103
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
            case 1104
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LELB); a=a+3;
            case 1105
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LWST); a=a+3;
            case 1106
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
            case 1107
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
            case 1108
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
            case 1109
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RWST); a=a+3;
            case 1110
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RHND); a=a+3;
        end
    end
end