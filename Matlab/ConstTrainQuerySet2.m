% ConstTrainSet2
% Construct the training or test matrix and populate with features

szFeatureSet = size(featureSet,1);
if trainQueryType == 1
    szSet = size(trainSet,1);
    colMat = size(trainMat,2);
    trainMat(1:szSet,colMat+1:colMat+szFeatureSet) = 0; % pre-allocate matrix space (faster processing)
else
    szSet = size(querySet,1);
    colMat = size(testMat,2);
    testMat(1:szSet,colMat+1:colMat+szFeatureSet) = 0; % pre-allocate matrix space (faster processing)
end

h = waitbar(0, 'Construct Matrix');

for i = 1:szSet  
    if trainQueryType == 1
        Q = cell2mat(trainSet(i,3));
    else
        Q = cell2mat(querySet(i,3));
    end
    
    if datasetType == 60  % for comparing multiple subjects
        numSubQ = size(Q,2) / numCoordCurr;
    else
        numSubQ = 1;
    end
    
    a = [];
    if normDistCurr == 1
        a = zeros(1,szFeatureSet);
    else
        a(1:szFeatureSet) = 1;
    end
    b = [];
    
    % The discrete and continuous Frechet distances run faster with the
    % 'parfor' statement and the built-in DTW and ED run faster with the
    % standard 'for' statement.
    
    if distType == 1 || distType == 4  % do standard for loop
        for j=1:szFeatureSet
            P = cell2mat(featureSet(j,3));

            if datasetType == 60 
                numSubP = size(P,2) / numCoordCurr;
            else
                numSubP = 1;
            end

            dist = Inf;
            cdist = 0;
            for iq = 1:numSubQ
                if datasetType == 60
                    idx1 = iq*numCoordCurr - (numCoordCurr - 1);  idx2 = idx1 + (numCoordCurr - 1);
                    subQ = Q(:,idx1:idx2);
                else
                    subQ = Q;
                end
                for ip = 1:numSubP
                    if datasetType == 60
                        idx1 = ip*numCoordCurr - (numCoordCurr - 1);  idx2 = idx1 + (numCoordCurr - 1);
                        subP = P(:,idx1:idx2);
                    else
                        subP = P;
                    end
                    if distType == 1
                        cdist = dtw(subP',subQ','euclidean'); % get the DTW distance, using euclidean metric
                    elseif distType == 2
                        cdist = DiscreteFrechetDist(subP,subQ); % get the discrete Frechet distance
                    elseif distType == 3
                        cdist = ContFrechet(subP,subQ); % get the continuous Frechet distance
                    elseif distType == 4
                        cdist = edr(subP',subQ',edrTol);
                    elseif distType == 5
                        cdist = GetBestConstLBLessBnd(subP,subQ); % Get FrechetLB
            %             cdist = GetBestConstLB(subP,subQ); % Lower bound
                    elseif distType == 6
                        cdist = ApproxDiscFrechetDiag(subP,subQ);
            %             cdist = GetBestUpperBound(subP,subQ); % get best Frechet UB
                    elseif distType == 7
                        distA = GetBestConstLBLessBnd(subP,subQ); % Get FrechetLB
                        distB = ApproxDiscFrechetDiag(subP,subQ);
            %             distB = GetBestUpperBound(subP,subQ); % get best Frechet UB
                        cdist = (distA + distB) / 2;
                    end
                    if cdist < dist
                        dist = cdist;
                    end
                    if trainQueryType == 1
                        numTrainDistComp = numTrainDistComp + 1;
                    else
                        numTestDistComp = numTestDistComp + 1;
                    end
                end
            end
            if dist == Inf
                error('dist = Inf'); 
            end
            if normDistCurr == 1
                dist = 1 - (dist / (dist + 1)); % normalize dist between 0 and 1 (1 is closer, 0 is further)
            end
            b(j,:) = [j dist];
        end 
    else  % do parallel processing parfor loop
        parfor j=1:szFeatureSet
            P = cell2mat(featureSet(j,3));

            if datasetType == 60
                numSubP = size(P,2) / numCoordCurr;
            else
                numSubP = 1;
            end

            dist = Inf;
            cdist = 0;
            for iq = 1:numSubQ
                if datasetType == 60
                    idx1 = iq*numCoordCurr - (numCoordCurr - 1);  idx2 = idx1 + (numCoordCurr - 1);
                    subQ = Q(:,idx1:idx2);
                else
                    subQ = Q;
                end
                for ip = 1:numSubP
                    if datasetType == 60
                        idx1 = ip*numCoordCurr - (numCoordCurr - 1);  idx2 = idx1 + (numCoordCurr - 1);
                        subP = P(:,idx1:idx2);
                    else
                        subP = P;
                    end
                    if distType == 1
                        cdist = dtw(subP',subQ','euclidean'); % get the DTW distance, using euclidean metric
                    elseif distType == 2
                        cdist = DiscreteFrechetDist(subP,subQ); % get the discrete Frechet distance
                    elseif distType == 3
                        cdist = ContFrechet(subP,subQ); % get the continuous Frechet distance
                    elseif distType == 4
                        cdist = edr(subP',subQ',edrTol);
                    elseif distType == 5
                        cdist = GetBestConstLBLessBnd(subP,subQ); % Get FrechetLB
            %             cdist = GetBestConstLB(subP,subQ); % Lower bound
                    elseif distType == 6
                        cdist = ApproxDiscFrechetDiag(subP,subQ);
            %             cdist = GetBestUpperBound(subP,subQ); % get best Frechet UB
                    elseif distType == 7
                        distA = GetBestConstLBLessBnd(subP,subQ); % Get FrechetLB
                        distB = ApproxDiscFrechetDiag(subP,subQ);
            %             distB = GetBestUpperBound(subP,subQ); % get best Frechet UB
                        cdist = (distA + distB) / 2;
                    end
                    if cdist < dist
                        dist = cdist;
                    end
                    if trainQueryType == 1
                        numTrainDistComp = numTrainDistComp + 1; 
                    else
                        numTestDistComp = numTestDistComp + 1;
                    end
                end
            end
            if dist == Inf
                error('dist = Inf'); 
            end
            if normDistCurr == 1
                dist = 1 - (dist / (dist + 1)); % normalize dist between 0 and 1 (1 is closer, 0 is further)
            end
            b(j,:) = [j dist];
        end  
    end
    
    
    if normDistCurr == 1
        b = sortrows(b,[2],'descend');
    else
        b = sortrows(b,[2],'ascend');
    end
    if kCurr < 1
        cntK = szFeatureSet;
    else
        cntK = min(kCurr,szFeatureSet);
    end
    for j=1:cntK % assign top k distances
        a(b(j,1)) = b(j,2);
    end
    if trainQueryType == 1
        trainMat(i,colMat+1 : colMat+szFeatureSet) = a;
    else
        testMat(i,colMat+1 : colMat+szFeatureSet) = a;
    end
    if mod(i,10) == 0
        X = ['Construct Matrix: ',num2str(i),'/',num2str(szSet)];
        waitbar(i/szSet, h, X);
    end
end
close(h);

% put results in trainLabels, trainMat, and trainMatDist, or in
% testLabels, testMat, and testMatDist
if trainQueryType == 1
    trainLabels = cell2mat(trainSet(:,2));
else
    testLabels = cell2mat(querySet(:,2));
end

