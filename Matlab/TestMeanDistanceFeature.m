
if trainQueryType == 1
    currMat = trainMat;
else
    currMat = testMat;
end

newMat = [];
szfeatTempl = size(trajFeatureCurr,1);
numFeatCols = size(featureSet,1);
allFeatClasses = cell2mat(featureSet(:,2));
featClasses = unique(allFeatClasses); % list of unique classes

for i = 1:szfeatTempl
    idx2 = i * numFeatCols;
    idx1 = idx2 - numFeatCols + 1;
    tmpMat = currMat(:,idx1:idx2);
    for j = 1:size(featClasses,1)
        featIDs = find(ismember(allFeatClasses,featClasses(j))); % get list of class ID's for this unique class label
        meanValues = mean(tmpMat(:,featIDs'),2);
        medValues = median(tmpMat(:,featIDs'),2);
        stddevValues = std(tmpMat(:,featIDs'),0,2);
        minValues = min(tmpMat(:,featIDs'),[],2);
        maxValues = max(tmpMat(:,featIDs'),[],2);
        newMat = [newMat meanValues medValues stddevValues minValues maxValues];
    end
end

if trainQueryType == 1
    trainMat = newMat;
else
    testMat = newMat;
end