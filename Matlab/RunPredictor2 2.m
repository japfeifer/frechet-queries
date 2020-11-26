% run the predictor

disp(['Predictor ',num2str(predNum),' Extract Method ',num2str(exMethNum)]);

% get training set & query set high-dim traj for this Extract Method
for i = 1:size(trainSet,1) % training set
    idx = cell2mat(trainSet(i,1));
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
    end
    trainSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end

for i = 1:size(querySet,1) % query set
    idx = cell2mat(querySet(i,1));
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
    end
    querySet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end

% Construct the training matrix and populate with features
disp(['Construct training matrix']);
trainQueryType = 1; % process trainset data
ConstTrainQuerySet2;

% Construct the query (test) matrix and populate with features
disp(['Construct query (test) matrix']);
trainQueryType = 2;
ConstTrainQuerySet2;
