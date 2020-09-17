% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'HMMSRDA1';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

datasetType = 5; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF, 5 = MSRDA
iterHMSub = 1; % number of iterations
disp(['datasetType: ',num2str(datasetType),' Iterations: ',num2str(iterHMSub)]);

featureSetNum = 0;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
trajFeatureCurr = [6];
distMeasCurr = [1 0];
seqNormalCurr = [1 0 0 0 1];
numTestCurr = -1;

trainSubCurr = [1 3 5 7 9];
testSubCurr = [2 4 6 8 10];
% trainSampleCurr = 1;
testSampleCurr = 0;

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
% trainSampleCurr
testSampleCurr
featureSetNum

LoadModelDataset;

trainSampleHMSub = [1 2]; % run for several training samples
for iHMSub = 1:size(trainSampleHMSub,2)
    numPredictor = 0;
    numLearner = 0;
    rngSeed = 1; % random seed value - set to 1
    rng(rngSeed); % reset random seed so experiments are reproducable
    trainSampleCurr = trainSampleHMSub(iHMSub);
    disp(['-----------------']);
    disp(['trainSampleCurr: ',num2str(trainSampleCurr)]);
    RunSubModel2;
    disp(['numPredictor: ',num2str(numPredictor)]);
    disp(['numLearner: ',num2str(numLearner)]);
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

