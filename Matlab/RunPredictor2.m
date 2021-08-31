% run the predictor

disp(['Predictor ',num2str(predNum),' Extract Method ',num2str(exMethNum)]);

if ~exist('reachPctCurr','var')
    reachPctCurr = 0;
end

if ~exist('batchFlg','var')
    batchFlg = 0;
end

tSeqPrep = tic;

disp(['trainSet Prep']);
ttrainSetPrep = tic;
idxList = cell2mat(trainSet(:,1));
% get training set & query set high-dim traj for this Extract Method
for i = 1:size(trainSet,1) % training set
%     idx = cell2mat(trainSet(i,1));
    idx = idxList(i,1);
    seq = cell2mat(CompMoveData(idx,6));
    if datasetType == 1
        seq = KinTransExtractFeatures(seq,exMethNum);
    elseif datasetType == 2
        seq = MHADExtractFeatures(seq,exMethNum);
    elseif datasetType == 3
        seq = LMExtractFeatures(seq,exMethNum,idx);
    elseif datasetType == 4
        seq = UCFExtractFeatures(seq,exMethNum,idx);
    elseif datasetType == 5
        seq = MSRDAExtractFeatures(seq,exMethNum);
    elseif datasetType == 6
        seq = NTURGBDExtractFeatures(seq,exMethNum);
    elseif datasetType == 7 || datasetType == 8
        seq = MSASLExtractFeatures(seq,exMethNum);
    end
    if reachPctCurr > 0 % simplify the curve
        reach = TrajReach(seq); % get traj reach 
        seq = TrajSimp(seq,reach * reachPctCurr);
    end
    trainSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end
timetrainSetPrep = toc(ttrainSetPrep);
disp(['trainSet Prep time: ',num2str(timetrainSetPrep)]);

if classifierCurr == 2
    if size(trainSet2,2) > 1 % trainSet2 is not empty
        idxList = cell2mat(trainSet2(:,1));
        for i = 1:size(trainSet2,1) % training set 2
