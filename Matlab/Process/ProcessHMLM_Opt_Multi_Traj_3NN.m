% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMLM_Opt_Multi_Traj_3NN';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

datasetType = 3; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 2;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 2; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
% acc_iter_def = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73]; % accuracy iteration traj def id's
acc_iter_def = [1001 1002 1003 1004 1005 1006 1007 1008 1009 1010 1011 1012 1013 1014 ...
                1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 ...
                1029 1030 1031 1032 1033 1034 1035 1036 1037 1038 1039 1040 1041 1042 ...
                1043 1044 1045 1046 1047 1048 1049 1050 1051 1052 1053 1054 1055 1056 ...
                1057 1058 1059 1060 1061 1062 1063 1064 1065 1066 1067 1068 1069 1070]; % accuracy iteration traj def id's

numPredictor = 0;
numLearner = 100;
featureSetNum = 0;
normDistCurr = 0;
kCurr = 3;
numTrainCurr = 5;
distMeasCurr = [0 0 1 0];
% distMeasCurr = [1 1 0 1];
% seqNormalSetCurr = [0 0 0 0 0 0; 1 0 0 0 0 0; 1 1 0 0 0 0; 1 1 1 0 0 0; 1 1 1 1 0 0; 1 1 1 1 1 0; 1 1 1 1 1 1; 1 0 0 0 1 0];
seqNormalSetCurr = [1 0 0 0 0 0];
numTestCurr = 10;
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

% iterNumJtsIncl = 1;
% doDMmMin = 10;
mvFactor = 1;

aggFlg = 1;
totBodyJts = 12;  % 11 relative, 1 absolute
% mapCanonJts =  [1 1; 2 1; 3 1; 4 1; 5 1; 6 1; 7 1; 8 1; 9 1; 10 1;...
%                 11 1; 12 1; 13 1; 14 1; 15 1; 16 1; 17 1; 18 1; 19 1; 20 1;...
%                 21 1; 22 1; 23 1; 24 1; 25 1; 26 1; 27 1; 28 1; 29 1; 30 1;...
%                 31 1; 32 1; 33 1; 34 1; 35 1; 36 1; 37 1; 38 1; 39 1; 40 1;...
%                 41 1; 42 1; 43 1; 44 1; 45 1; 46 1; 47 1; 48 1; 49 1; 50 1;...
%                 51 1; 52 1; 53 1; 54 1; 55 2; 56 3; 57 4; 58 5; 59 5; 60 6;...
%                 61 7; 62 8; 63 9; 64 10; 65 11; 66 11; 67 11; 68 11; 69 12; 70 12;...
%                 71 12; 72 12; 73 4];
mapCanonJts =  [1001 1; 1002 1; 1003 1; 1004 1; 1005 1; 1006 1; 1007 1; 1008 1; 1009 1; 1010 1; 1011 1; 1012 1; 1013 1; 1014 1; ...
                1015 2; 1016 2; 1017 2; 1018 2; 1019 2; 1020 2; 1021 2; 1022 2; 1023 2; 1024 2; 1025 2; 1026 2; 1027 2; 1028 2; ...
                1029 3; 1030 3; 1031 3; 1032 3; 1033 3; 1034 3; 1035 3; 1036 3; 1037 3; 1038 3; 1039 3; 1040 3; 1041 3; 1042 3; ...
                1043 4; 1044 4; 1045 4; 1046 4; 1047 4; 1048 4; 1049 4; 1050 4; 1051 4; 1052 4; 1053 4; 1054 4; 1055 4; 1056 4; ...
                1057 5; 1058 5; 1059 5; 1060 5; 1061 5; 1062 5; 1063 5; 1064 5; 1065 5; 1066 5; 1067 5; 1068 5; 1069 5; 1070 5];

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

