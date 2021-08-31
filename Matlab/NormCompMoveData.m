% compute normalized sequences

compIDs = cell2mat(trainSet(:,1));
compIDs = [compIDs; cell2mat(querySet(:,1))];
compIDs = [compIDs; cell2mat(featureSet(:,1))];
for i = 1:size(compIDs,1)
    seq = cell2mat(CompMoveData(compIDs(i,1),4)); % get original non-normalized seq
    % compute normalized seq
    if datasetType == 1
        normSeq = KinTransNormalizeSeq(seq,seqNormalCurr);
    elseif datasetType == 2
        normSeq = MHADNormalizeSeq(seq,seqNormalCurr);
    elseif datasetType == 3
        normSeq = LMNormalizeSeq(seq,seqNormalCurr);
    elseif datasetType == 4
        normSeq = UCFNormalizeSeq(seq,seqNormalCurr);
    elseif datasetType == 5
        normSeq = MSRDANormalizeSeq(seq,seqNormalCurr);
    elseif datasetType == 6
        normSeq = NTURGBDNormalizeSeq(seq,seqNormalCurr);
    elseif datasetType == 7 || datasetType == 8
        normSeq = MSASLNormalizeSeq(seq,seqNormalCurr);
    end
    CompMoveData(compIDs(i,1),6) = mat2cell(normSeq,size(normSeq,1),size(normSeq,2)); 
end
