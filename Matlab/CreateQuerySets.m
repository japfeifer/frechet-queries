% Create k-fold cross-validation training sets
% Do not separate based on subject

function CreateQuerySets(numSets)

    global CompMoveData querySetKFold
    
    querySetKFold = [];
    currEnd(1:numSets) = 0;
    CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
    allClasses = CompMoveData(:,1);
    classes = unique(allClasses); % list of unique classes

    for i = 1:size(classes,1) % process each unique class
        classIDs = find(ismember(allClasses,classes(i))); % get list of class ID's for this unique class label
        if size(classIDs,1) > 1
            numTrain = floor(size(classIDs,1) / numSets);
            if numTrain == 0
                numTrain = 1;
            end
            for j = 1:numSets
                if size(classIDs,1) > 0
                    if j == numSets % last set, just append remaining items in classIDs
                        querySetKFold(j,currEnd(j)+1 : currEnd(j) + size(classIDs,1)) = classIDs';
                        currEnd(j) = currEnd(j) + size(classIDs,1);
                    else
                        % randomly choose indexes without replacement from classIDs list
                        [trainSetID,garbage] = datasample(classIDs,numTrain,'Replace',false); 
                        trainSetID = trainSetID';
                        if size(trainSetID,2) > 0
                            querySetKFold(j,currEnd(j)+1 : currEnd(j) + size(trainSetID,2)) = trainSetID;
                        end
                        currEnd(j) = currEnd(j) + size(trainSetID,2);

                        % delete randomly chosen indexes from  classIDs list
                        newClassIDs = [];
                        for k = 1:size(classIDs,1) % get potential test set id's
                            if ismember(classIDs(k),trainSetID) == false
                                newClassIDs(end+1,:) = classIDs(k);
                            end
                        end
                        classIDs = newClassIDs;
                    end
                end
            end
        end
    end
end
