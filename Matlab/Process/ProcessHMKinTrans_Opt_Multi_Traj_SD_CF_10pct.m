% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMKinTrans_Opt_Multi_Traj_SD_CF_10pct';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

datasetType = 1; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 2; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
doTrainSplit = 1;
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
numTrainCurr = 0.10;
distMeasCurr = [0 0 1 0];
% distMeasCurr = [1 1 0 1];
% seqNormalSetCurr = [0 0 0 0 0; 1 0 0 0 0; 1 1 0 0 0; 1 1 1 0 0; 1 1 1 1 0; 1 1 1 1 1; 1 0 0 0 1];
seqNormalSetCurr = [0 0 0 0 0];
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

groupClassesFlg = 0; 
subsetClassesFlg = 0;
groupClassesList = {[]}; 
subsetClassesList = [];
featureSetClass = [];
testSetClass = [];
trainSetClass = [];
testSetList = [];

doIterNumJtsIncl = 1;
% iterNumJtsIncl = 3;
% doSVMFlg = 1;
% doDMmMin = 15;

aggFlg = 1;
totBodyJts = 11;  % 10 relative, 1 absolute
mapCanonJts =  [1001 11; 1002 11; 1003 11; 1004 11; 1005 11; 1006 11; 1007 11; 1008 11; 1009 11; 1010 11;...
                1011  1; 1012  2; 1013  3; 1014  4; 1015  5; 1016  6; 1017  7; 1018  8; 1019  9; 1020 10; ...
                1021  1; 1022  2; 1023  3; 1024  4; 1025  5; 1026  6; 1027  7; 1028  8; 1029  9; 1030 10; ...
                1031  1; 1032  2; 1033  3; 1034  4; 1035  5; 1036  6; 1037  7; 1038  8; 1039  9; 1040 10; ...
                1041  1; 1042  2; 1043  3; 1044  4; 1045  5; 1046  6; 1047  7; 1048  8; 1049  9; 1050 10; ...
                1051  1; 1052  2; 1053  3; 1054  4; 1055  5; 1056  6; 1057  7; 1058  8; 1059  9; 1060 10; ...
                1061  1; 1062  2; 1063  3; 1064  4; 1065  5; 1066  6; 1067  7; 1068  8; 1069  9; 1070 10; ...
                1071  1; 1072  2; 1073  3; 1074  4; 1075  5; 1076  6; 1077  7; 1078  8; 1079  9; 1080 10; ...
                1081  1; 1082  2; 1083  3; 1084  4; 1085  5; 1086  6; 1087  7; 1088  8; 1089  9; 1090 10; ...
                1091  1; 1092  2; 1093  3; 1094  4; 1095  5; 1096  6; 1097  7; 1098  8; 1099  9; 1100 10; ...
                1101  1; 1102  2; 1103  3; 1104  4; 1105  5; 1106  6; 1107  7; 1108  8; 1109  9; 1110 10];

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

