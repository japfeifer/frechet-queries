% run the predictor - speedup enhancement for DM-m

acc_iter_def_curr = acc_iter_def;
lastBestAcc = 0;
lastBestDef = [];

if ~exist('reachPctCurr','var')
    reachPctCurr = 0;
end

if ~exist('batchFlg','var')
    batchFlg = 0;
end

if classifierCurr == 1 && trajDefTypeCurr == 2 % DM-m
    lastTrainMat = [];
    lastTrainMatDist = [];
    lastTrainLabels = [];
    lastTestMat = [];
    lastTestMatDist = [];
    lastTestLabels = [];
end

while isempty(acc_iter_def_curr) == false  % continue until the set of canonical sub-skeleton features is empty or accuracy is not improved
    
    currBestDef = [];
    curBestFeat = 0;

    for HMc = 1:size(acc_iter_def_curr,2) % find next-best canonical sub-skeleton feature
        
        trainMat = [];
        trainMatDist = [];
        trainLabels = [];
        trainMat2 = [];
        trainLabels2 = [];
        trainMatDist2 = [];
        testMat = [];
        testMatDist = [];
        testLabels = [];
        
        currDef = [lastBestDef acc_iter_def_curr(HMc)];  % test the accuracy with this particular set of canonical sub-skeleton features
        disp(['currDef: ',num2str(currDef)]);
        
        tSeqPrep = tic;
        
        % build the train/test matrices
        for kloop = 1:size(currDef,2)

            if trajDefTypeCurr == 1 
                thisDef = currDef;  % append all definitions
            else
                thisDef = currDef(kloop);  % insert one definition at a time
            end
            
            if classifierCurr == 2 && kCurr >= 1 && trajDefTypeCurr == 2 % NN or kNN - multi
                kHM = kloop;
                trajFeatureCurr = currDef;
            end
            
            if classifierCurr == 1 && trajDefTypeCurr == 2 % DM-m
                trainMat = lastTrainMat;
                trainMatDist = lastTrainMatDist;
                trainLabels = lastTrainLabels;
                testMat = lastTestMat;
                testMatDist = lastTestMatDist;
                testLabels = lastTestLabels;
                thisDef = currDef(size(currDef,2));  % just get last definition
            end

            % get training set & query set high-dim traj for this Extract Method
            idxList = cell2mat(trainSet(:,1));
            parfor i = 1:size(trainSet,1) % training set
%                 idx = cell2mat(trainSet(i,1));
                idx = idxList(i,1);
                seq = cell2mat(CompMoveData(idx,6));
                if datasetType == 1
                    seq = KinTransExtractFeatures2(seq,thisDef);
                elseif datasetType == 2
                    seq = MHADExtractFeatures2(seq,thisDef);
                elseif datasetType == 3
                    seq = LMExtractFeatures2(seq,thisDef,idx);
                elseif datasetType == 4
                    seq = UCFExtractFeatures2(seq,thisDef,idx);
                elseif datasetType == 5
                    seq = MSRDAExtractFeatures2(seq,thisDef);
                elseif datasetType == 6
                    seq = NTURGBDExtractFeatures2(seq,thisDef);
                elseif datasetType == 7
                    seq = MSASLExtractFeatures2(seq,thisDef);
                end
                if reachPctCurr > 0 % simplify the curve
                    reach = TrajReach(seq); % get traj reach 
                    seq = TrajSimp(seq,reach * reachPctCurr);
                end
                trainSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
            end

            if classifierCurr == 2
                if size(trainSet2,2) > 1 % trainSet2 is not empty
                    idxList = cell2mat(trainSet2(:,1));
                    parfor i = 1:size(trainSet2,1) % training set 2
