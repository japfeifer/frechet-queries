% MSASLSubjectToXview
% change Subject to Xview
for i = 1:size(CompMoveData,1)
    currView = cell2mat(CompMoveData(i,3));
    CompMoveData(i,2) = {['Subject ' num2str(currView)]};
end