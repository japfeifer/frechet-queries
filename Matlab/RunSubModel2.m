% Run Sub Model
% Compute the accuracy for this combination of variables

timeTrain = 0;  timeTest = 0; timeSeqPrep = 0; timeTrainClass = 0; timeTestClass = 0;

tSeqPrep = tic;

% trainMat = single([]);
trainMat = [];
trainMatDist = [];
trainLabels = [];
trainMat2 = [];
trainLabels2 = [];
trainMatDist2 = [];
% testMat = single([]);
testMat = [];
testMatDist = [];
testLabels = [];
featureSet = {[]};
numTrainDistComp = 0;
numTestDistComp = 0;

if ~exist('testSetClass','var')
    testSetClass = [];
end

if ~exist('trainSetClass','var')
    trainSetClass = [];
end

if ~exist('testSetList','var')
    testSetList = [];
end

if ~exist('featureSetClass','var')
    featureSetClass = [];
end

if ~exist('doSVMFlg','var')
    doSVMFlg = 0;
end

if ~exist('keepTrainSetClass','var')
    keepTrainSetClass = [];
end

if ~exist('testSetSub','var')
    testSetSub = [];
end

if ~exist('trainSetSub','var')
    trainSetSub = [];
end

if ~exist('trainSetSub','var')
    trainSetSub = [];
end

if ~exist('saveEarlyFlg','var')
    saveEarlyFlg = [];
end

if ~exist('otherFeatureColFlg','var')
    otherFeatureColFlg = 0;
end

if ~exist('featureSetNum2','var')
    featureSetNum2 = 0;
end

% determine query and input sets
SplitTrainQuery(numTrainCurr,numTestCurr,trainMethodCurr,bestTrainRepFlgCurr, ...
    trainSubCurr,testSubCurr,trainSampleCurr,testSampleCurr,swapKFoldCurr,testSetClass,testSetList,keepTrainSetClass,testSetSub,trainSetSub); 

disp(['Num Train seq: ',num2str(size(trainSet,1))]);
disp(['Num Test seq: ',num2str(size(querySet,1))]);

if classifierCurr == 1
    featureSet = CreateFeatureSet(featureSetNum,featureSetClass,otherFeatureColFlg,featureSetNum2);
    disp(['Num Feature cols: ',num2str(size(featureSet,1))]);
end

if isempty(trainSetClass) == 0 % only include certain classes in train set
    trainSetTmp = {[]};
    cnt = 1;
    for i = 1:size(trainSet,1)
        currClassID = cell2mat(trainSet(i,2));
        if ismember(currClassID,trainSetClass) == 1
            trainSetTmp(cnt,1) = trainSet(i,1);
            trainSetTmp(cnt,2) = trainSet(i,2);
            cnt = cnt + 1;
        end
    end
    trainSet = trainSetTmp;
    disp(['Reduced Train seq (subset of classes): ',num2str(size(trainSet,1))]);
end

disp(['Normalize sequences']);
tNormSeqPrep = tic;
numToNorm = sum(seqNormalCurr);
if numToNorm == 0 % do not normalize any seq
    for i = 1:size(CompMoveData,1)
        CompMoveData(i,6) = CompMoveData(i,4); % use non-normalized seq
    end
else % normalize a subset of types
    NormCompMoveData;
end
timeNormSeqPrep = toc(tNormSeqPrep);
disp(['Normalize sequences time: ',num2str(timeNormSeqPrep)]);

timeSeqPrep = timeSeqPrep + toc(tSeqPrep);

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

if classifierCurr == 2 && kCurr == 1 && size(trajFeatureCurr,2) > 1 % NN with multi feat traj
    MajorityVote3;
    NNAccuracy = mean(queryResults(:,5)) * 100;
    disp(['NN multi mean accuracy: ',num2str(NNAccuracy)]);
end

if saveEarlyFlg == 1
    save(matFile,'allClasses','classes','classIDs','compIDs','featureSet','',...
     'querySet','testLabels','testMat','trainLabels','trainMat','trainSet',...
     '-v7.3');
end

