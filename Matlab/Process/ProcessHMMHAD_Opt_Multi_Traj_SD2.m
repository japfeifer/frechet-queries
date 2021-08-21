% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMMHAD_Opt_Multi_Traj_SD2';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

datasetType = 2; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 2; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
doTrainSplit = 1;
acc_iter_def = [1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 1015 ...
                     1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 ...
                1041      1043 1044 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 1055 ...
                1061 1062      1064 1065 1066 1067 1068 1069 1070 1071 1072 1073 1074 1075 ...
                1081 1082 1083      1085 1086 1087 1088 1089 1090 1091 1092 1093 1094 1095 ...
                1101 1102 1103 1104      1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 ...
                1121 1122 1123 1124 1125      1127 1128 1129 1130 1131 1132 1133 1134 1135 ...
                1141 1142 1143 1144 1145 1146      1148 1149 1150 1151 1152 1153 1154 1155 ...
                1161 1162 1163 1164 1165 1166 1167      1169 1170 1171 1172 1173 1174 1175 ...
                1181 1182 1183 1184 1185 1186 1187 1188      1190 1191 1192 1193 1194 1195 ...
                1201 1202 1203 1204 1205 1206 1207 1208 1209      1211 1212 1213 1214 1215 ...
                1221 1222 1223 1224 1225 1226 1227 1228 1229 1230      1232 1233 1234 1235 ...
                1241 1242 1243 1244 1245 1246 1247 1248 1249 1250 1251      1253 1254 1255 ...
                1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 1271 1272      1274 1275 ...
                1281 1282 1283 1284 1285 1286 1287 1288 1289 1290 1291 1292 1293      1295 ...
                1301 1302 1303 1304 1305 1306 1307 1308 1309 1310 1311 1312 1313 1314     ]; % accuracy iteration traj def id's
numPredictor = 0;
numLearner = 100;
featureSetNum = 0;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
distMeasCurr = [1 0 0 0];
% distMeasCurr = [1 1 0 1];
% seqNormalSetCurr = [0 0 0 0 0; 1 0 0 0 0; 1 0 0 0 1; 1 1 0 0 0; 1 1 1 0 0; 1 1 1 1 0; 1 1 1 1 1; 1 0 0 0 1];
seqNormalSetCurr = [1 0 0 0 0];
numTestCurr = -1;
trainSubCurr = [1 2 3 4 5 6 7];
testSubCurr = [8 9 10 11 12];
trainSampleCurr = 1;
testSampleCurr = 0;
edrTol = 0.15;  % edit distance tolerance
% these variables should never be changed for this type of experiment
implicitErrorFlg = 0;
ConstructCCTType = 1;
trainMethodCurr = 1;
bestTrainRepFlgCurr = 0;
swapKFoldCurr = 0;

doIterNumJtsIncl = 1;
% iterNumJtsIncl = 3;
% doSVMFlg = 1;
% doDMmMin = 15;

