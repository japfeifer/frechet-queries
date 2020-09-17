% compute normalized sequences
for i = 1:size(CompMoveData,1)
    seq = cell2mat(CompMoveData(i,4)); % get original non-normalized seq
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
    end
    CompMoveData(i,6) = mat2cell(normSeq,size(normSeq,1),size(normSeq,2)); 
end
