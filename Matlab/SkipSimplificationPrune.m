% Skip Simplification Prune Step
% Just copy over Range Search results

tic;
currTrajIDList = [];
for k = 1:numQueryTraj % for each query do
    currTrajIDList = cell2mat(queryTraj(k,3));

    if isempty(currTrajIDList) == false
        queryTraj(k,6) = mat2cell(currTrajIDList,size(currTrajIDList,1),size(currTrajIDList,2));
    else
        queryTraj(k,6) = num2cell(0);
    end
    
end
timeElapsed = toc;