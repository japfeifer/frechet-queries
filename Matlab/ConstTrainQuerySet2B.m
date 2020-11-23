% ConstTrainSet2B *** Batch mode
% Construct the training or test matrix and populate with features
  
szFeatureSet = size(featureSet,1);
if trainQueryType == 1
    szSet = size(trainSet,1);
    colMat = size(trainMat,2);
    trainMat(1:szSet,colMat+1:colMat+szFeatureSet) = 0; % pre-allocate matrix space (faster processing)
else
    szSet = size(querySet,1);
    colMat = size(testMat,2);
    testMat(1:szSet,colMat+1:colMat+szFeatureSet) = 0; % pre-allocate matrix space (faster processing)
end

totCells = szSet * szFeatureSet;
distList(1,1:totCells) = 0;

parfor i = 1:totCells
    currRow = floor((i - 1) / szFeatureSet) + 1;
    currCol = mod(i,szFeatureSet);
    if currCol == 0
        currCol = szFeatureSet;
    end
    
    if trainQueryType == 1
        Q = cell2mat(trainSet(currRow,3));
    else
        Q = cell2mat(querySet(currRow,3));
    end

    P = cell2mat(featureSet(currCol,3));
    
    if distType == 1
        if doDMDistFlg == 0
            distList(1,i) = dtw(P',Q','euclidean'); % get the DTW distance, using euclidean metric
        else
            if trainQueryType == 1
                QFrame = cell2mat(trainSet(currRow,4));
            else
                QFrame = cell2mat(querySet(currRow,4));
            end
            PFrame = cell2mat(featureSet(currCol,4));

            currBestDist = Inf;
            for j = 1:size(QFrame,1)
                sF = QFrame(j,1);  eF = QFrame(j,2);
                Q2 = Q(sF:eF,:);
                for k = 1:size(PFrame,1)
                    sF = PFrame(k,1);  eF = PFrame(k,2);
                    P2 = P(sF:eF,:);
                    currDist = dtw(P2',Q2','euclidean');
                    if currDist < currBestDist
                        currBestDist = currDist;
                    end
                end
            end
            distList(1,i) = currBestDist;
        end
    elseif distType == 2
        distList(1,i) = DiscreteFrechetDist(P,Q); % get the discrete Frechet distance
    elseif distType == 3
        distList(1,i) = ContFrechet(P,Q); % get the continuous Frechet distance
    elseif distType == 4
        distList(1,i) = edr(P',Q',edrTol);
    elseif distType == 5
        distList(1,i) = HausdorffDistSum(P,Q);
    elseif distType == 6
        distList(1,i) = MeanDTW(P,Q);
    elseif distType == 7
        distList(1,i) = MedianDTW(P,Q);
    elseif distType == 8
        distList(1,i) = StdDTW(P,Q);
    end
    
    if trainQueryType == 1
        numTrainDistComp = numTrainDistComp + 1;
    else
        numTestDistComp = numTestDistComp + 1;
    end
                    
end

for i = 1:szSet
    
    idx2 = i * szFeatureSet;
    idx1 = idx2 - szFeatureSet + 1;
    
    if trainQueryType == 1
        trainMat(i,colMat+1 : colMat+szFeatureSet) = distList(1,idx1:idx2);
    else
        testMat(i,colMat+1 : colMat+szFeatureSet) = distList(1,idx1:idx2);
    end
    
end

% put results in trainLabels, trainMat, and trainMatDist, or in
% testLabels, testMat, and testMatDist
if trainQueryType == 1
    trainLabels = cell2mat(trainSet(:,2));
else
    testLabels = cell2mat(querySet(:,2));
end

