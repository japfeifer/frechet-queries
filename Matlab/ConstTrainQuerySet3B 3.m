% ConstTrainQuerySet3B - batch mode
% Do NN searches

if trainMethodCurr == 3 % shift one method
    shiftVal = 1;
else
    shiftVal = 0;
end

if distType == 3 && trainQueryType == 1 % continuous Frechet
    % build the CCT when processing training set, or doing half/half method

    % populate trajStrData with trainSet trajectories
    cnt = 1;
    trajStrData = [];
    if halfHalfFlg == 2
        numTraj = size(trainSet2,1);
    else
        numTraj = size(trainSet,1);
    end
    for i=1:numTraj
        if halfHalfFlg == 2
            P = cell2mat(trainSet2(i,3));
        else
            P = cell2mat(trainSet(i,3));
        end
        % store the new traj
        trajStrData(cnt).traj = P;
        tmpTrajStartEnd = [P(1,:); P(end,:)];
        trajStrData(cnt).se = tmpTrajStartEnd;
        cnt = cnt + 1;
    end        
    TrajDataPreprocessing;

    % construct CCT
    if ConstructCCTType == 1
        disp(['Construct Gonzalez Lite CCT']);
        ConstructCCTGonzLite;
    else
        disp(['Construct Approx Radii CCT']);
        ConstructCCTApproxRadii;
    end  
end

if distType == 3 && trainQueryType == 2 % continuous Frechet
    % populate queryTraj
    cnt = 1;
    queryTraj = {[]};

    if trainQueryType == 1
        if halfHalfFlg == 1
            numTraj = size(trainSet2,1);
        else
            numTraj = size(trainSet,1);
        end
    else
        numTraj = size(querySet,1);
    end
    for i=1:numTraj
        if trainQueryType == 1
            if halfHalfFlg == 1
                P = cell2mat(trainSet2(i,3));
            else
                P = cell2mat(trainSet(i,3));
            end
        else
            P = cell2mat(querySet(i,3));
        end
        % store the new traj
        queryTraj(cnt,1) = mat2cell(P,size(P,1),size(P,2));
        tmpTrajStartEnd = [P(1,:); P(end,:)];
        queryTraj(cnt,2) = mat2cell(tmpTrajStartEnd,size(tmpTrajStartEnd,1),size(tmpTrajStartEnd,2));
        cnt = cnt + 1;
    end 
    QueryDataPreprocessing;
    % run kNN classifier
    eAdd = 0; eMult = 0;
    kNum = kCurr + shiftVal;
    if kNum > 1
        if implicitErrorFlg == 0
            disp(['Exact kNN Search']);
            kNNS2;
        else
            disp(['Implicit kNN Search']);
            kNNS3;
        end
    else % k = 1, so run the faster NN algo
        if implicitErrorFlg == 0
            disp(['Exact NN Search']);
            NNS2; 
        else
            disp(['Implicit NN Search']);
            NNS3;
        end
    end
end

