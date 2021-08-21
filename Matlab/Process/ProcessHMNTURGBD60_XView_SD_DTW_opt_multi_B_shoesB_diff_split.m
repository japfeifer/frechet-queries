% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMNTURGBD60_XView_SD_DTW_opt_multi_B_shoesB_diff_split';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

batchFlg = 1;
datasetType = 6; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
reachPctCurr = 0;
iterHMSub = 1; % number of iterations
numPredictor = 0;
numLearner = 100;
featureSetNum = 500;  
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
trajFeatureCurr = [26 27 1056 1037];
distMeasCurr = [1 0 0 0];
seqNormalCurr = [1 0 1 0 0 0];
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
% testSetList = [29259,29284,29289,29290,29293,29314,29317,29320,29343,29345,29346,29350,29355,29357,29359,29360,29362,29363,29364,29365,29366,29373,29376,29379,29382,29383,29384,29385,29386,29387,29389,29391,29396,29398,29400,29401,29402,29403,29404,29405,29407,29408,29427,29428,29441,29443,29450,29452,29456,29458,29459,29460,29495,29513,29522,29523,29525,29534];

% doDMDistFlg = 1;
% numFrameDist = 40;
% numTrainDist = 5;
% numTestDist = 5;
% numFeatureDist = 5;

% output variable selections
disp(['datasetType: ',num2str(datasetType)]);
disp(['classifierCurr: ',num2str(classifierCurr)]);
disp(['iterHMSub: ',num2str(iterHMSub)]);
disp(['numPredictor: ',num2str(numPredictor)]);
disp(['numLearner: ',num2str(numLearner)]);
disp(['featureSetNum: ',num2str(featureSetNum)]);
disp(['normDistCurr: ',num2str(normDistCurr)]);
disp(['kCurr: ',num2str(kCurr)]);
disp(['numTrainCurr: ',num2str(numTrainCurr)]);
disp(['trajFeatureCurr: ',num2str(trajFeatureCurr)]);
disp(['distMeasCurr: ',num2str(distMeasCurr)]);
disp(['seqNormalCurr: ',num2str(seqNormalCurr)]);
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

for iHMSub = 1:iterHMSub
    rngSeed = iHMSub; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    disp(['Iteration: ',num2str(iHMSub)]);
    RunSubModel2;
    resultList(1,iHMSub) = classAccuracy;
end

% output the results
for iHMSub = 1:iterHMSub
    disp(['resultList ',num2str(iHMSub),': ',num2str(resultList(iHMSub))]);
end

classAccuracyMean = mean(resultList(1,:));
classAccuracyStdDev = std(resultList(1,:));
disp(['--> Final classAccuracyMean: ',num2str(classAccuracyMean),' classAccuracyStdDev: ',num2str(classAccuracyStdDev)]);
resultList(2,1) = classAccuracyMean;
resultList(2,2) = classAccuracyStdDev;

save(matFile,'resultList','allClasses','classes','classIDs','classifierRes','compIDs','featureSet','',...
     'queryResults','querySet','testLabels','testMat','trainLabels','trainMat','trainSet',...
     'trainWordIDs','-v7.3');
 
diary off;

