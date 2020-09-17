% Run the model

disp(['datasetType: ',num2str(datasetType), 'testType: ',num2str(testType),' rngSeed: ',num2str(rngSeed)]);
disp(['Baseline List:']);
% display the baselineList
baselineList

disp(['Variable List:']);
if testType == 1
    kList
elseif testType == 2
    numTrainList
elseif testType == 3
    distMeasTrajFeatList
elseif testType == 4
    classifierList
elseif testType == 5
    trainMethodList
elseif testType == 6
    seqNormalList
elseif testType == 7
    numTestList
elseif testType == 8    
    numBestTrainRepFlgList
end

for iHM = 1:size(baselineList,1) % for each baseline test, do:
    
    disp(['Baseline: ',num2str(iHM)]);
    
    % set current variables
    kCurr = cell2mat(baselineList(iHM,1));
    numTrainCurr = cell2mat(baselineList(iHM,2));
    distMeasCurr = cell2mat(baselineList{iHM,3}(1,1));
    trajFeatureCurr = cell2mat(baselineList{iHM,3}(1,2));
    classifierCurr = cell2mat(baselineList(iHM,4));
    trainMethodCurr = cell2mat(baselineList(iHM,5));
    seqNormalCurr = cell2mat(baselineList(iHM,6));
    numTestCurr = cell2mat(baselineList(iHM,7));
    bestTrainRepFlgCurr = cell2mat(baselineList(iHM,8));
    
    % determine number of tests: depends on the test type
    if testType == 1
        numTests = size(kList,1);
    elseif testType == 2
        numTests = size(numTrainList,1);
    elseif testType == 3
        numTests = size(distMeasTrajFeatList,1);
    elseif testType == 4
        numTests = size(classifierList,1);
    elseif testType == 5
        numTests = size(trainMethodList,1);
    elseif testType == 6
        numTests = size(seqNormalList,1);
    elseif testType == 7
        numTests = size(numTestList,1);
    elseif testType == 8
        numTests = size(numBestTrainRepFlgList,1);
    else
        numTests = 0;
    end
    
    for jHM = 1:numTests
        
        disp(['Test num: ',num2str(jHM)]);
        
        rng(rngSeed); % reset random seed so experiments are reproducable
        
        % assign test value to variable being tested
        if testType == 1
            kCurr = kList(jHM,1);
        elseif testType == 2
            numTrainCurr = numTrainList(jHM,1);
        elseif testType == 3
            distMeasCurr = cell2mat(distMeasTrajFeatList(jHM,1));
            trajFeatureCurr = cell2mat(distMeasTrajFeatList(jHM,2));
        elseif testType == 4
            classifierCurr = classifierList(jHM,1);
        elseif testType == 5
            trainMethodCurr = trainMethodList(jHM,1);
        elseif testType == 6
            seqNormalCurr = seqNormalList(jHM,:);
        elseif testType == 7
            numTestCurr = numTestList(jHM,1);
        elseif testType == 8
            bestTrainRepFlgCurr = numBestTrainRepFlgList(jHM,1);
        else
            error('Incorrect value in testType');
        end        
        
        RunSubModel; % compute the accuracy for this combination of variables
        
        resultList(iHM,jHM) = classAccuracy;
    end
end