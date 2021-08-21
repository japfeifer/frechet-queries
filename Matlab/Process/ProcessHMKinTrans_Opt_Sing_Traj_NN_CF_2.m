% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMKinTrans_Opt_Sing_Traj_NN_CF_2';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

datasetType = 1; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 2;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 1; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
doTrainSplit = 1;
% acc_iter_def = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24]; % accuracy iteration traj def id's
acc_iter_def = [1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 ...
                     1012 1013 1014 1015 1016 1017 1018 1019 1020 ...
                1021      1023 1024 1025 1026 1027 1028 1029 1030 ...
                1031 1032      1034 1035 1036 1037 1038 1039 1040 ...
                1041 1042 1043      1045 1046 1047 1048 1049 1050 ...
                1051 1052 1053 1054      1056 1057 1058 1059 1060 ...
                1061 1062 1063 1064 1065      1067 1068 1069 1070 ...
                1071 1072 1073 1074 1075 1076      1078 1079 1080 ...
                1081 1082 1083 1084 1085 1086 1087      1089 1090 ...
                1091 1092 1093 1094 1095 1096 1097 1098      1100 ...
                1101 1102 1103 1104 1105 1106 1107 1108 1109      ]; % accuracy iteration traj def id's
numPredictor = 0;
numLearner = 100;
featureSetNum = 0;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = 2;
distMeasCurr = [0 0 1 0];
% distMeasCurr = [1 1 0 1];
% seqNormalSetCurr = [0 0 0 0 0; 1 0 0 0 0; 1 1 0 0 0; 1 1 1 0 0; 1 1 1 1 0; 1 1 1 1 1; 1 0 0 0 1];
seqNormalSetCurr = [1 1 1 1 1];
numTestCurr = 0;
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

