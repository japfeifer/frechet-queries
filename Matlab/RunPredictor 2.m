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
    end
    trainSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end

if size(trainSet2,2) > 1 % trainSet2 is not empty
    for i = 1:size(trainSet2,1) % training set 2
        idx = cell2mat(trainSet2(i,1));
        seq = cell2mat(CompMoveData(idx,6));
        if datasetType == 1
            seq = KinTransExtractFeatures(seq,exMethNum);
        elseif datasetType ==2
            seq = MHADExtractFeatures(seq,exMethNum);
        elseif datasetType == 3
            seq = LMExtractFeatures(seq,exMethNum,idx);
        end
        trainSet2(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
    end
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
    end
    querySet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
end

if trainMethodCurr == 2 % half half method
    halfHalfFlg = 1; % trainset is training data, trainset2 is query data
else
    halfHalfFlg = 0; % trainset is both training and query data
end

% Construct the training matrix and populate with features
disp(['Construct training matrix']);
trainQueryType = 1; % process trainset data
ConstTrainQuerySet;

if trainMethodCurr == 2 % half half method, train the other half
    halfHalfFlg = 2; % trainset2 is training data, trainset is query data
    disp(['Construct training matrix, other half']);
    ConstTrainQuerySet;
    
    % append new results from other half
    trainMat = [trainMat; trainMat2];
    trainMatDist = [trainMatDist; trainMatDist2];
    trainLabels = [trainLabels; trainLabels2];
    trainSet = [trainSet; trainSet2];
    
    halfHalfFlg = 1; % set back to 1, so that it uses trainSet below
end

% Construct the query (test) matrix and populate with features
disp(['Construct query (test) matrix']);
trainQueryType = 2;
ConstTrainQuerySet;