aggFlg = 1;
totBodyJts = 16;  % 15 relative, 1 absolute
mapCanonJts =  [1001 16; 1002 16; 1003 16; 1004 16; 1005 16; 1006 16; 1007 16; 1008 16; 1009 16; 1010 16; 1011 16; 1012 16; 1013 16; 1014 16; 1015 16; ...
                1021  1; 1022  2; 1023  3; 1024  4; 1025  5; 1026  6; 1027  7; 1028  8; 1029  9; 1030 10; 1031 11; 1032 12; 1033 13; 1034 14; 1035 15; ...
                1041  1; 1042  2; 1043  3; 1044  4; 1045  5; 1046  6; 1047  7; 1048  8; 1049  9; 1050 10; 1051 11; 1052 12; 1053 13; 1054 14; 1055 15; ...
                1061  1; 1062  2; 1063  3; 1064  4; 1065  5; 1066  6; 1067  7; 1068  8; 1069  9; 1070 10; 1071 11; 1072 12; 1073 13; 1074 14; 1075 15; ...
                1081  1; 1082  2; 1083  3; 1084  4; 1085  5; 1086  6; 1087  7; 1088  8; 1089  9; 1090 10; 1091 11; 1092 12; 1093 13; 1094 14; 1095 15; ...
                1101  1; 1102  2; 1103  3; 1104  4; 1105  5; 1106  6; 1107  7; 1108  8; 1109  9; 1110 10; 1111 11; 1112 12; 1113 13; 1114 14; 1115 15; ...
                1121  1; 1122  2; 1123  3; 1124  4; 1125  5; 1126  6; 1127  7; 1128  8; 1129  9; 1130 10; 1131 11; 1132 12; 1133 13; 1134 14; 1135 15; ...
                1141  1; 1142  2; 1143  3; 1144  4; 1145  5; 1146  6; 1147  7; 1148  8; 1149  9; 1150 10; 1151 11; 1152 12; 1153 13; 1154 14; 1155 15; ...
                1161  1; 1162  2; 1163  3; 1164  4; 1165  5; 1166  6; 1167  7; 1168  8; 1169  9; 1170 10; 1171 11; 1172 12; 1173 13; 1174 14; 1175 15; ...
                1181  1; 1182  2; 1183  3; 1184  4; 1185  5; 1186  6; 1187  7; 1188  8; 1189  9; 1190 10; 1191 11; 1192 12; 1193 13; 1194 14; 1195 15; ...
                1201  1; 1202  2; 1203  3; 1204  4; 1205  5; 1206  6; 1207  7; 1208  8; 1209  9; 1210 10; 1211 11; 1212 12; 1213 13; 1214 14; 1215 15; ...
                1221  1; 1222  2; 1223  3; 1224  4; 1225  5; 1226  6; 1227  7; 1228  8; 1229  9; 1230 10; 1231 11; 1232 12; 1233 13; 1234 14; 1235 15; ...
                1241  1; 1242  2; 1243  3; 1244  4; 1245  5; 1246  6; 1247  7; 1248  8; 1249  9; 1250 10; 1251 11; 1252 12; 1253 13; 1254 14; 1255 15; ...
                1261  1; 1262  2; 1263  3; 1264  4; 1265  5; 1266  6; 1267  7; 1268  8; 1269  9; 1270 10; 1271 11; 1272 12; 1273 13; 1274 14; 1275 15; ...
                1281  1; 1282  2; 1283  3; 1284  4; 1285  5; 1286  6; 1287  7; 1288  8; 1289  9; 1290 10; 1291 11; 1292 12; 1293 13; 1294 14; 1295 15; ...
                1301  1; 1302  2; 1303  3; 1304  4; 1305  5; 1306  6; 1307  7; 1308  8; 1309  9; 1310 10; 1311 11; 1312 12; 1313 13; 1314 14; 1315 15];

% output variable selections
disp(['datasetType: ',num2str(datasetType)]);
disp(['classifierCurr: ',num2str(classifierCurr)]);
disp(['trajDefTypeCurr: ',num2str(trajDefTypeCurr)]);
disp(['acc_iter_def: ',num2str(acc_iter_def)]);
disp(['numPredictor: ',num2str(numPredictor)]);
disp(['numLearner: ',num2str(numLearner)]);
disp(['featureSetNum: ',num2str(featureSetNum)]);
disp(['normDistCurr: ',num2str(normDistCurr)]);
disp(['kCurr: ',num2str(kCurr)]);
disp(['numTrainCurr: ',num2str(numTrainCurr)]);
disp(['distMeasCurr: ',num2str(distMeasCurr)]);
for i = 1:size(seqNormalSetCurr,1)
    disp(['seqNormalSetCurr: ',num2str(seqNormalSetCurr(i,:))]);
end
disp(['numTestCurr: ',num2str(numTestCurr)]);
disp(['trainSubCurr: ',num2str(trainSubCurr)]);
disp(['testSubCurr: ',num2str(testSubCurr)]);
disp(['trainSampleCurr: ',num2str(trainSampleCurr)]);
disp(['testSampleCurr: ',num2str(testSampleCurr)]);
disp(['edrTol: ',num2str(edrTol)]);
disp(['implicitErrorFlg: ',num2str(implicitErrorFlg)]);
disp(['ConstructCCTType: ',num2str(ConstructCCTType)]);
disp(['trainMethodCurr: ',num2str(trainMethodCurr)]);
disp(['bestTrainRepFlgCurr: ',num2str(bestTrainRepFlgCurr)]);
disp(['swapKFoldCurr: ',num2str(swapKFoldCurr)]);

% load the dataset
timeLoad = 0; tLoad = tic;
LoadModelDataset;
timeLoad = timeLoad + toc(tLoad);
disp(['Data Load Time (sec): ',num2str(timeLoad)]);

trainSampleHMSub = [1 2 3 4 5]; % run for several training samples
iHMSub = 1;  % run for first training sample
rngSeed = 1; % random seed value - set to 1
rng(rngSeed); % reset random seed so experiments are reproducable
trainSampleCurr = trainSampleHMSub(iHMSub);
disp(['-----------------']);
disp(['trainSampleCurr: ',num2str(trainSampleCurr)]);
RunSubModel3;

% output the final results
for i = 1:size(resultList,1)
   disp(['distType: ',num2str(cell2mat(resultList(i,1))), ...
         ' seqNormalCurr: ',num2str(cell2mat(resultList(i,2))), ...
         ' Best Accuracy: ',num2str(cell2mat(resultList(i,3))), ...
         ' Best Definition: ',num2str(cell2mat(resultList(i,4)))]);
end   

save(matFile,'resultList');
diary off;

