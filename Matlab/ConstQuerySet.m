% ConstTrainSet
% Construct the query matrix and populate with features

if trainMethodCurr == 3 % shift one method
    shiftVal = 1;
else
    shiftVal = 0;
end

if distType == 2 % Frechet distance
    % populate queryTraj
    cnt = 1;
    queryTraj = {[]};
    numTraj = size(querySet,1);
    for i=1:numTraj
        P = cell2mat(querySet(i,3));
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
    kNNS2;
end

% compute queryResults
queryResults = [];
szSet = size(querySet,1);
queryResults(1:szSet,1:7) = 0;
wordIDs = cell2mat(trainSet(:,2));
for i = 1:szSet
    if distType == 2 % get Frechet kNN distances
        distResults = cell2mat(queryTraj(i,12));
        Q = cell2mat(queryTraj(i,1));
        for j=1:size(distResults,1) 
            P = cell2mat(trajData(distResults(j),1));
            dist = ContFrechet(P,Q,1); % get Frechet distance
            distResults(j,2) = dist;
        end
        distResults = sortrows(distResults,2,'ascend'); % closest distance first
    elseif distType == 1 % get DTW kNN distances
        distResults = [];
        Q = cell2mat(trainSet(i,3));
        for j=1:size(trainSet,1)
            P = cell2mat(trainSet(j,3));
            dist = dtw(P',Q','euclidean'); % get the DTW distance, using euclidean metric
            distResults(end+1,:) = [j dist];
        end
        distResults = sortrows(distResults,2,'ascend'); % closest distance first
    end

    % store results
    queryWordID = cell2mat(querySet(i,2));
    queryResults(i,1) = cell2mat(querySet(i,1)); % Query ID
    queryResults(i,2) = cell2mat(trainSet(kNNResults(1,1),1)); % 1NN ID 
    queryResults(i,3) = cell2mat(trainSet(find(wordIDs==queryWordID,1),1)); % Correct NN ID
    queryResults(i,4) = queryWordID; % Query Word ID
    idx = 5;
    for j=1:kCurr
        queryResults(i,j+idx) = cell2mat(trainSet(kNNResults(j,1),2)); % kNN Word ID
    end
    idx = idx + kCurr;
    for j=1:kCurr
        queryResults(i,j+idx) = kNNResults(j,2); % distance
    end    
    queryResults(i,5) = queryResults(i,4) == queryResults(i,6); % Correct or Not
end

CompMoveAccuracy = mean(queryResults(:,9)) * 100;
disp(['--> Query set Frechet NN mean accuracy: ',num2str(CompMoveAccuracy)]);
