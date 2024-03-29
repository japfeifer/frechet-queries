% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMMSASL2_SD_DTW_opt_sing_25classes';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

batchFlg = 1;
datasetType = 8; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
reachPctCurr = 0;
iterHMSub = 1; % number of iterations
numPredictor = 0;
numLearner = 100;
featureSetNum = 10;  
normDistCurr = 0;
kCurr = 0;
numTrainCurr = 0.6;
trajFeatureCurr = [30];
distMeasCurr = [1 0 0 0];
seqNormalCurr = [0 1 1 1];
numTestCurr = 0;
trainSubCurr = [1];
testSubCurr = [2];
trainSampleCurr = 0; 
testSampleCurr = 0;  
edrTol = 0.15;  % edit distance tolerance
% these variables should never be changed for this type of experiment
implicitErrorFlg = 0;
ConstructCCTType = 1;
trainMethodCurr = 1;
bestTrainRepFlgCurr = 0;
swapKFoldCurr = 0;

% top 25 classes
featureSetClass = [13 22 53 15 4 17 61 75 23 26 47 59 67 76 77 84 3 5 8 16 24 30 35 48 51];
testSetClass = [13 22 53 15 4 17 61 75 23 26 47 59 67 76 77 84 3 5 8 16 24 30 35 48 51];
trainSetClass = [13 22 53 15 4 17 61 75 23 26 47 59 67 76 77 84 3 5 8 16 24 30 35 48 51];

% % top 50 classes
% featureSetClass = [13 22 53 15 4 17 61 75 23 26 47 59 67 76 77 84 3 5 8 16 24 30 35 48 51 60 71 99 9 12 28 29 31 33 37 38 40 43 44 45 56 72 80 93 11 19 21 27 39 70];
% testSetClass = [13 22 53 15 4 17 61 75 23 26 47 59 67 76 77 84 3 5 8 16 24 30 35 48 51 60 71 99 9 12 28 29 31 33 37 38 40 43 44 45 56 72 80 93 11 19 21 27 39 70];
% trainSetClass = [13 22 53 15 4 17 61 75 23 26 47 59 67 76 77 84 3 5 8 16 24 30 35 48 51 60 71 99 9 12 28 29 31 33 37 38 40 43 44 45 56 72 80 93 11 19 21 27 39 70];


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

% parfor i=1:1000 % do this to startup the parallel pool
% 	a=0;
% end

% load the dataset
timeLoad = 0; tLoad = tic;
LoadModelDataset;
timeLoad = timeLoad + toc(tLoad);
disp(['Data Load Time (sec): ',num2str(timeLoad)]);

% change Subject to Xview
MSASLSubjectToXview;

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