if trainQueryType == 2

    % compute queryResults
    queryResults = [];
    if trainQueryType == 1
        if halfHalfFlg == 2
            szSet = size(trainSet2,1);
        else
            szSet = size(trainSet,1);
        end
    else
        szSet = size(querySet,1);
    end
    queryResults(1:szSet,1:7) = 0;
    wordIDs = cell2mat(trainSet(:,2));
    distResults2=[];
    distResults3={[]};
    parfor i = 1:szSet 
        distResults = [];
        distResultsTmp = [];
        if distType == 3 % get Frechet kNN distances
            distResults = cell2mat(queryTraj(i,12));
            distResults(1,2) = 0; % for this type of experiment, it is always NN, so only one result.
            if trainQueryType == 1
                numTrainDistComp = numTrainDistComp + cell2mat(queryTraj(i,10)); % queryTraj(i,10) contains number of cont Frechet distance calls for the query
            else
                numTestDistComp = numTestDistComp + cell2mat(queryTraj(i,10));
            end
            
        elseif distType == 1 || distType == 2 || distType == 4 % get kNN distances for DTW or disc Frechet or Edit Distance

            if trainQueryType == 1
                if halfHalfFlg == 2
                    Q = cell2mat(trainSet2(i,3));
                else
                    Q = cell2mat(trainSet(i,3));
                end
            else
                Q = cell2mat(querySet(i,3));
            end
            if trainQueryType == 1 && halfHalfFlg == 2
                szSet2 = size(trainSet2,1);
            else
                szSet2 = size(trainSet,1);
            end

            distResults(1:szSet2,1:2) = 0;
            if distType == 1 || distType == 4  % do standard for loop for DTW and Edit Distance
                if trainQueryType == 1 && halfHalfFlg == 2
                    for j=1:szSet2 % had to break up parfor into 2 separate parfor statements due to a weird error
                        P = cell2mat(trainSet2(j,3));
                        dist = 0;
                        if distType == 1
                            dist = dtw(P',Q','euclidean'); % get the DTW distance, using euclidean metric
                        elseif distType == 4  % get the edit distance
                            dist = edr(P',Q',edrTol);
                        end
                        distResults(j,:) = [j dist];
                        numTrainDistComp = numTrainDistComp + 1;
                    end
                else  
                    for j=1:szSet2  
                        P = cell2mat(trainSet(j,3));
                        dist = 0;
                        if distType == 1
                            dist = dtw(P',Q','euclidean'); % get the DTW distance, using euclidean metric
                        elseif distType == 4  % get the edit distance
                            dist = edr(P',Q',edrTol);
                        end
                        distResults(j,:) = [j dist];
                        numTestDistComp = numTestDistComp + 1;
                    end
                end  
            else  
                if trainQueryType == 1 && halfHalfFlg == 2
                    for j=1:szSet2 % had to break up parfor into 2 separate parfor statements due to a weird error
                        P = cell2mat(trainSet2(j,3));
                        dist = 0;
                        dist = DiscreteFrechetDist(P,Q); % get the discrete Frechet distance
                        distResults(j,:) = [j dist];
                        numTrainDistComp = numTrainDistComp + 1;
                    end
                else
                    for j=1:szSet2
                        P = cell2mat(trainSet(j,3));
                        dist = 0;
                        dist = DiscreteFrechetDist(P,Q); % get the discrete Frechet distance
                        distResults(j,:) = [j dist];
                        numTestDistComp = numTestDistComp + 1;
                    end
                end                
            end
            distResultsTmp = distResults;
            distResults = sortrows(distResults,2,'ascend'); % closest distance first
        end
        
        distResults2(i,:) = distResultsTmp(:,2)';
        distResults3(i,1) = mat2cell(distResults,size(distResults,1),size(distResults,2)); 
        
    end
    
    for i = 1:szSet
        distResults = cell2mat(distResults3(i,1));
        % store results in queryResults
        if trainQueryType == 1
            if halfHalfFlg == 2
                queryWordID = cell2mat(trainSet2(i,2));
                queryResults(i,1) = cell2mat(trainSet2(i,1)); % Query ID
            else
                queryWordID = cell2mat(trainSet(i,2));
                queryResults(i,1) = cell2mat(trainSet(i,1)); % Query ID
            end
        else
            queryWordID = cell2mat(querySet(i,2));
            queryResults(i,1) = cell2mat(querySet(i,1)); % Query ID
        end
        if trainQueryType == 1 && halfHalfFlg == 2
            queryResults(i,2) = cell2mat(trainSet2(distResults(1 + shiftVal,1),1)); % 1NN ID 
            queryResults(i,3) = cell2mat(trainSet2(find(wordIDs==queryWordID,1),1)); % Correct NN ID
        else
            queryResults(i,2) = cell2mat(trainSet(distResults(1 + shiftVal,1),1)); % 1NN ID 
            queryResults(i,3) = cell2mat(trainSet(find(wordIDs==queryWordID,1),1)); % Correct NN ID
        end

        queryResults(i,4) = queryWordID; % Query Word ID
        
        idx = 5;
        for j=1:kCurr
            if trainQueryType == 1 && halfHalfFlg == 2
                queryResults(i,j+idx) = cell2mat(trainSet2(distResults(j+shiftVal,1),2)); % kNN Word ID
            else
                queryResults(i,j+idx) = cell2mat(trainSet(distResults(j+shiftVal,1),2)); % kNN Word ID
            end
        end
        
        idx = idx + kCurr;
        for j=1:kCurr
            queryResults(i,j+idx) = distResults(j+shiftVal,2); % kNN distance
        end    
        
        queryResults(i,5) = queryResults(i,4) == queryResults(i,6); % kNN accuracy, 1 = same label, 0 = different label
        
    end
    
    queryResults(:,5) = queryResults(:,4) == queryResults(:,6); % kNN accuracy, 1 = same label, 0 = different label

    NNAccuracy = mean(queryResults(:,5)) * 100;
    disp(['NN mean accuracy: ',num2str(NNAccuracy)]);
end

