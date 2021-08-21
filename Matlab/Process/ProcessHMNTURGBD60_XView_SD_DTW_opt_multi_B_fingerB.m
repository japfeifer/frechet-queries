% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMNTURGBD60_XView_SD_DTW_opt_multi_B_fingerB';
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
trajFeatureCurr = [17 18 19 1085 1066 1012]; 
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
featureSetClass = [26 44];
testSetClass = [];
trainSetClass = [26 44];
testSetList = [17373,17375,17376,17377,17378,17379,17380,17381,17382,17383,17384,17385,17386,17387,17388,17390,17393,17394,17395,17396,17397,17398,17399,17400,17401,17402,17403,17404,17405,17406,17407,17408,17409,17410,17411,17412,17413,17415,17416,17418,17419,17420,17421,17422,17423,17427,17428,17429,17431,17432,17433,17434,17435,17437,17438,17439,17441,17442,17443,17444,17446,17447,17448,17449,17450,17451,17452,17453,17454,17455,17456,17457,17459,17460,17461,17462,17463,17464,17466,17468,17470,17472,17473,17474,17475,17476,17477,17478,17479,17480,17481,17482,17483,17484,17485,17486,17487,17488,17489,17490,17491,17492,17493,17496,17497,17498,17499,17500,17502,17503,17504,17505,17506,17507,17508,17509,17510,17511,17512,17513,17514,17515,17516,17518,17522,17524,17525,17526,17528,17529,17530,17531,17532,17533,17535,17536,17539,17540,17541,17542,17545,17546,17547,17552,17554,17557,17558,17562,17564,17567,17568,17569,17570,17572,17573,17574,17575,17576,17577,17578,17579,17580,17581,17582,17583,17584,17585,17586,17587,17588,17589,17590,17591,17592,17593,17594,17595,17596,17597,17598,17599,17600,17601,17602,17603,17604,17605,17606,17607,17608,17609,17610,17611,17613,17614,17615,17618,17620,17621,17622,17625,17626,17628,17629,17631,17632,17633,17634,17635,17636,17638,17639,17641,17642,17644,17646,17647,17648,17650,17651,17655,17656,17657,17658,17659,17662,17663,17664,17665,17667,17668,17669,17670];
% testSetList = [32000,32001,32013,32028,32048,32050,32051,32052,32053,32056,32057,32079,32089,32114,32130,32132,32136,32137,32143,32145,32153,32181,32182,32183,32184,32185,32186,32187,32188,32190,32194,32203,32212,32246,32257,32274];

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

