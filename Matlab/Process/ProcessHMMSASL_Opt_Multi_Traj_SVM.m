% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMMSASL_Opt_Multi_Traj_SVM';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

batchFlg = 1;
datasetType = 7; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 2; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
doTrainSplit = 1;
reachPctCurr = 0;
acc_iter_def = [1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 ...
                     1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 ...
                1025      1027 1028 1029 1030 1031 1032 1033 1034 1035 1036 ...
                1037 1038 1039 1040      1042 1043 1044 1045 1046 1047 1048 ...
                1049 1050 1051 1052 1053 1054 1055      1057 1058 1059 1060 ...
                1061 1062      1064 1065 1066 1067 1068 1069 1070 1071 1072 ...
                1073 1074 1075 1076 1077      1079 1080 1081 1082 1083 1084 ...
                1085 1086 1087      1089 1090 1091 1092 1093 1094 1095 1096 ...
                1097 1098 1099 1100 1101 1102      1104 1105 1106 1107 1108]; % accuracy iteration traj def id's
numPredictor = 0;
numLearner = 100;
featureSetNum = 5;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
distMeasCurr = [1 0 0 0];
% distMeasCurr = [1 1 0 0];
% seqNormalSetCurr = [0 0 0 0; 1 0 0 0; 0 1 0 0; 1 0 1 0; 0 1 1 0; 1 0 1 1; 0 1 1 1];
seqNormalSetCurr = [0 1 1 1];
numTestCurr = -1;
trainSubCurr = [1];
testSubCurr = [2];
trainSampleCurr = 10;
testSampleCurr = 0;
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
doSVMFlg = 1;
% doDMmMin = 15;

aggFlg = 1;
totBodyJts = 9; 
mapCanonJts =  [1001 1; 1002 1; 1003 1; 1004 1; 1005 1; 1006 1; 1007 1; 1008 1; 1009 1; 1010 1; 1011 1; 1012 1; ...
                        1014 2; 1015 2; 1016 2; 1017 2; 1018 2; 1019 2; 1020 2; 1021 2; 1022 2; 1023 2; 1024 2; ...
                1025 3;         1027 3; 1028 3; 1029 3; 1030 3; 1031 3; 1032 3; 1033 3; 1034 3; 1035 3; 1036 3; ...
                1037 4; 1038 4; 1039 4; 1040 4;         1042 4; 1043 4; 1044 4; 1045 4; 1046 4; 1047 4; 1048 4; ...
                1049 5; 1050 5; 1051 5; 1052 5; 1053 5; 1054 5; 1055 5;         1057 5; 1058 5; 1059 5; 1060 5; ...
                1061 6; 1062 6;         1064 6; 1065 6; 1066 6; 1067 6; 1068 6; 1069 6; 1070 6; 1071 6; 1072 6; ...
                1073 7; 1074 7; 1075 7; 1076 7; 1077 7;         1079 7; 1080 7; 1081 7; 1082 7; 1083 7; 1084 7; ...
                1085 8; 1086 8; 1087 8;         1089 8; 1090 8; 1091 8; 1092 8; 1093 8; 1094 8; 1095 8; 1096 8; ...
                1097 9; 1098 9; 1099 9; 1100 9; 1101 9; 1102 9;         1104 9; 1105 9; 1106 9; 1107 9; 1108 9];

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

% change Subject to Xview
MSASLSubjectToXview;

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

