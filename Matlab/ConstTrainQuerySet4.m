% ConstTrainQuerySet4
% Do kNN searches

if trainMethodCurr == 3 % shift one method
    shiftVal = 1;
else
    shiftVal = 0;
end

if distType == 3 && trainQueryType == 1 % continuous Frechet
    % build the CCT when processing training set, or doing half/half method

    % populate trajData with trainSet trajectories
    cnt = 1;
    trajData = {[]};
    if halfHalfFlg == 2
        numTraj = size(trainSet2,1);
    else
        numTraj = size(trainSet,1);
    end
    trajData(numTraj,1:7) = {0}; % pre-populate trajData with nulls - performance improvement
    for i=1:numTraj
        if halfHalfFlg == 2
            P = cell2mat(trainSet2(i,3));
        else
            P = cell2mat(trainSet(i,3));
        end
        % store the new traj
        trajData(cnt,1) = mat2cell(P,size(P,1),size(P,2));
        tmpTrajStartEnd = [P(1,:); P(end,:)];
        trajData(cnt,2) = mat2cell(tmpTrajStartEnd,size(tmpTrajStartEnd,1),size(tmpTrajStartEnd,2));
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
    h = waitbar(0, 'NN Queries');

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
    for i = 1:szSet  
        if distType == 3 % get Frechet kNN distances
            distResults = cell2mat(queryTraj(i,12));
            if trainQueryType == 1
                numTrainDistComp = numTrainDistComp + cell2mat(queryTraj(i,10)); % queryTraj(i,10) contains number of cont Frechet distance calls for the query
            else
                numTestDistComp = numTestDistComp + cell2mat(queryTraj(i,10));
            end
            Q = cell2mat(queryTraj(i,1));
            for j=1:size(distResults,1) 
                P = cell2mat(trajData(distResults(j),1));
                dist = ContFrechet(P,Q,1); % get Frechet distance
                distResults(j,2) = dist;
            end
            distResults = sortrows(distResults,2,'ascend'); % closest distance first
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

            distResults = [];
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
            else  % parfor statement works faster for discrete frechet distance
                if trainQueryType == 1 && halfHalfFlg == 2
                    parfor j=1:szSet2 % had to break up parfor into 2 separate parfor statements due to a weird error
                        P = cell2mat(trainSet2(j,3));
                        dist = 0;
                        dist = DiscreteFrechetDist(P,Q); % get the discrete Frechet distance
                        distResults(j,:) = [j dist];
                        numTrainDistComp = numTrainDistComp + 1;
                    end
                else
                    parfor j=1:szSet2
                        P = cell2mat(trainSet(j,3));
                        dist = 0;
                        dist = DiscreteFrechetDist(P,Q); % get the discrete Frechet distance
                        distResults(j,:) = [j dist];
                        numTestDistComp = numTestDistComp + 1;
                    end
                end                
            end

            distResults = sortrows(distResults,2,'ascend'); % closest distance first
        end

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
        
        if mod(i,10) == 0
            X = ['NN Queries: ',num2str(i),'/',num2str(szSet)];
            waitbar(i/szSet, h, X);
        end
    end
    MajorityVote2; % compute the kNN result, put in queryResults(i,5)
    close(h);

    NNAccuracy = mean(queryResults(:,5)) * 100;
    disp(['kNN mean accuracy: ',num2str(NNAccuracy)]);
end

