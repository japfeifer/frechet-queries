% ConstTrainSet
% Construct the training or test matrix and populate with features
 
if trainQueryType == 1
    szSet = size(trainSet,1);
    colMat = size(trainMat,2);
else
    szSet = size(querySet,1);
    colMat = size(testMat,2);
end

szFeatureSet = size(featureSet,1);
h = waitbar(0, 'Construct Matrix');

for i = 1:szSet  
    if trainQueryType == 1
        Q = cell2mat(trainSet(i,3));
    else
        Q = cell2mat(querySet(i,3));
    end
    a = [];
    if normDistCurr == 1
        a = zeros(1,szFeatureSet);
    else
        a(1:szFeatureSet) = 1;
    end
    b = [];
    for j=1:szFeatureSet
        P = cell2mat(trainSet(featureSet(j),3));
        if distType == 1
            dist = dtw(P',Q','euclidean'); % get the DTW distance, using euclidean metric
        elseif distType == 2
            dist = DiscreteFrechetDist(P,Q); % get the discrete Frechet distance
        elseif distType == 3
            dist = GetBestConstLBLessBnd(P,Q); % Get FrechetLB
%             dist = GetBestConstLB(P,Q); % Lower bound
        elseif distType == 4
            dist = ApproxDiscFrechetDiag(P,Q);
%             dist = GetBestUpperBound(P,Q); % get best Frechet UB
        elseif distType == 5
            distA = GetBestConstLBLessBnd(P,Q); % Get FrechetLB
            distB = ApproxDiscFrechetDiag(P,Q);
%             distB = GetBestUpperBound(P,Q); % get best Frechet UB
            dist = (distA + distB) / 2;
        end
        if normDistCurr == 1
            dist = 1 - (dist / (dist + 1)); % normalize dist between 0 and 1 (1 is closer, 0 is further)
        end
        b(j,:) = [j dist];
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
    X = ['Construct Matrix: ',num2str(i),'/',num2str(szSet)];
    waitbar(i/szSet, h, X);
end
close(h);

% put results in trainLabels, trainMat, and trainMatDist, or in
% testLabels, testMat, and testMatDist
if trainQueryType == 1
    trainLabels = cell2mat(trainSet(:,2));
else
    testLabels = cell2mat(querySet(:,2));
end