if classifierCurr == 1  % ensemble method: subspace, learner type: discriminant
    
    disp(['Start Training']);
    if ~exist('doGaussFit','var')
        doGaussFit = 0;
    end
    
    if doGaussFit == 1
        trainMat = trainMat + 0.00001; % can not have zeros for boxcox
        for iBox = 1:size(trainMat,2)
            trainMat(:,iBox) = FitGaussian(trainMat(:,iBox));
        end
        testMat = testMat + 0.00001; % can not have zeros for boxcox
        for iBox = 1:size(testMat,2)
            testMat(:,iBox) = FitGaussian(testMat(:,iBox));
        end
    end
    
    rng(rngSeed); % reset random seed so experiments are reproducable

    if numPredictor == 0
        numPredictor = floor(size(trainMat,2) / 2);
    end
    if numLearner == 0
        numLearner = 50;
    end

    tTrain = tic;
    tTrainClass = tic;
    
    if doConfFlg == 1
        InclConfFeat;
    end
    
    if classifierCurr == 1 && numTrainCurr == 1 && distType == 4
        t = templateDiscriminant('DiscrimType','diagLinear'); % subspace discriminant, edit distance, low trainers requires this type
    else
%         if batchFlg == 1
%             t = templateDiscriminant('DiscrimType','linear','Delta',1.6841e-05,'Gamma',0.046833);
%         else
            t = templateDiscriminant('DiscrimType','linear');
%         end
    end
    
    if doSVMFlg ==1
        t = templateSVM('KernelFunction','linear');
        options = statset('UseParallel',true);
        Mdl = fitcecoc(trainMat,trainLabels,'Coding','onevsone','Learners','svm','Learners',t,'Options',options); % train the classifier
    else
        Mdl = fitcensemble(...
            trainMat, ...
            trainLabels, ...
            'Method', 'Subspace', ...
            'NumLearningCycles', numLearner, ...
            'Learners', 'discriminant', ...
            'Learners',t, ...
            'NPredToSample', numPredictor);
    end
    
    timeTrain = timeTrain + toc(tTrain);
    timeTrainClass = timeTrainClass + toc(tTrainClass);
    
    disp(['Training Complete']);
    
    tTest = tic;
    tTestClass = tic;
    
    disp(['Start Prediction']);
    classifierRes = predict(Mdl,testMat);
    disp(['Prediction Complete']);

    timeTestClass = timeTestClass + toc(tTestClass);

    % compute classifier accuracy
    classifierRes(:,2) = testLabels;
    classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
    classAccuracy = mean(classifierRes(:,3)) * 100;  
    disp(['Classification accuracy: ',num2str(classAccuracy)]);
    disp(['Test Seq correct: ',num2str(sum(classifierRes(:,3)))]);
    disp(['Test Seq incorrect: ',num2str(size(classifierRes,1) - sum(classifierRes(:,3)))]);

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
    
    timeTest = timeTest + toc(tTest);
end
    
if classifierCurr == 2
    classAccuracy = NNAccuracy; 
    classifierRes = [];
    trainWordIDs = [];
end

disp(['Seq prep (choose train/test sets, normalize, transform) Time (sec): ',num2str(timeSeqPrep)]);
disp(['Training Time (sec): ',num2str(timeTrain), ', ms per Train Seq: ',num2str(timeTrain/size(trainSet,1)*1000)]);
disp(['Training Time Classifier only (sec): ',num2str(timeTrainClass), ', ms per Train Seq: ',num2str(timeTrainClass/size(trainSet,1)*1000)]);
disp(['Testing Time (sec): ',num2str(timeTest), ', ms per Test Seq: ',num2str(timeTest/size(querySet,1)*1000)]);
disp(['Testing Time Classifier only (sec): ',num2str(timeTestClass), ', ms per Test Seq: ',num2str(timeTestClass/size(querySet,1)*1000)]);
disp(['Training Num dist calls total: ',num2str(numTrainDistComp), ', Training Num dist calls per seq: ',num2str(numTrainDistComp/size(trainSet,1))]);
disp(['Testing Num dist calls total: ',num2str(numTestDistComp), ', Testing Num dist calls per seq: ',num2str(numTestDistComp/size(querySet,1))]);

% get the training data structure sizes
if classifierCurr == 1
    szStr1 = whos('Mdl');
    szTrain = szStr1.bytes;
elseif classifierCurr == 2
    szStr1 = whos('trainSet');
    szTrain = szStr1.bytes;
end
if distType == 3  % cont Frechet data structure
    szStr1 = whos('clusterNode');
    szStr2 = whos('clusterTrajNode');
    szTrain = szTrain + szStr1.bytes + szStr2.bytes;
end
disp(['Training Size(MB): ',num2str(szTrain/1024/1024), ', KB per Train Seq: ',num2str(szTrain/1024/size(trainSet,1))]);

% % SVM classifier
% Mdl = fitcecoc(trainMat,trainLabels,'Coding','onevsone','Learners','svm'); % train the classifier

