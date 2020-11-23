% Run Sub Model
% Compute the accuracy for this combination of variables

% k (for kNN) must be at least 2 for shift-one method
if trainMethodCurr == 3 && kCurr < 2 
    kCurr = 2;
end

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

% determine query and input sets
SplitTrainQuery(numTrainCurr,numTestCurr,trainMethodCurr,bestTrainRepFlgCurr, ...
    trainSubCurr,testSubCurr,trainSampleCurr,testSampleCurr,swapKFoldCurr); 

% populate training and query (test) matrices
predNumCnt = 1;
for mHM = 1:size(distMeasCurr,2) % for each dist measure
    if distMeasCurr(1,mHM) == 1 % process this dist
        distType = mHM;
        for kHM = 1:size(trajFeatureCurr,2) % for each traj feature
            predNum = predNumCnt; 
            exMethNum = trajFeatureCurr(1,kHM); 
            RunPredictor;
            predNumCnt = predNumCnt + 1;
        end
    end
end

% run the classifier
if classifierCurr == 3 || classifierCurr == 4 % SVM classifier
    CreateCatModel; % create the categorical model
    Mdl = fitcecoc(modelTrainMat,trainLabels,'Coding','onevsone','Learners','svm'); % train the classifier
    classifierRes = predict(Mdl,modelTestMat); % Classify the test data
elseif classifierCurr == 5 % Maj Vote classifier
    MajorityVote;
end

% compute classifier accuracy
classifierRes(:,2) = testLabels;
classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
classAccuracy = mean(classifierRes(:,3)) * 100;  
disp(['Classification accuracy: ',num2str(classAccuracy)]);
