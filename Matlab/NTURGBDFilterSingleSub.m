% only choose seq that are a single subject

CompMoveDataTmp = {[]};
idx = 1;
for i = 1:size(CompMoveData,1)
    seq = cell2mat(CompMoveData(i,4));
    if size(seq,2) == 75
        CompMoveDataTmp(idx,1:11) = CompMoveData(i,1:11);
        idx = idx + 1;
    end
end

CompMoveData = CompMoveDataTmp;

% now fix some joints that are at the origin
NTURGBDFixJointOrigin;