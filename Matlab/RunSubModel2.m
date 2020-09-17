% Run Sub Model
% Compute the accuracy for this combination of variables

numToNorm = sum(seqNormalCurr);
if numToNorm == 0 % do not normalize any seq
    for i = 1:size(CompMoveData,1)
        CompMoveData(i,6) = CompMoveData(i,4); % use non-normalized seq
    end
else % normalize a subset of types
    NormCompMoveData;
end

trainMat = [];
trainMatDist = [];
trainLabels = [];
trainMat2 = [];
trainLabels2 = [];
trainMatDist2 = [];
testMat = [];
testMatDist = [];
testLabels = [];
featureSet = [];

% determine query and input sets
SplitTrainQuery(numTrainCurr,numTestCurr,trainMethodCurr,bestTrainRepFlgCurr, ...
    trainSubCurr,testSubCurr,trainSampleCurr,testSampleCurr,swapKFoldCurr); 

disp(['Num Train seq: ',num2str(size(trainSet,1))]);
disp(['Num Test seq: ',num2str(size(querySet,1))]);

featureSet = CreateFeatureSet(featureSetNum);

% populate training and query (test) matrices
predNumCnt = 1;
for mHM = 1:size(distMeasCurr,2) % for each dist measure
    if distMeasCurr(1,mHM) == 1 % process this dist
        distType = mHM;
        for kHM = 1:size(trajFeatureCurr,2) % for each traj feature
            predNum = predNumCnt; 
            exMethNum = trajFeatureCurr(1,kHM); 
            RunPredictor2;
            predNumCnt = predNumCnt + 1;
        end
    end
end

% run the classifier

% % SVM
% Mdl = fitcecoc(trainMat,trainLabels,'Coding','onevsone','Learners','svm'); % train the classifier
% classifierRes = predict(Mdl,testMat); % Classify the test data

% ensemble method: subspace, learner type: discriminant
rng(rngSeed); % reset random seed so experiments are reproducable
if numPredictor == 0
    numPredictor = floor(size(trainMat,2) / 2);
end
if numLearner == 0
    numLearner = 50;
end

t = templateDiscriminant('DiscrimType','linear');
Mdl2 = fitcensemble(...
    trainMat, ...
    trainLabels, ...
    'Method', 'Subspace', ...
    'NumLearningCycles', numLearner, ...
    'Learners', 'discriminant', ...
    'Learners',t, ...
    'NPredToSample', numPredictor);
classifierRes = predict(Mdl2,testMat);

% compute classifier accuracy
classifierRes(:,2) = testLabels;
classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
classAccuracy = mean(classifierRes(:,3)) * 100;  
disp(['--> Classification accuracy: ',num2str(classAccuracy)]);

% store some results in queryResults
queryResults = [];
queryResults(1:szSet,1:7) = 0;
trainWordIDs = cell2mat(trainSet(:,2));
for i=1:size(querySet,1)
    trueTestClass = cell2mat(querySet(i,2)); % test true Class ID
    predTestClass = classifierRes(i,1); % Classifier predicted Query Class ID
    queryResults(i,1) = cell2mat(querySet(i,1)); % Query CompMoveData ID
    queryResults(i,2) = cell2mat(trainSet(find(trainWordIDs==predTestClass,1),1)); % Classifier predicted CompMoveData ID
    queryResults(i,3) = cell2mat(trainSet(find(trainWordIDs==trueTestClass,1),1)); % True CompMoveData ID
    queryResults(i,4) = trueTestClass; 
    queryResults(i,6) = predTestClass; 
    queryResults(i,5) = queryResults(i,4) == queryResults(i,6); % kNN accuracy, 1 = same label, 0 = different label
end
    

