function ComputeLMSeqOverride()

    global CompMoveData overrideLM
    
    % The following code below can be replaced with generic clustering code
    % to determine seq to omit, seq to choose frames, and how far
    % forward/back to look for each cut.  However, in the interest of time
    % some simple overrides are used instead.
    
    lowVaryPct = 0.30;
    highVaryPct = 0.40;
    lastFramePct = 0.05;
    overrideLM = [];
    
    for i = 1:size(CompMoveData,1)
        seq = cell2mat(CompMoveData(i,4));
        overrideLM(i,:) = [1 1 size(seq,1) lowVaryPct highVaryPct lastFramePct];
    end
    
    % now do overrides
    
    % omit seq
    overrideLM(1,1) = [0];
    overrideLM(2,1) = [0];
    overrideLM(3,1) = [0];
    overrideLM(1481,1) = [0];
    overrideLM(1485,1) = [0];
    overrideLM(1496,1) = [0];
    
    % choose frames for seq
    overrideLM(25,2:5) = [380 763 0.3 0.15];
    overrideLM(107,2:5) = [53 907 0.1 0.1];
    overrideLM(277,2:5) = [214 888 0.3 0.10];
    overrideLM(460,2:5) = [47 835 0.1 0.1];
    overrideLM(473,2:5) = [72 1027 0.05 0.2];
    overrideLM(665,2:5) = [45 972 0.3 0.4];
    overrideLM(1035,2:5) = [108 874 0.2 0.2];
    overrideLM(1044,2:5) = [261 987 0.15 0.25];
    overrideLM(1141,2:5) = [38 399 0.1 0.15];
    overrideLM(1261,2:5) = [1 510 0.2 0.2];
    overrideLM(1469,2:5) = [1 870 0.2 0.4];
    overrideLM(1470,2:5) = [75 953 0.1 0.2];
    overrideLM(1482,2:5) = [430 983 0.1 0.2];
    overrideLM(1493,2:5) = [44 786 0.1 0.1];
    overrideLM(1495,2:5) = [38 988 0.2 0.2];
    
    % change how far in reverse and forward to search for min cut
    overrideLM(11,4:5) = [0.1 0.3];
    overrideLM(71,4:5) = [0.1 0.3];
    overrideLM(72,4:5) = [0.1 0.3];
    overrideLM(94,4:5) = [0.5 0.3];
    overrideLM(98,4:5) = [0.3 0.15];
    overrideLM(119,4:5) = [0.3 0.0];
    overrideLM(141,4:5) = [0.1 0.20];
    overrideLM(214,4:5) = [0.0 0.20];
    overrideLM(227,4:5) = [0.2 0.10];
    overrideLM(232,4:5) = [0.3 0.30];
    overrideLM(244,4:5) = [0.3 0.10];
    overrideLM(251,4:5) = [0.3 0.20];
    overrideLM(255,4:5) = [0.3 0.20];
    overrideLM(258,4:5) = [0.3 0.20];
    overrideLM(335,4:5) = [0.3 0.20];
    overrideLM(377,4:5) = [0.3 0.20];
    overrideLM(383,4:5) = [0.1 0.20];
    overrideLM(389,4:5) = [0.3 0.10];
    overrideLM(413,4:5) = [0.15 0.10];
    overrideLM(442,4:5) = [0.0 0.10];
    overrideLM(465,4:5) = [0.15 0.35];
    overrideLM(469,4:5) = [0.2 0.4];
    overrideLM(508,4:5) = [0.3 0.2];
    overrideLM(521,4:5) = [0.3 0.2];
    overrideLM(550,4:5) = [0.1 0.4];
    overrideLM(594,4:5) = [0.3 0.45];
    overrideLM(642,4:5) = [0.1 0.4];
    overrideLM(644,4:5) = [0.3 0.2];
    overrideLM(662,4:5) = [0.3 0.2];
    overrideLM(668,4:5) = [0.35 0.2];
    overrideLM(672,4:5) = [0.10 0.4];
    overrideLM(712,4:5) = [0.30 0.3];
    overrideLM(713,4:5) = [0.40 0.2];
    overrideLM(714,4:5) = [0.06 0.3];
    overrideLM(723,4:5) = [0.1 0.50];
    overrideLM(777,4:5) = [0.35 0.40];
    overrideLM(778,4:5) = [0.1 0.40];
    overrideLM(779,4:5) = [0.1 0.40];
    overrideLM(780,4:5) = [0.3 0.35];
    overrideLM(782,4:5) = [0.20 0.2];
    overrideLM(787,4:5) = [0.30 0.2];
    overrideLM(789,4:5) = [0.30 0.2];
    overrideLM(796,4:5) = [0.20 0.4];
    overrideLM(799,4:5) = [0.30 0.2];
    overrideLM(808,4:5) = [0.0 0.15];
    overrideLM(811,4:5) = [0.2 0.3];
    overrideLM(818,4:5) = [0.05 0.3];
    overrideLM(822,4:5) = [0.05 0.3];
    overrideLM(824,4:5) = [0.1 0.2];
    overrideLM(829,4:5) = [0.1 0.2];
    overrideLM(844,4:5) = [0.1 0.2];
    overrideLM(852,4:5) = [0.2 0.75];
    overrideLM(867,4:5) = [0.05 0.3];
    overrideLM(870,4:5) = [0.05 0.3];
    overrideLM(871,4:5) = [0.10 0.3];
    overrideLM(883,4:5) = [0.10 0.3];
    overrideLM(890,4:5) = [0.10 0.3];
    overrideLM(896,4:5) = [0.20 0.5];
    overrideLM(891,4:5) = [0.10 0.3];
    overrideLM(901,4:5) = [0.10 0.3];
    overrideLM(907,4:5) = [0.20 0.4];
    overrideLM(916,4:5) = [0.10 0.3];
    overrideLM(925,4:5) = [0.10 0.3];
    overrideLM(927,4:5) = [0.10 0.15];
    overrideLM(933,4:5) = [0.10 0.15];
    overrideLM(934,4:5) = [0.10 0.3];
    overrideLM(935,4:5) = [0.10 0.3];
    overrideLM(937,4:5) = [0.15 0.2];
    overrideLM(943,4:5) = [0.15 0.2];
    overrideLM(945,4:5) = [0.15 0.3];
    overrideLM(947,4:5) = [0.55 0.45];
    overrideLM(952,4:5) = [0.05 0.40];
    overrideLM(955,4:5) = [0.05 0.40];
    overrideLM(958,4:5) = [0.15 0.20];
    overrideLM(965,4:5) = [0.15 0.20];
    overrideLM(967,4:5) = [0.15 0.20];
    overrideLM(970,4:5) = [0.15 0.20];
    overrideLM(972,4:5) = [0.2 0.20];
    overrideLM(975,4:5) = [0.2 0.20];
    overrideLM(979,4:5) = [0.1 0.20];
    overrideLM(983,4:5) = [0.1 0.35];
    overrideLM(996,4:5) = [0.1 0.35];
    overrideLM(998,4:5) = [0.1 0.35];
    overrideLM(1003,4:5) = [0.1 0.35];
    overrideLM(1008,4:5) = [0.1 0.35];
    overrideLM(1013,4:5) = [0.3 0.3];
    overrideLM(1014,4:5) = [0.3 0.2];
    overrideLM(1015,4:5) = [0.3 0.2];
    overrideLM(1020,4:5) = [0.2 0.2];
    overrideLM(1026,4:5) = [0.2 0.2];
    overrideLM(1028,4:5) = [0.2 0.2];
    overrideLM(1029,4:5) = [0.2 0.2];
    overrideLM(1032,4:5) = [0.2 0.2];
    overrideLM(1036,4:5) = [0.2 0.1];
    overrideLM(1037,4:5) = [0.25 0.3];
    overrideLM(1039,4:5) = [0.25 0.2];
    overrideLM(1044,4:5) = [0.25 0.5];
    overrideLM(1045,4:5) = [0.25 0.2];
    overrideLM(1053,4:5) = [0.1 0.2];
    overrideLM(1056,4:5) = [0.1 0.3];
    overrideLM(1066,4:5) = [0.2 0.3];
    overrideLM(1067,4:5) = [0.2 0.2];
    overrideLM(1072,4:5) = [0.2 0.2];
    overrideLM(1073,4:5) = [0.1 0.3];
    overrideLM(1074,4:5) = [0.1 0.4];
    overrideLM(1076,4:5) = [0.1 0.4];
    overrideLM(1083,4:5) = [0.1 0.4];
    overrideLM(1089,4:5) = [0.1 0.4];
    overrideLM(1091,4:5) = [0.1 0.4];
    overrideLM(1096,4:5) = [0.1 0.1];
    overrideLM(1098,4:5) = [0.1 0.3];
    overrideLM(1100,4:5) = [0.1 0.5];
    overrideLM(1102,4:5) = [0.1 0.4];
    overrideLM(1107,4:5) = [0.1 0.2];
    overrideLM(1109,4:5) = [0.1 0.2];
    overrideLM(1110,4:5) = [0.1 0.2];
    overrideLM(1115,4:5) = [0.1 0.2];
    overrideLM(1117,4:5) = [0.2 0.15];
    overrideLM(1118,4:5) = [0.2 0.15];
    overrideLM(1119,4:5) = [0.1 0.15];
    overrideLM(1125,4:5) = [0.1 0.15];
    overrideLM(1126,4:5) = [0.1 0.15];
    overrideLM(1127,4:5) = [0.1 0.25];
    overrideLM(1128,4:5) = [0.1 0.4];
    overrideLM(1135,4:5) = [0.1 0.2];
    overrideLM(1137,4:5) = [0.1 0.2];
    overrideLM(1140,4:5) = [0.1 0.4];
    overrideLM(1142,4:5) = [0.1 0.5];
    overrideLM(1156,4:5) = [0.1 0.55];
    overrideLM(1164,4:5) = [0.1 0.3];
    overrideLM(1166,4:5) = [0.1 0.4];
    overrideLM(1169,4:5) = [0.2 0.4];
    overrideLM(1175,4:5) = [0.1 0.4];
    overrideLM(1179,4:5) = [0.1 0.2];
    overrideLM(1180,4:5) = [0.0 0.4];
    overrideLM(1182,4:5) = [0.1 0.4];
    overrideLM(1197,4:5) = [0.1 0.2];
    overrideLM(1198,4:5) = [0.1 0.3];
    overrideLM(1199,4:5) = [0.1 0.35];
    overrideLM(1203,4:5) = [0.1 0.2];
    overrideLM(1205,4:5) = [0.1 0.2];
    overrideLM(1206,4:5) = [0.0 1.1];
    overrideLM(1207,4:5) = [0.1 0.3];
    overrideLM(1209,4:5) = [0.1 0.3];
    overrideLM(1211,4:5) = [0.1 0.1];
    overrideLM(1215,4:5) = [0.1 0.3];
    overrideLM(1220,4:5) = [0.0 0.3];
    overrideLM(1222,4:5) = [0.0 0.3];
    overrideLM(1223,4:5) = [0.2 0.2];
    overrideLM(1231,4:5) = [0.2 0.2];
    overrideLM(1234,4:5) = [0.2 0.2];
    overrideLM(1236,4:5) = [0.1 0.5];
    overrideLM(1252,4:5) = [0.1 0.3];
    overrideLM(1262,4:5) = [0.1 0.4];
    overrideLM(1265,4:5) = [0.1 0.4];
    overrideLM(1269,4:5) = [0.1 0.4];
    overrideLM(1270,4:5) = [0.1 0.4];
    overrideLM(1287,4:5) = [0.3 0.3];
    overrideLM(1319,4:5) = [0.0 0.3];
    overrideLM(1322,4:5) = [0.2 0.2];
    overrideLM(1341,4:5) = [0.1 0.2];
    overrideLM(1345,4:5) = [0.1 0.1];
    overrideLM(1346,4:5) = [0.25 0.1];
    overrideLM(1363,4:5) = [0.25 0.2];
    overrideLM(1385,4:5) = [0.2 0.2];
    overrideLM(1387,4:5) = [0.0 0.1];
    overrideLM(1388,4:5) = [0.1 0.3];
    overrideLM(1409,4:5) = [0.1 0.3];
    overrideLM(1419,4:5) = [0.0 0.3];
    overrideLM(1420,4:5) = [0.0 0.3];
    overrideLM(1421,4:5) = [0.0 0.1];
    overrideLM(1422,4:5) = [0.0 0.2];
    overrideLM(1454,4:5) = [0.2 0.4];
    overrideLM(1471,4:5) = [0.0 0.5];
    overrideLM(1479,4:5) = [0.01 0.3];
    overrideLM(1484,4:5) = [0.3 0.3];
    overrideLM(1488,4:5) = [0.3 0.3];
    overrideLM(1492,4:5) = [0.3 0.1];
    overrideLM(1497,4:5) = [0.1 0.05];

end