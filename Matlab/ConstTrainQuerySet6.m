% ConstTrainQuerySet6
% Do kNN searches
% Used by kNN-m , i.e. kNN - multi feature traj

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
    % populate queryStrData
    cnt = 1;
    queryStrData = [];

    if halfHalfFlg == 0
        numTraj = size(querySet,1);
    elseif halfHalfFlg == 1
        numTraj = size(trainSet,1);
    else % halfHalfFlg == 2
        numTraj = size(trainSet2,1);
    end

    for i=1:numTraj
        if halfHalfFlg == 0
            P = cell2mat(querySet(i,3));
        elseif halfHalfFlg == 1
            P = cell2mat(trainSet(i,3));
        else % halfHalfFlg == 2
            P = cell2mat(trainSet2(i,3));
        end
        % store the new traj
        queryStrData(cnt).traj = P;
        tmpTrajStartEnd = [P(1,:); P(end,:)];
        queryStrData(cnt).se = tmpTrajStartEnd;
        cnt = cnt + 1;
    end 
    QueryDataPreprocessing;
    % run kNN classifier
    eAdd = 0; eMult = 0;
    if kCurr > 1
        kNum = kCurr;
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
    if halfHalfFlg == 0
        szSet = size(querySet,1);
    elseif halfHalfFlg == 1
        szSet = size(trainSet,1);
    else % halfHalfFlg == 2
        szSet = size(trainSet2,1);
    end
    
    numTrajFeat = size(trajFeatureCurr,2);
    
    if ~exist('queryResults','var')
        queryResults(1:szSet,1:((numTrajFeat*kCurr*2) + 6)) = 0;
    end
    
    wordIDs = cell2mat(trainSet(:,2));
    for i = 1:szSet  
        if distType == 3 % get Frechet kNN distances
            distResults = queryStrData(i).decidetrajids;
            if trainQueryType == 1
                numTrainDistComp = numTrainDistComp + queryStrData(i).decidecfdcnt;
            else
                numTestDistComp = numTestDistComp + queryStrData(i).decidecfdcnt;
            end
            Q = queryStrData(i).traj;
            for j=1:size(distResults,1) 
                P = trajStrData(distResults(j)).traj;
                dist = ContFrechet(P,Q,2); % get Frechet distance
                distResults(j,2) = dist;
            end
            distResults = sortrows(distResults,2,'ascend'); % closest distance first
        elseif distType == 1 || distType == 2 || distType == 4 % get kNN distances for DTW or disc Frechet or Edit Distance

            if halfHalfFlg == 0
                Q = cell2mat(querySet(i,3));
            elseif halfHalfFlg == 1
                Q = cell2mat(trainSet(i,3));
            else % halfHalfFlg == 2
                Q = cell2mat(trainSet2(i,3));
            end

            if halfHalfFlg == 2
                szSet2 = size(trainSet2,1);
            else
                szSet2 = size(trainSet,1);
            end

            distResults = [];
            distResults(1:szSet2,1:2) = 0;
            if distType == 1 || distType == 4  % do standard for loop for DTW and Edit Distance
                if halfHalfFlg == 2
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
                if halfHalfFlg == 2
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
        if kHM == 1 % if first traj feat
            if halfHalfFlg == 0
                queryWordID = cell2mat(querySet(i,2));
                queryResults(i,1) = cell2mat(querySet(i,1)); % Query ID
            elseif halfHalfFlg == 1
                queryWordID = cell2mat(trainSet(i,2));
                queryResults(i,1) = cell2mat(trainSet(i,1)); % Query ID
            else % halfHalfFlg == 2
                queryWordID = cell2mat(trainSet2(i,2));
                queryResults(i,1) = cell2mat(trainSet2(i,1)); % Query ID
            end

            if halfHalfFlg == 2
                queryResults(i,2) = cell2mat(trainSet2(distResults(1,1),1)); % 1NN Seq ID 
                queryResults(i,3) = cell2mat(trainSet2(find(wordIDs==queryWordID,1),1)); % True NN Seq ID
            else
                queryResults(i,2) = cell2mat(trainSet(distResults(1,1),1)); % 1NN Seq ID 
                queryResults(i,3) = cell2mat(trainSet(find(wordIDs==queryWordID,1),1)); % True NN Seq ID
            end

            queryResults(i,4) = queryWordID; % True Word ID
        end
        
        idx = 5 + ((kHM*kCurr)-kCurr);
        for j=1:kCurr
            if halfHalfFlg == 2
                queryResults(i,j+idx) = cell2mat(trainSet2(distResults(j,1),2)); % kNN Word ID
            else
                queryResults(i,j+idx) = cell2mat(trainSet(distResults(j,1),2)); % kNN Word ID
            end
        end
        idx = 5 + ((kHM*kCurr)-kCurr) + (numTrajFeat*kCurr);
        for j=1:kCurr
            queryResults(i,j+idx) = distResults(j,2); % kNN distance
        end    
        
        if mod(i,10) == 0
            X = ['NN Queries: ',num2str(i),'/',num2str(szSet)];
            waitbar(i/szSet, h, X);
        end
    end
    close(h);

end