%                         idx = cell2mat(trainSet2(i,1));
                        idx = idxList(i,1);
                        seq = cell2mat(CompMoveData(idx,6));
                        if datasetType == 1
                            seq = KinTransExtractFeatures2(seq,thisDef);
                        elseif datasetType ==2
                            seq = MHADExtractFeatures2(seq,thisDef);
                        elseif datasetType == 3
                            seq = LMExtractFeatures2(seq,thisDef,idx);
                        elseif datasetType == 4
                            seq = UCFExtractFeatures2(seq,thisDef,idx);
                        elseif datasetType == 5
                            seq = MSRDAExtractFeatures2(seq,thisDef);
                        elseif datasetType == 6
                            seq = NTURGBDExtractFeatures2(seq,thisDef);
                        elseif datasetType == 7
                            seq = MSASLExtractFeatures2(seq,thisDef);
                        end
                        if reachPctCurr > 0 % simplify the curve
                            reach = TrajReach(seq); % get traj reach 
                            seq = TrajSimp(seq,reach * reachPctCurr);
                        end
                        trainSet2(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
                    end
                end
            end

            idxList = cell2mat(querySet(:,1));
            parfor i = 1:size(querySet,1) % query set
%                 idx = cell2mat(querySet(i,1));
                idx = idxList(i,1);
                seq = cell2mat(CompMoveData(idx,6));
                if datasetType == 1
                    seq = KinTransExtractFeatures2(seq,thisDef);
                elseif datasetType ==2
                    seq = MHADExtractFeatures2(seq,thisDef);
                elseif datasetType == 3
                    seq = LMExtractFeatures2(seq,thisDef,idx);
                elseif datasetType == 4
                    seq = UCFExtractFeatures2(seq,thisDef,idx);
                elseif datasetType == 5
                    seq = MSRDAExtractFeatures2(seq,thisDef);
                elseif datasetType == 6
                    seq = NTURGBDExtractFeatures2(seq,thisDef);
                elseif datasetType == 7
                    seq = MSASLExtractFeatures2(seq,thisDef);
                end
                if reachPctCurr > 0 % simplify the curve
                    reach = TrajReach(seq); % get traj reach 
                    seq = TrajSimp(seq,reach * reachPctCurr);
                end
                querySet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
            end
            
            if classifierCurr == 1
                idxList = cell2mat(featureSet(:,1));
                parfor i = 1:size(featureSet,1) % feature set
    %                 idx = cell2mat(featureSet(i,1));
                    idx = idxList(i,1);
                    seq = cell2mat(CompMoveData(idx,6));
                    if datasetType == 1
                        seq = KinTransExtractFeatures2(seq,thisDef);
                    elseif datasetType ==2
                        seq = MHADExtractFeatures2(seq,thisDef);
                    elseif datasetType == 3
                        seq = LMExtractFeatures2(seq,thisDef,idx);
                    elseif datasetType == 4
                        seq = UCFExtractFeatures2(seq,thisDef,idx);
                    elseif datasetType == 5
                        seq = MSRDAExtractFeatures2(seq,thisDef);
                    elseif datasetType == 6
                        seq = NTURGBDExtractFeatures2(seq,thisDef);
                    elseif datasetType == 7
                        seq = MSASLExtractFeatures2(seq,thisDef);
                    end
                    if reachPctCurr > 0 % simplify the curve
                        reach = TrajReach(seq); % get traj reach 
                        seq = TrajSimp(seq,reach * reachPctCurr);
                    end
                    featureSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
                end
            end
            
            if ~exist('doDMDistFlg','var')
                doDMDistFlg = 0;
            end

            if doDMDistFlg == 1
                featureSet = DMDistSetupFnc(featureSet,numFrameDist,numFeatureDist);
                trainSet = DMDistSetupFnc(trainSet,numFrameDist,numTrainDist);
                querySet = DMDistSetupFnc(querySet,numFrameDist,numTestDist);
            end

            timeSeqPrep = timeSeqPrep + toc(tSeqPrep);

            if classifierCurr == 2
                if trainMethodCurr == 2 % half half method
                    halfHalfFlg = 1; % trainset is training data, trainset2 is query data
                else
                    halfHalfFlg = 0; % trainset is both training and query data
                end
            end

            tTrain = tic;

            % Construct the training matrix and populate with features
            disp(['Construct training matrix']);
            trainQueryType = 1; % process trainset data
            if classifierCurr == 1
                if batchFlg == 1
                    ConstTrainQuerySet2B;
                else
                    ConstTrainQuerySet2;
                end
            elseif classifierCurr == 2
                if kCurr == 1 % NN
                    if trajDefTypeCurr == 1
                        if batchFlg == 1
                            ConstTrainQuerySet3B;
                        else
                            ConstTrainQuerySet3;
                        end
                    else % multi feature traj
                        trajFeatureCurr = thisDef;
                        kHM = size(trajFeatureCurr,2);
                        ConstTrainQuerySet5;
                    end
                else % kNN
                    if trajDefTypeCurr == 1 % single feature traj
                        trajFeatureCurr = [1];
                        ConstTrainQuerySet4;
                    else % kNN-multi feature traj
                        trajFeatureCurr = thisDef;
                        kHM = size(trajFeatureCurr,2);
                        ConstTrainQuerySet6;
                    end
                end
            end

            timeTrain = timeTrain + toc(tTrain);

            tTest = tic;

            % Construct the query (test) matrix and populate with features
            disp(['Construct query (test) matrix']);
            trainQueryType = 2;
            if classifierCurr == 1 % SD
                if batchFlg == 1
                    ConstTrainQuerySet2B;
                else
                    ConstTrainQuerySet2;
                end
            elseif classifierCurr == 2
                if kCurr == 1 % NN
                    if trajDefTypeCurr == 1
                        if batchFlg == 1
                            ConstTrainQuerySet3B;
                        else
                            ConstTrainQuerySet3;
                        end
                    else % multi feature traj
                        trajFeatureCurr = thisDef;
                        kHM = size(trajFeatureCurr,2);
                        ConstTrainQuerySet5;
                    end
                else % kNN
                    if trajDefTypeCurr == 1 % single feature traj
                        trajFeatureCurr = [1];
                        ConstTrainQuerySet4;
                    else % kNN-multi feature traj
                        trajFeatureCurr = thisDef;
                        kHM = size(trajFeatureCurr,2);
                        ConstTrainQuerySet6;
                    end
                end
            end

            timeTest = timeTest + toc(tTest);  
            
            if trajDefTypeCurr == 1
                break;  % we only do the first for-loop for the single-trajectory
            end
            
            if classifierCurr == 1 && trajDefTypeCurr == 2 % DM-m
                break;  % we only do the first for-loop for the DM-m
            end
        end
        
%         if classifierCurr == 2 && kCurr == 1 && trajDefTypeCurr == 2 % NN - multi
%             MajorityVote3;
%             NNAccuracy = mean(queryResults(:,5)) * 100;
%             disp(['NN multi mean accuracy: ',num2str(NNAccuracy)]);
%         end
        
        if classifierCurr == 2 && trajDefTypeCurr == 2 % NN or kNN with multi feat traj
%             if kCurr == 1 % NN-m
%                 MajorityVote5; % just do majority vote
%             else % kNN-m
                MajorityVote6; % do weighted method for each traj feature, then majority vote on those results
%             end
%             if kNNmDistWeightFlg == 0
%                 MajorityVote5;
%             else
%                 MajorityVote4;
%             end
            NNAccuracy = mean(queryResults(:,5)) * 100;
            disp(['kNN multi mean accuracy: ',num2str(NNAccuracy)]);
        end

        if classifierCurr == 1  % ensemble method: subspace, learner type: discriminant

            rng(rngSeed); % reset random seed so experiments are reproducable

            numPredictor = floor(size(trainMat,2) / 2);

            if numLearner == 0
                numLearner = 50;
            end

            tTrain = tic;

            if classifierCurr == 1 && numTrainCurr == 1 && distType == 4
                t = templateDiscriminant('DiscrimType','diagLinear'); % subspace discriminant, edit distance, low trainers requires this type
            else
                t = templateDiscriminant('DiscrimType','linear');
            end

            Mdl = fitcensemble(...
                trainMat, ...
                trainLabels, ...
                'Method', 'Subspace', ...
                'NumLearningCycles', numLearner, ...
                'Learners', 'discriminant', ...
                'Learners',t, ...
                'NPredToSample', numPredictor);

            timeTrain = timeTrain + toc(tTrain);

            tTest = tic;

            classifierRes = predict(Mdl,testMat);

            % compute classifier accuracy
            classifierRes(:,2) = testLabels;
            classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
            classAccuracy = mean(classifierRes(:,3)) * 100;  
            disp(['Classification accuracy: ',num2str(classAccuracy)]);

            % store some results in queryResults
            queryResults = [];
            queryResults(1:szSet,1:7) = 0;
            trainWordIDs = cell2mat(trainSet(:,2));
            for i=1:size(querySet,1)
                trueTestClass = cell2mat(querySet(i,2)); % test true Class ID
                predTestClass = classifierRes(i,1); % Classifier predicted Query Class ID
                queryResults(i,1) = cell2mat(querySet(i,1)); % Query CompMoveData ID
                queryResults(i,2) = cell2mat(trainSet(find(trainWordIDs==predTestClass,1),1)); % Classifier predicted CompMoveData ID
                queryResults(i,3) = cell2mat(trainSet(find(trainWordIDs==trueTestClass,1),1)); % True CompMoveData ID
                queryResults(i,4) = trueTestClass; 
                queryResults(i,6) = predTestClass; 
                queryResults(i,5) = queryResults(i,4) == queryResults(i,6); % kNN accuracy, 1 = same label, 0 = different label
            end

            timeTest = timeTest + toc(tTest);
        end

        if classifierCurr == 2
            classAccuracy = NNAccuracy; 
        end
        
        if classAccuracy > lastBestAcc
            lastBestAcc = classAccuracy;
            currBestDef = currDef;
            currBestFeat = acc_iter_def_curr(HMc);
            
            if classifierCurr == 1 && trajDefTypeCurr == 2 % DM-m
                 currTrainMat = trainMat;
                 currTrainMatDist = trainMatDist;
                 currTrainLabels = trainLabels;
                 currTestMat = testMat;
                 currTestMatDist = testMatDist;
                 currTestLabels = testLabels;
            end
        end
    end
    
    if classifierCurr == 1 && trajDefTypeCurr == 2 % DM-m
        lastTrainMat = currTrainMat;
        lastTrainMatDist = currTrainMatDist;
        lastTrainLabels = currTrainLabels;
        lastTestMat = currTestMat;
        lastTestMatDist = currTestMatDist;
        lastTestLabels = currTestLabels;
    end
    
    if isempty(currBestDef) == false % the accuracy was improved
        lastBestDef = currBestDef;
        acc_iter_def_curr(acc_iter_def_curr == currBestFeat) = [];  % remove the best feature from the set
        disp(['Accuracy improved: ',num2str(lastBestAcc),' currBestDef: ',num2str(currBestDef)]);
    else
        break  % the accuracy was not improved, so stop searching
    end

end
