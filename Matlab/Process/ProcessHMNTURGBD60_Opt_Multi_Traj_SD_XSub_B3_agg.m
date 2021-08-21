% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMNTURGBD60_Opt_Multi_Traj_SD_XSub_B3_agg';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

batchFlg = 1;
datasetType = 6; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 2; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
doTrainSplit = 1;
reachPctCurr = 0;
acc_iter_def = [1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 ...
                1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 ...
                1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 ...
                1031 1032 1033 1034 1035 1036 1037 1038 1039 1040 ...
                1041 1042 1043 1044 1045 1046 1047 1048 1049 1050 ...
                1051 1052 1053 1054 1055 1056 1057 1058 1059 1060 ...
                1061 1062 1063 1064 1065 1066 1067 1068 1069 1070 ...
                1071 1072 1073 1074 1075 1076 1077 1078 1079 1080 ...
                1081 1082 1083 1084 1085 1086 1087 1088 1089 1090]; % accuracy iteration traj def id's
numPredictor = 0;
numLearner = 100;
featureSetNum = 1;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
distMeasCurr = [1 0 0 0];
% distMeasCurr = [1 1 0 0];
% seqNormalSetCurr = [0 0 0 0 0 0; 1 0 0 0 0 0; 1 0 1 0 0 0; 0 1 0 0 0 0; 0 1 1 0 0 0; 0 1 0 1 0 0];
seqNormalSetCurr = [1 0 1 0 0 0];
numTestCurr = -1;
trainSubCurr = [1 2 4 5 8 9 13 14 15 16 17 18 19 25 27 28 31 34 35 38];
testSubCurr = [3 6 7 10 11 12 20 21 22 23 24 26 29 30 32 33 36 37 39 40];
trainSampleCurr = 2;
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
iterNumJtsIncl = 3;
doSVMFlg = 1;
doDMmMin = 15;

aggFlg = 1;
totBodyJts = 26;  % 25 relative, 1 absolute
mapCanonJts =  [1001 26; 1002 26; 1003 26; 1004 26; 1005 26; 1006 26; 1007 26; 1008 26; 1009 26; 1010 26;...
                1011 26; 1012 26; 1013 26; 1014 26; 1015 26; 1016 26; 1017 26; 1018 26; 1019 26; 1020 26; ...
                1021 26; 1022 26; 1023 26; 1024 26; 1025 26; 1026 1; 1027 1; 1028 1; 1029 1; 1030 1; ...
                1031 1; 1032 1; 1033 1; 1034 1; 1035 1; 1036 1; 1037 1; 1038 1; 1039 1; 1040 1; ...
                1041 4; 1042 4; 1043 4; 1044 4; 1045 4; 1046 4; 1047 4; 1048 4; 1049 4; 1050 4; ...
                1051 4; 1052 4; 1053 4; 1054 4; 1055 19; 1056 18; 1057 17; 1058 1; 1059 15; 1060 14; ...
                1061 13; 1062 1; 1063 12; 1064 12; 1065 11; 1066 10; 1067 9; 1068 21; 1069 8; 1070 8; ...
                1071 7; 1072 6; 1073 5; 1074 21; 1075 2; 1076 21; 1077 3; 1078 4; 1079 22; 1080 8; ...
                1081 6; 1082 14; 1083 15; 1084 16; 1085 6; 1086 10; 1087 19; 1088 20; 1089 15; 1090 16];
            
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

