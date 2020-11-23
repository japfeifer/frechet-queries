% take all sequences and split into the trainSet (and maybe trainSet2) and querySet

function SplitTrainQuery(pctTrain,pctTest,trainMethodCurr,bestTrainRepFlg,trainSub,testSub,trainSample,testSample,switchFlg,testSetClass,testSetList,keepTrainSetClass,testSetSub,trainSetSub)

    global trainSet trainSet2 querySet CompMoveData currHMTrainSet querySetKFold classifierCurr
    
    trainSet = {[]};
    trainSet2 = {[]};
    querySet = {[]};
    trainSetCnt = 1;
    trainSet2Cnt = 1;
    querySetCnt = 1;
    
    disp(['Create training and testing sequences']);
    tTrainTestSeqPrep = tic;
    
    CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
    
    allClasses = CompMoveData(:,1);
    classes = unique(allClasses); % list of unique classes

    if pctTrain == -2 % k-fold validation
        querySetID = querySetKFold(currHMTrainSet,:); % train set pre-computed in CreateTrainSets
        querySetID(querySetID==0) = []; % remove any potential zeros
        
        for j = 1:size(CompMoveData,1) % process each item in allClasses list
            if (ismember(j,querySetID) == true && switchFlg == 0) || ...
                (ismember(j,querySetID) == false && switchFlg == 1)    % put this one in the querySet
                querySet(querySetCnt,1) = {j}; % source id
                querySet(querySetCnt,2) = CompMoveData(j,5); % class ID 
                querySetCnt = querySetCnt + 1; 
            else % put this one in the trainSet
                trainSet(trainSetCnt,1) = {j}; % source id
                trainSet(trainSetCnt,2) = CompMoveData(j,5); % class ID
                trainSetCnt = trainSetCnt + 1;        
            end
        end
        
    else  
        for i = 1:size(classes,1) % process each unique class
            classIDs = find(ismember(allClasses,classes(i))); % get list of class ID's for this unique class label

            % get train set id's for this class
            if pctTrain > 0 
                % determine numTrain
                if pctTrain < 1 % numTrain is a percentage of the seq in this class
                    numTrain = floor(size(classIDs,1) * pctTrain);
                    if numTrain < 1
                        numTrain = 1; % must have a min of 1 seq to train
                    end
                else % numTrain is the integer value in pctTrain
                    numTrain = floor(pctTrain);
                end
                % the half/half method must have at least 2 trainers per class
                if trainMethodCurr == 2 && numTrain < 2 
                    numTrain = 2;
                end
                % randomly choose indexes without replacement from classIDs list
                [tmpValue,trainSetID] = datasample(classIDs,numTrain,'Replace',false); 
            elseif pctTrain == -1 % choose a number of samples (trainSample) for each subject (trainSub) 
                trainSetID = [];
                classIDs2 = [];
                for j = 1:size(classIDs,1) % get subject number
                    [garbage subjectNum] = strtok(cell2mat(CompMoveData(classIDs(j),2)));
                    subjectNum = str2num(subjectNum);
                    classIDs2(j,:) = [classIDs(j) subjectNum];
                end
                allSub = classIDs2(:,2);
                uniqueSub = unique(allSub); % list of unique subjects
                for k = 1:size(uniqueSub,1) % process each unique subject
                    if ismember(uniqueSub(k),trainSub) % only process subjects in trainSub
                        currClassIDs = find(ismember(allSub,uniqueSub(k))); % get list of class ID's for this unique subject
                        % randomly choose one from currClassIDs list
                        if trainSample == 0
                            currSz = size(currClassIDs,1);
                        elseif isempty(keepTrainSetClass) == 0 && ismember(i,keepTrainSetClass) == 1
                            currSz = size(currClassIDs,1);
                        else
                            currSz = trainSample;
                        end
                        sampleSz = min(currSz,size(currClassIDs,1));
                        [tmpID,garbage] = datasample(currClassIDs,sampleSz,'Replace',false);
                        tmpID = tmpID';
                        trainSetID(end+1:end+size(tmpID,2)) = tmpID; % append result to trainSetID list
                    end
                end
            elseif pctTrain == -2 % k-fold validation
                trainSetID = querySetKFold(currHMTrainSet); % train set pre-computed in CreateTrainSets
                trainSetID(trainSetID==0) = []; % remove any potential zeros
            end

            % get test set id's for this class
            newClassIDs = [];
            for j = 1:size(classIDs,1) % get potential test set id's
                if ismember(j,trainSetID) == false
                    newClassIDs(end+1,:) = j;
                end
            end

            if pctTest == 0 % just choose all the potential test set id's
                testSetID = newClassIDs';
            elseif pctTest > 0
                if pctTest < 1 % numTrain is a percentage of the seq in this class
                    numTrain = floor(size(classIDs,1) * pctTest);
                    if numTrain < 1
                        numTrain = 1; % must have a min of 1 seq to train
                    end
                else % numTrain is the integer value in pctTrain
                    numTrain = floor(pctTest);
                end
                if numTrain > size(newClassIDs,1)
                    newClassIDs = size(newClassIDs,1);
                end
                testSetID = datasample(newClassIDs,numTrain,'Replace',false);
                testSetID = testSetID';
            elseif pctTest == -1 % choose a number of samples (testSample) for each subject (testSub) 
                testSetID = [];
                classIDs2 = [];
                for j = 1:size(classIDs,1) % get subject number
                    [garbage subjectNum] = strtok(cell2mat(CompMoveData(classIDs(j),2)));
                    subjectNum = str2num(subjectNum);
                    classIDs2(j,:) = [classIDs(j) subjectNum];
                end
                allSub = classIDs2(:,2);
                uniqueSub = unique(allSub); % list of unique subjects
                for k = 1:size(uniqueSub,1) % process each unique subject
                    if ismember(uniqueSub(k),testSub) % only process subjects in testSub
                        currClassIDs = find(ismember(allSub,uniqueSub(k))); % get list of class ID's for this unique subject
                        % randomly choose one from currClassIDs list
                        if testSample == 0
                            currSz = size(currClassIDs,1);
                        else
                            currSz = testSample;
                        end
                        sampleSz = min(currSz,size(currClassIDs,1));
                        [tmpID,garbage] = datasample(currClassIDs,sampleSz,'Replace',false);
                        tmpID = tmpID';
                        testSetID(end+1:end+size(tmpID,2)) = tmpID; % append result to testSetID list
                    end
                end
            end

            if trainMethodCurr == 2 % half/half method
                % choose half of the seq from training set for the inputSet
                halfSet = floor(size(trainSetID,2) / 2);
                trainSetID1 = trainSetID(:,1:halfSet);
                trainSetID2 = trainSetID(:,halfSet+1:end);
                trainSetID = trainSetID1;
            else
                trainSetID2 = [];
            end

            if bestTrainRepFlg == 1 % use the best center as the trainer
                trainSetID = GetBestTrainCluster(trainSetID,classIDs);
                if trainMethodCurr == 2 % half/half method
                    trainSetID2 = GetBestTrainCluster(trainSetID2,classIDs);
                end
            end

            % determine where to put the seq
            for j = 1:size(classIDs,1) % process each item in classIDs list
                if ismember(j,trainSetID) % put this one in the trainSet
                    trainSet(trainSetCnt,1) = num2cell(classIDs(j)); % source id
                    trainSet(trainSetCnt,2) = CompMoveData(classIDs(j),5); % class
                    trainSetCnt = trainSetCnt + 1;
                elseif ismember(j,trainSetID2) % put this one in the trainSet
                    trainSet2(trainSet2Cnt,1) = num2cell(classIDs(j)); % source id
                    trainSet2(trainSet2Cnt,2) = CompMoveData(classIDs(j),5); % class
                    trainSet2Cnt = trainSet2Cnt + 1;
                elseif ismember(j,testSetID) % put this one in the querySet
                    querySet(querySetCnt,1) = num2cell(classIDs(j)); % source id
                    querySet(querySetCnt,2) = CompMoveData(classIDs(j),5); % class           
                    querySetCnt = querySetCnt + 1;            
                end
            end
        end
    end
    
    % if subspace discriminant, and only 1 seq per class, then duplicate the last 
    % seq in the training set - subspace discriminant requires
    % that there are more trainers than classes.
    if classifierCurr == 1 && size(classes,1) == size(trainSet,1)
        trainSet(end+1,:) = trainSet(end,:);  
    end
    
    if isempty(testSetClass) == 0 % only include certain classes in test set
        querySetTmp = {[]};
        cnt = 1;
        for i = 1:size(querySet,1)
            currClassID = cell2mat(querySet(i,2));
            if ismember(currClassID,testSetClass) == 1
                querySetTmp(cnt,1) = querySet(i,1);
                querySetTmp(cnt,2) = querySet(i,2);
                cnt = cnt + 1;
            end
        end
        querySet = querySetTmp;
    end
    
    if isempty(testSetSub) == 0 % only include certain subjects in test set
        querySetTmp = {[]};
        cnt = 1;
        for i = 1:size(querySet,1)
            currCompMoveID = cell2mat(querySet(i,1));
            currSubID = cell2mat(CompMoveData(currCompMoveID,3));
            if ismember(currSubID,testSetSub) == 1
                querySetTmp(cnt,1) = querySet(i,1);
                querySetTmp(cnt,2) = querySet(i,2);
                cnt = cnt + 1;
            end
        end
        querySet = querySetTmp;
    end    

    if isempty(trainSetSub) == 0 % only include certain subjects in test set
        trainSetTmp = {[]};
        cnt = 1;
        for i = 1:size(trainSet,1)
            currCompMoveID = cell2mat(trainSet(i,1));
            currSubID = cell2mat(CompMoveData(currCompMoveID,3));
            if ismember(currSubID,trainSetSub) == 1
                trainSetTmp(cnt,1) = trainSet(i,1);
                trainSetTmp(cnt,2) = trainSet(i,2);
                cnt = cnt + 1;
            end
        end
        trainSet = trainSetTmp;
        end 
    
    if isempty(testSetList) == 0
        querySet = {[]};
        for i = 1:size(testSetList,2)
            querySet(i,1) = num2cell(testSetList(1,i));
            querySet(i,2) = CompMoveData(testSetList(1,i),5);
        end
    end
    
    timeTrainTestSeqPrep = toc(tTrainTestSeqPrep);
    disp(['Create training and testing sequences time: ',num2str(timeTrainTestSeqPrep)]);

end
