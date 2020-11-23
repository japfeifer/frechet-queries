% check with view (subject id) belongs to each set

for i = 1:size(featureSet,1)
    currID = cell2mat(featureSet(i,1));
    currView = cell2mat(CompMoveData(currID,3));
    featureSet(i,3) = {currView};
end

for i = 1:size(trainSet,1)
    currID = cell2mat(trainSet(i,1));
    currView = cell2mat(CompMoveData(currID,3));
    trainSet(i,3) = {currView};
end

for i = 1:size(querySet,1)
    currID = cell2mat(querySet(i,1));
    currView = cell2mat(CompMoveData(currID,3));
    querySet(i,3) = {currView};
end