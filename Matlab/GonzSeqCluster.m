% Gonzalez seq cluster

k = 10; % number of clusters
currClusterID = 0;
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
    
trainSeqInfo = cell2mat(trainSet(:,1:2));
trainSeqInfo(:,3) = 0;
trainSeqClasses = unique(trainSeqInfo(:,2));
szTrainSeqCla = size(trainSeqClasses,1);
subClassList = [];

for i = 1:szTrainSeqCla
    currClusterID = currClusterID + 1;
    currClass = trainSeqClasses(i);
    x = [];
    x = trainSeqInfo(trainSeqInfo(:,2)==currClass, :);
    x(:,3) = currClusterID;
    x(:,4) = 0;
    x(:,5) = 0;
    currNonCenters = x(:,1);
    currCenterXID = randi(size(currNonCenters,1),1);
    currCenterID = x(currCenterXID,1);
    x(currCenterXID,4) = 1;
    
    % get distances
    P = cell2mat(CompMoveData(currCenterID,4)); 
    P = NTURGBDNormalizeSeq(P,[1 0 1 0 0 0]);
    for j = 1:size(x,1)
        if x(j,1) == currCenterID
            x(j,5) = 0;
        else
            Q = cell2mat(CompMoveData(x(j,1),4)); 
            Q = NTURGBDNormalizeSeq(Q,[1 0 1 0 0 0]);
            x(j,5) = dtw(P',Q','euclidean');
        end
    end
    
    % table containing cluster info
    y = [];
    y(1,1) = currClusterID;
    y(1,2) = currCenterID;
    y(1,3) = currCenterXID;
    z = [];
    z = x(x(:,3) == currClusterID,:);
    z = sortrows(z,[5],'descend');
    y(1,4) = z(1,5);
    y(1,5) = size(z,1);
    
    subClassList(currClusterID,1:2) = [currClusterID currClass];
    
    for j = 2:k
        % next center is furthest seq in cluster with largest radius
        currClusterID = currClusterID + 1;
        subClassList(currClusterID,1:2) = [currClusterID currClass];
        largestClusterID = y(1,1);
        z = [];
        z = x(x(:,3) == largestClusterID,:);
        z = sortrows(z,[5],'descend');
        currCenterID = z(1,1);
        [currCenterXID,col] = find(x(:,1) == currCenterID);
        x(currCenterXID,3) = currClusterID;
        x(currCenterXID,4) = 1;
        x(currCenterXID,5) = 0;
        
        P = cell2mat(CompMoveData(currCenterID,4)); 
        P = NTURGBDNormalizeSeq(P,[1 0 1 0 0 0]);
    
        for m = 1:size(x,1)
            if x(m,4) == 0 % is not a center
                if x(m,1) ~= currCenterID
                    Q = cell2mat(CompMoveData(x(m,1),4)); 
                    Q = NTURGBDNormalizeSeq(Q,[1 0 1 0 0 0]);
                    currDist = dtw(P',Q','euclidean');
                    if currDist < x(m,5) % move seq to new center
                        x(m,3) = currClusterID;
                        x(m,5) = currDist;
                    end
                end
            end
        end
        
        y(j,1) = currClusterID;
        y(j,2) = currCenterID;
        y(j,3) = currCenterXID;
        y(j,4) = 0;
        y(j,5) = 0;
        
        % update radii in the cluster list
        for m = 1:size(y,1)
            thisClusterID = y(m,1);
            z = [];
            z = x(x(:,3) == thisClusterID,:);
            z = sortrows(z,[5],'descend');
            y(m,4) = z(1,5);
            y(m,5) = size(z,1);
        end
        
        y = sortrows(y,[4],'descend'); % put cluster with largest radius first in list
    end
    
    % save subclass ID results to trainSeqInfo
    for j = 1:size(x,1)
        [row,col] = find(trainSeqInfo(:,1) == x(j,1));
        trainSeqInfo(row,3) = x(j,3);
    end
    
    for j = 1:size(trainSeqInfo,1)
        trainSet(j,4) = {trainSeqInfo(j,3)};
    end

end