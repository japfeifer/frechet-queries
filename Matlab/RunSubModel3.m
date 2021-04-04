% Run Sub Model
% Find approximate optimal traj features

timeTrain = 0;  timeTest = 0; timeSeqPrep = 0; resultRow = 1;

if ~exist('featureSetIgnoreSubFlg','var')
    featureSetIgnoreSubFlg = 0;
end

if ~exist('testSetClass','var')
    testSetClass = [];
end

if ~exist('kFoldSeqPerClass','var')
    kFoldSeqPerClass = [];
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

if ~exist('otherFeatureColFlg','var')
    otherFeatureColFlg = 0;
end

if ~exist('featureSetNum2','var')
    featureSetNum2 = 0;
end

if ~exist('doIterNumJtsIncl','var')
    doIterNumJtsIncl = 0;
end

if ~exist('kNNmDistWeightFlg','var')
    kNNmDistWeightFlg = 1;
end

if ~exist('aggFlg','var')
    aggFlg = 0;
end

if doIterNumJtsIncl == 1
    if ~exist('iterNumJtsIncl','var')
        iterNumJtsIncl = 1;
    end
    if ~exist('doDMmMin','var')
        doDMmMin = 1;
    end
end

tSeqPrep = tic;

if classifierCurr == 2 && kCurr == 0
    kCurr = 1; % set kNN to 1 since this is a NN test
end

% determine training/testing seq
SplitTrainQuery(numTrainCurr,numTestCurr,trainMethodCurr,bestTrainRepFlgCurr, ...
    trainSubCurr,testSubCurr,trainSampleCurr,testSampleCurr,swapKFoldCurr,testSetClass,testSetList,keepTrainSetClass,testSetSub,trainSetSub);

rng(rngSeed); % reset random seed so experiments are reproducable

if ~exist('doTrainSplit','var')
    doTrainSplit = 0;
end

disp(['Initial Num Train seq: ',num2str(size(trainSet,1))]);
disp(['Initial Num Test seq: ',num2str(size(querySet,1))]);

featureSet = {[]};
if classifierCurr == 1
    featureSet = CreateFeatureSet(featureSetNum,featureSetClass,otherFeatureColFlg,featureSetNum2,featureSetIgnoreSubFlg);
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

if doTrainSplit == 1 % put 2/3 of trainers into testers
    trainSetT = {[]};
    querySetT = {[]};
    allClasses = cell2mat(trainSet(:,2));
    classes = unique(allClasses); % list of unique classes
    trainSetTcnt = 1;
    querySetTcnt = 1;
    for i = 1:size(classes,1) % process each unique class
        classIDs = find(ismember(allClasses,classes(i))); % get list of class ID's for this unique class label
        if kFoldSeqPerClass > 0 % reduce the number of classIDs
            [classIDs,garbage] = datasample(classIDs,kFoldSeqPerClass,'Replace',false);
        end
%         numTrainSeq = ceil(size(classIDs,1)/2);
        numTrainSeq = floor(size(classIDs,1)/3);
        if numTrainSeq == 0
            numTrainSeq = 1;
        end
        [tmpValue,trainSetID] = datasample(classIDs,numTrainSeq,'Replace',false);
        for j = 1:size(classIDs,1)
            if ismember(j,trainSetID)
                trainSetT(trainSetTcnt,1:2) = trainSet(classIDs(j),1:2);
                trainSetTcnt = trainSetTcnt + 1;
            else
                querySetT(querySetTcnt,1:2) = trainSet(classIDs(j),1:2);
                querySetTcnt = querySetTcnt + 1;
            end
            
        end
    end
    if classifierCurr == 1 && size(classes,1) == size(trainSetT,1)
        trainSetT(size(classes,1)+1,1:2) = trainSetT(size(classes,1),1:2);
    end
    trainSet = trainSetT;
    querySet = querySetT;
    
    if isempty(testSetClass) == 0 % only include certain classes in test set
        querySetTmp = {[]};
        cnt = 1;
        for i = 1:size(querySet,1)
            currClassID = cell2mat(querySet(i,2));
            if ismember(currClassID,testSetClass) == 1
                querySetTmp(cnt,1) = querySet(i,1);
                querySetTmp(cnt,2) = querySet(i,2);
                cnt = cnt + 1;
            end
        end
        querySet = querySetTmp;
    end
end

disp(['Final Num Train seq: ',num2str(size(trainSet,1))]);
disp(['Final Num Test seq: ',num2str(size(querySet,1))]);

timeSeqPrep = timeSeqPrep + toc(tSeqPrep);

for mHM = 1:size(distMeasCurr,2) % for each dist measure
    if distMeasCurr(1,mHM) == 1 % process this dist
        distType = mHM;
        for nHM = 1:size(seqNormalSetCurr,1) % for each normalization set
            tSeqPrep = tic;
            seqNormalCurr = seqNormalSetCurr(nHM,:);
            numToNorm = sum(seqNormalCurr);
            if numToNorm == 0 % do not normalize any seq
                for i = 1:size(CompMoveData,1)
                    CompMoveData(i,6) = CompMoveData(i,4); % use non-normalized seq
                end
            else % normalize a subset of types
                NormCompMoveData;
            end
            timeSeqPrep = timeSeqPrep + toc(tSeqPrep);
            disp(['======================']);
            disp(['distType: ',num2str(distType)]);
            disp(['seqNormalCurr: ',num2str(seqNormalCurr)]);
            queryResults = [];
            if classifierCurr == 1 && trajDefTypeCurr == 2
                if doIterNumJtsIncl == 1
                    if aggFlg == 1
                        RunPredictor3DMm3;
                    else
                        RunPredictor3DMm2;
                    end
                else
                    RunPredictor3DMm; % faster stepwise inclusion algo for DM-m
                end
            else
                if aggFlg == 1 % do NN/kNN multi traj aggregation feature discovery
                    RunPredictor3kNNmulti;
                else
                    RunPredictor3; % do NN/kNN single traj feature discovery
                end
            end
            disp(['----------------------']);
            disp(['distType: ',num2str(distType)]);
            disp(['seqNormalCurr: ',num2str(seqNormalCurr)]);
            disp(['Best Accuracy: ',num2str(lastBestAcc),' Best Definition: ',num2str(lastBestDef)]);
            resultList(resultRow,1) = num2cell(distType);
            resultList(resultRow,2) =  mat2cell(seqNormalCurr,size(seqNormalCurr,1),size(seqNormalCurr,2));
            resultList(resultRow,3) = num2cell(lastBestAcc);
            resultList(resultRow,4) = mat2cell(lastBestDef,size(lastBestDef,1),size(lastBestDef,2));
            resultRow = resultRow + 1;
            disp(['======================']);
        end
    end
end

resultList = sortrows(resultList,[3],'descend'); % sort by accuracy desc

disp(['Seq prep (choose train/test sets, normalize, transform) Time (sec): ',num2str(timeSeqPrep)]);
disp(['Training Time (sec): ',num2str(timeTrain), ', ms per Train Seq: ',num2str(timeTrain/size(trainSet,1)*1000)]);
disp(['Testing Time (sec): ',num2str(timeTest), ', ms per Test Seq: ',num2str(timeTest/size(querySet,1)*1000)]);

