function seq2 = MSASLExtractFeatures2(seq,def)

    HEAD  = [1,2,3]; SHO = [4,5,6]; RSHO = [7,8,9]; RELB = [10,11,12];
    RHND = [13,14,15]; LSHO = [16,17,18]; LELB = [19,20,21]; LHND = [22,23,24];
    RHIP = [25,26,27]; RKNE = [28,29,30]; RFOT = [31,32,33]; LHIP = [34,35,36];
    LKNE = [37,38,39]; LFOT = [40,41,42]; RHED = [43,44,45]; LHED = [46,47,48];
    REAR = [49,50,51]; LEAR = [52,53,54]; 
    
    seq2 = [];
    a = 1;
    
    for i = 1:size(def,2)
        switch def(i)
            case 1001
                seq2(:,a:a+2) = seq(:,HEAD); a=a+3;
            case 1002
                seq2(:,a:a+2) = seq(:,SHO); a=a+3;
            case 1003
                seq2(:,a:a+2) = seq(:,RSHO); a=a+3;
            case 1004
                seq2(:,a:a+2) = seq(:,RELB); a=a+3;
            case 1005
                seq2(:,a:a+2) = seq(:,RHND); a=a+3;
            case 1006
                seq2(:,a:a+2) = seq(:,LSHO); a=a+3;
            case 1007
                seq2(:,a:a+2) = seq(:,LELB); a=a+3;
            case 1008
                seq2(:,a:a+2) = seq(:,LHND); a=a+3;
            case 1009
                seq2(:,a:a+2) = seq(:,RHED); a=a+3;
            case 1010
                seq2(:,a:a+2) = seq(:,LHED); a=a+3;
            case 1011
                seq2(:,a:a+2) = seq(:,REAR); a=a+3;
            case 1012
                seq2(:,a:a+2) = seq(:,LEAR); a=a+3;
            
            case 1013
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,HEAD); a=a+3;
            case 1014
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,HEAD); a=a+3;
            case 1015
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,HEAD); a=a+3;
            case 1016
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,HEAD); a=a+3;
            case 1017
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,HEAD); a=a+3;
            case 1018
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,HEAD); a=a+3;
            case 1019
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,HEAD); a=a+3;
            case 1020
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,HEAD); a=a+3;
            case 1021
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,HEAD); a=a+3;
            case 1022
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,HEAD); a=a+3;
            case 1023
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,HEAD); a=a+3;
            case 1024
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,HEAD); a=a+3;
                
            case 1025
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,SHO); a=a+3;
            case 1026
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,SHO); a=a+3;
            case 1027
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,SHO); a=a+3;
            case 1028
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,SHO); a=a+3;
            case 1029
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,SHO); a=a+3;
            case 1030
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,SHO); a=a+3;
            case 1031
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,SHO); a=a+3;
            case 1032
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,SHO); a=a+3;
            case 1033
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,SHO); a=a+3;
            case 1034
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,SHO); a=a+3;
            case 1035
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,SHO); a=a+3;
            case 1036
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,SHO); a=a+3;
                
            case 1037
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RHND); a=a+3;
            case 1038
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,RHND); a=a+3;
            case 1039
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RHND); a=a+3;
            case 1040
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RHND); a=a+3;
            case 1041
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RHND); a=a+3;
            case 1042
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RHND); a=a+3;
            case 1043
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RHND); a=a+3;
            case 1044
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RHND); a=a+3;
            case 1045
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,RHND); a=a+3;
            case 1046
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,RHND); a=a+3;
            case 1047
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,RHND); a=a+3;
            case 1048
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RHND); a=a+3;
                
            case 1049
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LHND); a=a+3;
            case 1050
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,LHND); a=a+3;
            case 1051
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LHND); a=a+3;
            case 1052
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LHND); a=a+3;
            case 1053
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LHND); a=a+3;
            case 1054
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LHND); a=a+3;
            case 1055
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LHND); a=a+3;
            case 1056
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LHND); a=a+3;
            case 1057
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,LHND); a=a+3;
            case 1058
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,LHND); a=a+3;
            case 1059
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,LHND); a=a+3;
            case 1060
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LHND); a=a+3;
                
            case 1061
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RSHO); a=a+3;
            case 1062
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,RSHO); a=a+3;
            case 1063
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RSHO); a=a+3;
            case 1064
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RSHO); a=a+3;
            case 1065
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RSHO); a=a+3;
            case 1066
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RSHO); a=a+3;
            case 1067
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RSHO); a=a+3;
            case 1068
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RSHO); a=a+3;
            case 1069
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,RSHO); a=a+3;
            case 1070
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,RSHO); a=a+3;
            case 1071
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,RSHO); a=a+3;
            case 1072
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RSHO); a=a+3;
                
            case 1073
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LSHO); a=a+3;
            case 1074
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,LSHO); a=a+3;
            case 1075
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LSHO); a=a+3;
            case 1076
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LSHO); a=a+3;
            case 1077
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LSHO); a=a+3;
            case 1078
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LSHO); a=a+3;
            case 1079
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LSHO); a=a+3;
            case 1080
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LSHO); a=a+3;
            case 1081
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,LSHO); a=a+3;  
            case 1082
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,LSHO); a=a+3;
            case 1083
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,LSHO); a=a+3;
            case 1084
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LSHO); a=a+3;
                
            case 1085
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,RELB); a=a+3;
            case 1086
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,RELB); a=a+3;
            case 1087
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,RELB); a=a+3;
            case 1088
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,RELB); a=a+3;
            case 1089
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,RELB); a=a+3;
            case 1090
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,RELB); a=a+3;
            case 1091
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,RELB); a=a+3;
            case 1092
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,RELB); a=a+3;
            case 1093
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,RELB); a=a+3;
            case 1094
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,RELB); a=a+3;
            case 1095
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,RELB); a=a+3;
            case 1096
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,RELB); a=a+3;
                
            case 1097
                seq2(:,a:a+2) = seq(:,HEAD) - seq(:,LELB); a=a+3;
            case 1098
                seq2(:,a:a+2) = seq(:,SHO) - seq(:,LELB); a=a+3;
            case 1099
                seq2(:,a:a+2) = seq(:,RSHO) - seq(:,LELB); a=a+3;
            case 1100
                seq2(:,a:a+2) = seq(:,RELB) - seq(:,LELB); a=a+3;
            case 1101
                seq2(:,a:a+2) = seq(:,RHND) - seq(:,LELB); a=a+3;
            case 1102
                seq2(:,a:a+2) = seq(:,LSHO) - seq(:,LELB); a=a+3;
            case 1103
                seq2(:,a:a+2) = seq(:,LELB) - seq(:,LELB); a=a+3;
            case 1104
                seq2(:,a:a+2) = seq(:,LHND) - seq(:,LELB); a=a+3;
            case 1105
                seq2(:,a:a+2) = seq(:,RHED) - seq(:,LELB); a=a+3;
            case 1106
                seq2(:,a:a+2) = seq(:,LHED) - seq(:,LELB); a=a+3;
            case 1107
                seq2(:,a:a+2) = seq(:,REAR) - seq(:,LELB); a=a+3;
            case 1108
                seq2(:,a:a+2) = seq(:,LEAR) - seq(:,LELB); a=a+3;

        end
    end
end