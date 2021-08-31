% get new training and testing matrices

aggDefStr2 = aggDefStr;
tmpIdx = find(mapCanonJts(:,1) == currJt);
bodyJt = mapCanonJts(tmpIdx,2);
isUsedFlg = cell2mat(aggDefStr2(bodyJt,1));
newTrainMat = [];
newTestMat = [];

if isUsedFlg == 0 % this joint currently does not have a DM 
    aggDefStr2(bodyJt,1) = {1}; % set isUsedFlg to 1

    % find the traj in the precompMat
    for iNTT = 1:size(precompMat,1)
        tmpDef = cell2mat(precompMat(iNTT,1));
        if tmpDef == currJt
            tmpTrainMat =  cell2mat(precompMat(iNTT,3));
            tmpTestMat = cell2mat(precompMat(iNTT,5));
            break
        end
    end
    aggDefStr2(bodyJt,2) = mat2cell(currJt,size(currJt,1),size(currJt,2));
    aggDefStr2(bodyJt,3) = mat2cell(tmpTrainMat,size(tmpTrainMat,1),size(tmpTrainMat,2));
    aggDefStr2(bodyJt,4) = mat2cell(tmpTestMat,size(tmpTestMat,1),size(tmpTestMat,2));

else % append currJt to existing Jts and create new DM

    existJts = cell2mat(aggDefStr2(bodyJt,2));
    thisDef = [existJts currJt];
    
    % get training set & query set high-dim traj for this Extract Method
    idxList = cell2mat(trainSet(:,1));
    for i = 1:size(trainSet,1) % training set
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
        elseif datasetType == 7 || datasetType == 8
            seq = MSASLExtractFeatures2(seq,thisDef);
        end
        if reachPctCurr > 0 % simplify the curve
            reach = TrajReach(seq); % get traj reach 
            seq = TrajSimp(seq,reach * reachPctCurr);
        end
        trainSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
    end

    idxList = cell2mat(querySet(:,1));
    for i = 1:size(querySet,1) % query set
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
        elseif datasetType == 7 || datasetType == 8
            seq = MSASLExtractFeatures2(seq,thisDef);
        end
        if reachPctCurr > 0 % simplify the curve
            reach = TrajReach(seq); % get traj reach 
            seq = TrajSimp(seq,reach * reachPctCurr);
        end
        querySet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
    end

    idxList = cell2mat(featureSet(:,1));
    for i = 1:size(featureSet,1) % feature set
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
        elseif datasetType == 7 || datasetType == 8
            seq = MSASLExtractFeatures2(seq,thisDef);
        end
        if reachPctCurr > 0 % simplify the curve
            reach = TrajReach(seq); % get traj reach 
            seq = TrajSimp(seq,reach * reachPctCurr);
        end
        featureSet(i,3) = mat2cell(seq,size(seq,1),size(seq,2));
    end
    
    timeSeqPrep = timeSeqPrep + toc(tSeqPrep);

    if classifierCurr == 2
        if trainMethodCurr == 2 % half half method
            halfHalfFlg = 1; % trainset is training data, trainset2 is query data
        else
            halfHalfFlg = 0; % trainset is both training and query data
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
            ConstTrainQuerySet4;
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
            ConstTrainQuerySet4;
        end
    end

    timeTest = timeTest + toc(tTest);   
    
    aggDefStr2(bodyJt,2) = mat2cell(thisDef,size(thisDef,1),size(thisDef,2));
    aggDefStr2(bodyJt,3) = mat2cell(trainMat,size(trainMat,1),size(trainMat,2));
    aggDefStr2(bodyJt,4) = mat2cell(testMat,size(testMat,1),size(testMat,2));

end

% glue DM's together for body joints that have a DM
for iNTT = 1:size(aggDefStr2,1)
    if cell2mat(aggDefStr2(iNTT,1)) == 1 % thisbody joint is used
        newTrainMat = [newTrainMat cell2mat(aggDefStr2(iNTT,3))];
        newTestMat = [newTestMat cell2mat(aggDefStr2(iNTT,4))];
    end
end

trainMat = newTrainMat;
testMat = newTestMat;

% for iNTT = 1:size(aggDefStr2,1)
%     isUsedFlg = cell2mat(aggDefStr2(iNTT,1));
%     if isUsedFlg == 1
%         disp(['Body Joint: ',num2str(iNTT),'  Joint Ids: ',num2str(cell2mat(aggDefStr2(iNTT,2)))]);
%     end
% end