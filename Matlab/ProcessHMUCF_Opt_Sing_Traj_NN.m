% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMUCF_Opt_Sing_Traj_NN';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

datasetType = 4; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 2;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 1; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
% acc_iter_def = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34]; % accuracy iteration traj def id's
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
% numPredictor = 1000;
numPredictor = 0;
numLearner = 100;
featureSetNum = 0;
normDistCurr = 0;
kCurr = 1;
numTrainCurr = 5;  % numTrainCurr = -2;
distMeasCurr = [1 0 0 0];
% distMeasCurr = [1 1 0 1];
% seqNormalSetCurr = [0 0 0 0 0; 1 0 0 0 0; 1 1 0 0 0; 1 1 1 0 0; 1 1 1 1 0; 1 1 1 1 1; 1 0 0 0 1];
seqNormalSetCurr = [0 0 0 0 0 0];
numTestCurr = 10;   % numTestCurr = 0;
trainSubCurr = [0 1 2 3];
testSubCurr = [20];
trainSampleCurr = 1;
testSampleCurr = 2;
edrTol = 0.15;  % edit distance tolerance
% these variables should never be changed for this type of experiment
implicitErrorFlg = 0;
ConstructCCTType = 1;
trainMethodCurr = 1;
bestTrainRepFlgCurr = 0;
HMNumSets = 4;  % four equal-sized test sets
swapKFoldCurr = 0;

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

rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
CreateQuerySets(HMNumSets);

currHMTrainSet = 1; % just run for the first validation fold
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
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

