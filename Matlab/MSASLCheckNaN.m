for i = 1:size(CompMoveData,1)
    seq1 = cell2mat(CompMoveData(i,4));
    seq = MSASLNormalizeSeq(seq1,[0 0 1 0]);
    for j = 1:size(seq,1)
        for k = 1:size(seq,2)
            if isnan(seq(j,k)) == true
                error('found NaN');
            end
        end
    end
    
end