% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMNTURGBD60_Opt_Multi_Traj_SD_XView_B_shoes_all';
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
% doTrainSplit = 1;
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
featureSetNum = 500;
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
trainSampleCurr = 0;
testSampleCurr = 0;
edrTol = 0.15;  % edit distance tolerance
% these variables should never be changed for this type of experiment
implicitErrorFlg = 0;
ConstructCCTType = 1;
trainMethodCurr = 1;
bestTrainRepFlgCurr = 0;
swapKFoldCurr = 0;

doSVMFlg = 1;

groupClassesFlg = 0; 
subsetClassesFlg = 0;
groupClassesList = {[]}; 
subsetClassesList = [];
featureSetClass = [41 56];
testSetClass = [];
trainSetClass = [41 56];
testSetList = [40338,40340,40341,40342,40344,40345,40346,40349,40350,40351,40352,40353,40359,40363,40364,40365,40366,40367,40368,40369,40370,40371,40372,40373,40374,40375,40376,40377,40380,40381,40382,40383,40384,40385,40386,40387,40389,40390,40392,40393,40395,40396,40401,40405,40410,40411,40413,40415,40416,40417,40418,40419,40420,40421,40422,40423,40427,40428,40431,40433,40435,40438,40440,40441,40448,40450,40451,40452,40453,40454,40455,40456,40457,40458,40459,40461,40462,40463,40464,40465,40466,40467,40468,40469,40470,40471,40472,40475,40479,40482,40483,40484,40486,40488,40489,40490,40491,40492,40493,40494,40495,40496,40497,40498,40499,40500,40502,40503,40504,40505,40506,40507,40508,40509,40510,40511,40513,40514,40515,40522,40527,40528,40530,40532,40533,40534,40535,40536,40537,40541,40542,40544,40545,40546,40547,40548,40549,40552,40553,40555,40556,40557,40558,40559,40560,40562,40563,40564,40565,40566,40567,40570,40571,40573,40576,40578,40579,40581,40586,40587,40588,40590,40591,40597,40598,40599,40601,40604,40605,40606,40608,40612,40614,40615,40616,40619,40620,40621,40622,40623,40626,40627,40628,40629,40630,40633,40634,40636,40637,40638,40640,40641];
testSetList = [testSetList 29259,29284,29289,29290,29293,29314,29317,29320,29343,29345,29346,29350,29355,29357,29359,29360,29362,29363,29364,29365,29366,29373,29376,29379,29382,29383,29384,29385,29386,29387,29389,29391,29396,29398,29400,29401,29402,29403,29404,29405,29407,29408,29427,29428,29441,29443,29450,29452,29456,29458,29459,29460,29495,29513,29522,29523,29525,29534];

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