%             idx = cell2mat(trainSet2(i,1));
            idx = idxList(i,1);
            seq = cell2mat(CompMoveData(idx,6));
            if datasetType == 1
                seq = KinTransExtractFeatures(seq,exMethNum);
            elseif datasetType ==2
                seq = MHADExtractFeatures(seq,exMethNum);
            elseif datasetType == 3
                seq = LMExtractFeatures(seq,exMethNum,idx);
            elseif datasetType == 4
                seq = UCFExtractFeatures(seq,exMethNum,idx);
            elseif datasetType == 5
                seq = MSRDAExtractFeatures(seq,exMethNum);
            elseif datasetType == 6
                seq = NTURGBDExtractFeatures(seq,exMethNum);
            elseif datasetType == 7 || datasetType == 8
                seq = MSASLExtractFeatures(seq,exMethNum);
            end
            if reachPctCurr > 0 % simplify the curve
                reach = TrajReach(seq); % get traj reach 
                seq = TrajSimp(seq,reach * reachPctCurr);
            end
            trainSet2(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
        end
    end
end

disp(['querySet Prep']);
tquerySetPrep = tic;
idxList = cell2mat(querySet(:,1));
for i = 1:size(querySet,1) % query set
%     idx = cell2mat(querySet(i,1));
    idx = idxList(i,1);
    seq = cell2mat(CompMoveData(idx,6));
    if datasetType == 1
        seq = KinTransExtractFeatures(seq,exMethNum);
    elseif datasetType ==2
        seq = MHADExtractFeatures(seq,exMethNum);
    elseif datasetType == 3
        seq = LMExtractFeatures(seq,exMethNum,idx);
    elseif datasetType == 4
        seq = UCFExtractFeatures(seq,exMethNum,idx);
    elseif datasetType == 5
        seq = MSRDAExtractFeatures(seq,exMethNum);
    elseif datasetType == 6
        seq = NTURGBDExtractFeatures(seq,exMethNum);
    elseif datasetType == 7 || datasetType == 8
        seq = MSASLExtractFeatures(seq,exMethNum);
    end
    if reachPctCurr > 0 % simplify the curve
        reach = TrajReach(seq); % get traj reach 
        seq = TrajSimp(seq,reach * reachPctCurr);
    end
    querySet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end
timequerySetPrep = toc(tquerySetPrep);
disp(['querySet Prep time: ',num2str(timequerySetPrep)]);

if classifierCurr == 1
    disp(['featureSet Prep']);
    tfeatureSetPrep = tic;
    idxList = cell2mat(featureSet(:,1));
    % get training set & query set high-dim traj for this Extract Method
    for i = 1:size(featureSet,1) % training set
        idx = idxList(i,1);
        seq = cell2mat(CompMoveData(idx,6));
        if datasetType == 1
            seq = KinTransExtractFeatures(seq,exMethNum);
        elseif datasetType == 2
            seq = MHADExtractFeatures(seq,exMethNum);
        elseif datasetType == 3
            seq = LMExtractFeatures(seq,exMethNum,idx);
        elseif datasetType == 4
            seq = UCFExtractFeatures(seq,exMethNum,idx);
        elseif datasetType == 5
            seq = MSRDAExtractFeatures(seq,exMethNum);
        elseif datasetType == 6
            seq = NTURGBDExtractFeatures(seq,exMethNum);
        elseif datasetType == 7 || datasetType == 8
            seq = MSASLExtractFeatures(seq,exMethNum);
        end
        if reachPctCurr > 0 % simplify the curve
            reach = TrajReach(seq); % get traj reach 
            seq = TrajSimp(seq,reach * reachPctCurr);
        end
        featureSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
    end
    timefeatureSetPrep = toc(tfeatureSetPrep);
    disp(['featureSet Prep time: ',num2str(timefeatureSetPrep)]);
end

timeSeqPrep = timeSeqPrep + toc(tSeqPrep);

if classifierCurr == 2
    if trainMethodCurr == 2 % half half method
        halfHalfFlg = 1; % trainset is training data, trainset2 is query data
    else
        halfHalfFlg = 0; % trainset is both training and query data
    end
end

if ~exist('doDMDistFlg','var')
    doDMDistFlg = 0;
end

if doDMDistFlg == 1
    featureSet = DMDistSetupFnc(featureSet,numFrameDist,numFeatureDist);
    trainSet = DMDistSetupFnc(trainSet,numFrameDist,numTrainDist);
    querySet = DMDistSetupFnc(querySet,numFrameDist,numTestDist);
end

tTrain = tic;

% Construct the training matrix and populate with features
disp(['Construct training matrix']);
trainQueryType = 1; % process trainset data
if classifierCurr == 1
    if batchFlg == 1
        ConstTrainQuerySet2B;
    else
        ConstTrainQuerySet2;
    end
elseif classifierCurr == 2 % NN or kNN
    if kCurr == 1 % NN
        if size(trajFeatureCurr,2) == 1 % single feature traj
            if batchFlg == 1
                ConstTrainQuerySet3B;
            else
                ConstTrainQuerySet3;
            end
        else % multi feature traj
            ConstTrainQuerySet5;
        end
    else % kNN
        if size(trajFeatureCurr,2) == 1 % single feature traj
            ConstTrainQuerySet4;
        else % kNN-multi feature traj
            ConstTrainQuerySet6;
        end
    end
end

% if trainMethodCurr == 2 % half half method, train the other half
%     halfHalfFlg = 2; % trainset2 is training data, trainset is query data
%     disp(['Construct training matrix, other half']);
%     ConstTrainQuerySet;
%     
%     % append new results from other half
%     trainMat = [trainMat; trainMat2];
%     trainMatDist = [trainMatDist; trainMatDist2];
%     trainLabels = [trainLabels; trainLabels2];
%     trainSet = [trainSet; trainSet2];
%     
%     halfHalfFlg = 1; % set back to 1, so that it uses trainSet below
% end

timeTrain = timeTrain + toc(tTrain);

% % this code gets kNN word ID's for just the training data, so that one can look at patterns
% if classifierCurr == 2 && kCurr > 1 % kNN query, get patterns from training data
%     trainQueryType = 2;
%     halfHalfFlg = 1;
%     kCurr = kCurr + 1;
%     ConstTrainQuerySet6;
%     queryResults2 = queryResults;
%     halfHalfFlg = 0;
%     kCurr = kCurr - 1;
% end

tTest = tic;

% Construct the query (test) matrix and populate with features
disp(['Construct query (test) matrix']);
trainQueryType = 2;
if classifierCurr == 1
    if batchFlg == 1
        ConstTrainQuerySet2B;
    else
        ConstTrainQuerySet2;
    end
elseif classifierCurr == 2 % NN or kNN
    if kCurr == 1 % NN
        if size(trajFeatureCurr,2) == 1 % single feature traj
            if batchFlg == 1
                ConstTrainQuerySet3B;
            else
                ConstTrainQuerySet3;
            end
        else % multi feature traj
            ConstTrainQuerySet5;
        end
    else % kNN
        if size(trajFeatureCurr,2) == 1 % single feature traj
            ConstTrainQuerySet4;
        else % kNN-multi feature traj
            ConstTrainQuerySet6;
        end
    end
end

timeTest = timeTest + toc(tTest);