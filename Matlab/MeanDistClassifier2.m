% mean distance classifier

szFeatSet = size(featureSet,1);
szTestMatRow = size(testMat2,1);
szTestMatCol = size(testMat2,2);
testLabels = cell2mat(querySet(:,2));

classifierRes(1:szTestMatRow,1) = 0;
featSetClasses = unique(testMatClasses);
rowRes2 = [];
for i = 1:szTestMatRow
    currRow = [testMatClasses; testMat2(i,:)];
    rowRes = [];
    trueTestClass = cell2mat(querySet(i,2));
    for j=1:size(featSetClasses,2)
        currClass = featSetClasses(1,j);
        currVals = currRow(:,currRow(1,:) == currClass);
        rowRes(j,1) = currClass;
        rowRes(j,2) = mean(currVals(2,:));
    end
    rowRes = sortrows(rowRes,2,'ascend'); % closest distance first
    classifierRes(i) = rowRes(1,1); % the predicted class
    rowRes2 = [rowRes2; rowRes];
end

classifierRes(:,2) = testLabels;
classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
classAccuracy = mean(classifierRes(:,3)) * 100;  
disp(['Classification accuracy: ',num2str(classAccuracy)]);
disp(['Test Seq correct: ',num2str(sum(classifierRes(:,3)))]);
disp(['Test Seq incorrect: ',num2str(size(classifierRes,1) - sum(classifierRes(:,3)))]);


