function bestTrainID = GetBestTrainCluster(trainSetID,classIDs)

    global CompMoveData
    
    % get list of training sequences
    seqInfo = [];
    for i = 1:size(trainSetID,2)
        seqInfo(end+1,:) = [trainSetID(i) classIDs(trainSetID(i))];
    end
    
    numSeq = size(seqInfo,1);
    bestTotDist = Inf;
    bestTrainID = 0;
    for i = 1:numSeq
        totDist = 0;
        P = cell2mat(CompMoveData(seqInfo(i,2),4)); % cluster center curve
        P = LMExtractFeatures(P,4);
        for j = 1:numSeq
            if i ~= j % do not compare sub seq to itself
                Q = cell2mat(CompMoveData(seqInfo(j,2),4)); % non-center curve
                Q = LMExtractFeatures(Q,4);
                curDist = DiscreteFrechetDist(P,Q);
%                 curDist = dtw(P',Q'); % dtw distance
                totDist = totDist + curDist;
                if totDist > bestTotDist % this center totDist is too large
                    break
                end
            end
        end
        if totDist < bestTotDist % best cluster center so far
            bestTrainID = seqInfo(i,1);
            bestTotDist = totDist;
        end
    end
end