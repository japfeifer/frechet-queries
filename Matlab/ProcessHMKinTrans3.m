% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'HMKinTrans3';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

datasetType = 1; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
iterHMSub = 1; % number of iterations
disp(['datasetType: ',num2str(datasetType),' Iterations: ',num2str(iterHMSub)]);

numPredictor = 0;
numLearner = 100;

featureSetNum = 0;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = 0.20;
trajFeatureCurr = [1];
distMeasCurr = [1 0];
seqNormalCurr = [0 0 0 0 0];
numTestCurr = 0;

trainSubCurr = [0 1 2 3];
testSubCurr = [20];
trainSampleCurr = 1;
testSampleCurr = 2;

% these variables should never be changed for this type of experiment
implicitErrorFlg = 0;
ConstructCCTType = 1;
trainMethodCurr = 1;
classifierCurr = 1;
bestTrainRepFlgCurr = 0;
swapKFoldCurr = 0;

% output variable selections
normDistCurr
kCurr
numTrainCurr
trajFeatureCurr
distMeasCurr
seqNormalCurr
numTestCurr
trainSubCurr
testSubCurr
trainSampleCurr
testSampleCurr
numPredictor
numLearner
featureSetNum

LoadModelDataset;

for iHMSub = 1:iterHMSub
    rngSeed = iHMSub; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    disp(['Iteration: ',num2str(iHMSub)]);
    RunSubModel2;
    resultList(1,iHMSub) = classAccuracy;
end

resultList % output the results

classAccuracyMean = mean(resultList(1,:));
classAccuracyStdDev = std(resultList(1,:));
disp(['--> Final classAccuracyMean: ',num2str(classAccuracyMean),' classAccuracyStdDev: ',num2str(classAccuracyStdDev)]);
resultList(2,1) = classAccuracyMean;
resultList(2,2) = classAccuracyStdDev;

save(matFile,'resultList');
diary off;

