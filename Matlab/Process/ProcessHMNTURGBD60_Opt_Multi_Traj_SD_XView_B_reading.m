% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMNTURGBD60_Opt_Multi_Traj_SD_XView_B_reading';
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
featureSetNum = 50;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
distMeasCurr = [1 0 0 0];
% distMeasCurr = [1 1 0 0];
% seqNormalSetCurr = [0 0 0 0 0 0; 1 0 0 0 0 0; 1 0 1 0 0 0; 0 1 0 0 0 0; 0 1 1 0 0 0; 0 1 0 1 0 0];
seqNormalSetCurr = [1 0 1 0 0 0];
numTestCurr = -1;
trainSubCurr = [2 3];
testSubCurr = [1];
trainSampleCurr = 200;
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
featureSetClass = [32 60 52 24];
testSetClass = [32 60 52 24];
trainSetClass = [32 60 52 24];
testSetList = [];

doIterNumJtsIncl = 1;
iterNumJtsIncl = 3;
doSVMFlg = 1;

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

parfor i=1:1000 % do this to startup the parallel pool
	a=0;
end

% load the dataset
timeLoad = 0; tLoad = tic;
LoadModelDataset;
timeLoad = timeLoad + toc(tLoad);
disp(['Data Load Time (sec): ',num2str(timeLoad)]);

% change Subject to Xview
NTUSubjectToXview;

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

