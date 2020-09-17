% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'HMSub';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

datasetType = 1; % 1 = KinTrans, 2 = MHAD
iterHMSub = 1; % number of iterations
disp(['datasetType: ',num2str(datasetType),' Iterations: ',num2str(iterHMSub)]);

kCurr = 1;
numTrainCurr = 20;
trajFeatureCurr = [1];
classifierCurr = 1;
distMeasCurr = [1 0];
trainMethodCurr = 1;
seqNormalCurr = [1 1 1 1 1];
numTestCurr = 20;
bestTrainRepFlgCurr = 0;

% output variable selections
kCurr 
numTrainCurr 
numTestCurr
trajFeatureCurr 
classifierCurr 
distMeasCurr 
trainMethodCurr 
seqNormalCurr
bestTrainRepFlgCurr

LoadModelDataset;

for iHMSub = 1:iterHMSub
    rngSeed = iHMSub; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    disp(['Iteration: ',num2str(iHMSub)]);
    RunSubModel;
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

