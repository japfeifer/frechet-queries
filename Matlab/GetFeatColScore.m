% test for computing feature scores

szTrainMat = size(trainMat,2);
szFeatSet = size(featureSet,1);
featScore = [];
featScore(1:szTrainMat,1) = 0;
trainSeqInfo = cell2mat(trainSet(:,1:2));
trainSeqClasses = unique(trainSeqInfo(:,2));
szTrainSeqCla = size(trainSeqClasses,1);

for i = 1:szTrainMat % for each feature col
    featSetID = mod(i, szFeatSet);
    if featSetID == 0
        featSetID = szFeatSet;
    end
    currFeatSetClass = cell2mat(featureSet(featSetID,2));
    currFeatCol = trainMat(:,i);
    trainSeqClaMean = [];
    trainSeqClaMean(1:szTrainSeqCla,1) = 0;
    for j = 1:szTrainSeqCla
        x = [trainSeqInfo currFeatCol];
        y = x(x(:,2)==trainSeqClasses(j,1), :);
        trainSeqClaMean(j,1) = mean(y(:,3));
    end
    x = [trainSeqClasses trainSeqClaMean];
    x = sortrows(x,[2],'ascend');
    if currFeatSetClass == x(1,1) % the closest in train seq is the curr feature
        y = (x(2,2) - x(1,2)) / x(1,2);
        featScore(i,1) = y;
    end
end

trainSeqInfo2 = [];
for i = 1: szTrainMat/szFeatSet
    trainSeqInfo2 = [trainSeqInfo2;trainSeqInfo];
end
trainSeqInfo2 = [(1:size(trainSeqInfo2,1))' trainSeqInfo2];
trainSeqInfo2 = [trainSeqInfo2 featScore];

trainMat2 = [];
testMat2 = [];
testMatClasses = [];
idx = 1;
for i = 1:szTrainSeqCla
    y = trainSeqInfo2(trainSeqInfo2(:,3)==trainSeqClasses(i,1), :);
    y = sortrows(y,[4],'descend');
    for j = 1:size(y,1)
        if y(j,4) > 0
            trainMat2(:,idx) = trainMat(:,y(j,1));
            testMat2(:,idx) = testMat(:,y(j,1));
            testMatClasses(1,end+1) = y(j,3);
            idx = idx + 1;
        end
    end
    
%     for j = 1:5
%         trainMat2(:,idx) = trainMat(:,y(j,1));
%         testMat2(:,idx) = testMat(:,y(j,1));
%         idx = idx + 1;
%     end
    
end
