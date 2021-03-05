% GetkNNmultiRes

tSeqPrep = tic;
% get training set & query set high-dim traj for this Extract Method
idxList = cell2mat(trainSet(:,1));
for i = 1:size(trainSet,1) % training set
    idx = idxList(i,1);
    seq = cell2mat(CompMoveData(idx,6));
    if datasetType == 1
        seq = KinTransExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 2
        seq = MHADExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 3
        seq = LMExtractFeatures2(seq,kNNFeatureCurr,idx);
    elseif datasetType == 4
        seq = UCFExtractFeatures2(seq,kNNFeatureCurr,idx);
    elseif datasetType == 5
        seq = MSRDAExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 6
        seq = NTURGBDExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 7
        seq = KineticsExtractFeatures2(seq,kNNFeatureCurr);
    end
    if reachPctCurr > 0 % simplify the curve
        reach = TrajReach(seq); % get traj reach 
        seq = TrajSimp(seq,reach * reachPctCurr);
    end
    trainSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end

idxList = cell2mat(querySet(:,1));
for i = 1:size(querySet,1) % query set
    idx = idxList(i,1);
    seq = cell2mat(CompMoveData(idx,6));
    if datasetType == 1
        seq = KinTransExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType ==2
        seq = MHADExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 3
        seq = LMExtractFeatures2(seq,kNNFeatureCurr,idx);
    elseif datasetType == 4
        seq = UCFExtractFeatures2(seq,kNNFeatureCurr,idx);
    elseif datasetType == 5
        seq = MSRDAExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 6
        seq = NTURGBDExtractFeatures2(seq,kNNFeatureCurr);
    elseif datasetType == 7
        seq = KineticsExtractFeatures2(seq,kNNFeatureCurr);
    end
    if reachPctCurr > 0 % simplify the curve
        reach = TrajReach(seq); % get traj reach 
        seq = TrajSimp(seq,reach * reachPctCurr);
    end
    querySet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end

timeSeqPrep = timeSeqPrep + toc(tSeqPrep);

if classifierCurr == 2
    if trainMethodCurr == 2 % half half method
        halfHalfFlg = 1; % trainset is training data, trainset2 is query data
    else
        halfHalfFlg = 0; % trainset is both training and query data
    end
end

% Construct the training matrix and populate with features
tTrain = tic;
disp(['Construct training matrix']);
trainQueryType = 1; % process trainset data
if kCurr == 1 % NN
    ConstTrainQuerySet5;
else
    ConstTrainQuerySet6;
end
timeTrain = timeTrain + toc(tTrain);

% Construct the query (test) matrix and populate with features
tTest = tic;
disp(['Construct query (test) matrix']);
trainQueryType = 2;
if kCurr == 1 % NN
    ConstTrainQuerySet5;
else
    ConstTrainQuerySet6;
end
timeTest = timeTest + toc(tTest);