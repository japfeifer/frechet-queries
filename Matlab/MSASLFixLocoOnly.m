% MSASLFixLocoOnly
% Add hand joints, all at 0 coordinates, so that other MSASL code works

for i = 1:size(CompMoveData,1)
    seq = cell2mat(CompMoveData(i,4));
    seq(:,55:180) = 0;
    CompMoveData(i,4) = mat2cell(seq,size(seq,1),size(seq,2));
end