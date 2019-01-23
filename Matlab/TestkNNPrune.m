% Test kNN Pruning

numQuery = size(queryTraj,1);
for i = 1:numQuery
    PruneTraj4(i,5);
    prevMethodList = cell2mat(queryTraj(i,3));
    PruneTraj6(i,5);
    newMethodList = cell2mat(queryTraj(i,3));
    if size(prevMethodList,1) ~= size(newMethodList,1)
        error('Sizes do not match');
    end
    for j=1:size(prevMethodList,1)
        if prevMethodList(j,1) ~= newMethodList(j,1)
            error('Trajectory ID''s do not match');
        end
    end
        
end