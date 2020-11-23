% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMNTURGBD60_XView_SD_DTW_opt_multi_B_readingB';
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
trajFeatureCurr = [33 34 35 1012 1089 1090 1076 1063];
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
featureSetClass = [32 60 52 24];
testSetClass = [];
trainSetClass = [32 60 52 24];

% reading id 32
testSetList = [21069,21071,21073,21082,21083,21085,21087,21088,21089,21090,21092,21093,21095,21096,21101,21103,21107,21110,21112,21116,21117,21118,21120,21121,21124,21125,21126,21127,21130,21131,21132,21134,21136,21137,21138,21140,21142,21143,21144,21151,21152,21153,21154,21155,21159,21161,21162,21164,21167,21168,21169,21173,21176,21177,21178,21181,21182,21184,21186,21187,21188,21190,21191,21193,21194,21195,21197,21198,21199,21201,21202,21205,21206,21207,21208,21209,21212,21213,21214,21215,21218,21221,21223,21224,21229,21230,21236,21237,21238,21239,21240,21241,21244,21246,21248,21249,21251,21255,21256,21257,21258,21261,21262,21263,21267,21268,21270,21271,21272,21273,21274,21279,21285,21289,21291,21293,21295,21296,21297,21298,21303,21305,21306,21307,21308,21310,21311,21312,21313,21314,21318,21319,21320,21322,21324,21325,21326,21327,21328,21329,21330,21332,21333,21334,21335,21336,21338,21339,21340,21341,21342,21343,21344,21346,21347,21348,21349,21350,21351,21352,21354,21358,21359,21360,21361,21362,21363,21364,21365,21366,21369,21373,21374,21375,21376];
% writing id 60
testSetList = [testSetList 43987,43995,43996,44002,44005,44009,44011,44016,44017,44019,44021,44023,44028,44033,44035,44038,44045,44063,44064,44065,44066,44068,44082,44094,44097,44100,44101,44114,44118,44130,44132,44136,44145,44152,44155,44156,44161,44168,44176,44183,44189,44193,44194,44198,44199,44203,44205,44206,44207,44217,44219,44226,44233,44235,44247,44252,44257,44260,44265,44267,44273,44282];
% type on keyboard id 52
testSetList = [testSetList 38311,38315,38320,38361,38362,38373,38397,38402,38413,38415,38416,38420,38435,38444,38445,38450,38453,38461,38473,38490,38496,38505,38514,38519,38520,38535,38548,38561,38575,38586,38600,38603,38611];
% play with phone/tablet id 24
testSetList = [testSetList 16459,16528,16567,16580,16582,16593,16622,16641,16688,16705,16707,16710,16734,16737,16738,16741,16743,16750];

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

