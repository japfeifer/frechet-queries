% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'HMLM1';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

datasetType = 3; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
% iterHMSub = 1; % number of iterations
disp(['dataset: ',num2str(datasetType)]);

HMNumSets = 5;  % five equal-sized test sets
swapKFoldCurr = 0;
featureSetNum = 2;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -2;
trajFeatureCurr = [8];
distMeasCurr = [1 0];
seqNormalCurr = [1 0 0 0 1];
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

% output variable selections
HMNumSets
swapKFoldCurr
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
featureSetNum;

LoadModelDataset;

rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
CreateQuerySets2(HMNumSets);

for currHMTrainSet = 1:HMNumSets
    numPredictor = 0;
    numLearner = 0;
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    disp(['-----------------']);
    disp(['Current train set: ',num2str(currHMTrainSet)]);
    RunSubModel2;
    disp(['numPredictor: ',num2str(numPredictor)]);
    disp(['numLearner: ',num2str(numLearner)]);
    resultList(1,currHMTrainSet) = classAccuracy;
end

resultList % output the results

classAccuracyMean = mean(resultList(1,:));
classAccuracyStdDev = std(resultList(1,:));
disp(['--> Final classAccuracyMean: ',num2str(classAccuracyMean),' classAccuracyStdDev: ',num2str(classAccuracyStdDev)]);
resultList(2,1) = classAccuracyMean;
resultList(2,2) = classAccuracyStdDev;

save(matFile,'resultList');
diary off;

