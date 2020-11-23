% this shows that many sub-seq (1281 in total) have frames where all joints are
% at the origin, for the NTU-RGB+D dataaset

cols = [];
for i = 1:size(CompMoveData,1)
    seq = cell2mat(CompMoveData(i,4));
    numSub = size(seq,2) / 75;
    for j = 1:size(seq,1)
        seqrow = seq(j,:);
        for k = 1:numSub
            idx1 = k*75 - (75 - 1);  idx2 = idx1 + (75 - 1);
            subseqrow = seqrow(idx1:idx2);
            currval = sum(subseqrow);
            numzeros = nnz(~subseqrow);
%             if currval == 0
            if numzeros >= 3
                cols(end+1,:) = [i j k];
            end
        end
    end
end
