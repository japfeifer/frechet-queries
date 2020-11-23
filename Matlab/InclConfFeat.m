% include confidence features

confMat = [];
szFeatSet = size(featureSet,1);
for i = 1:size(trainSet,1)
    compID = cell2mat(trainSet(i,1));
    leftHandConf = cell2mat(CompMoveData(compID,10));
    rightHandConf = cell2mat(CompMoveData(compID,11));
    for j = 1:size(featureSet,1)
        compID2 = cell2mat(featureSet(j,1));
        leftHandConfFeat = cell2mat(CompMoveData(compID2,10));
        rightHandConfFeat = cell2mat(CompMoveData(compID2,11));
        confMat(i,j) = mean([leftHandConf leftHandConfFeat]);
        confMat(i,j+szFeatSet) = mean([rightHandConf rightHandConfFeat]);
    end
end

trainMat = [trainMat confMat];

confMat = [];
szFeatSet = size(featureSet,1);
for i = 1:size(querySet,1)
    compID = cell2mat(querySet(i,1));
    leftHandConf = cell2mat(CompMoveData(compID,10));
    rightHandConf = cell2mat(CompMoveData(compID,11));
    for j = 1:size(featureSet,1)
        compID2 = cell2mat(featureSet(j,1));
        leftHandConfFeat = cell2mat(CompMoveData(compID2,10));
        rightHandConfFeat = cell2mat(CompMoveData(compID2,11));
        confMat(i,j) = mean([leftHandConf leftHandConfFeat]);
        confMat(i,j+szFeatSet) = mean([rightHandConf rightHandConfFeat]);
    end
end

testMat = [testMat confMat];