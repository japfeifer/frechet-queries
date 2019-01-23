% calculate query result avg and std dev

queryResults3 = [];

% additive error
addErrorList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    currVal = cell2mat(queryTraj(i,14));
    if currPrune ~= 0
        addErrorList = [addErrorList; currVal];
    end
end

% relative error
relErrorList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    currVal = cell2mat(queryTraj(i,15));
    if currPrune ~= 0
        relErrorList = [relErrorList; currVal];
    end
end

disp(['-----------------------------']);

addErrAvg = mean(addErrorList);
addErrStd = std(addErrorList);
disp(['Additive Error Avg: ',num2str(addErrAvg),' Additive Error Std:',num2str(addErrStd)]);

relErrAvg = mean(relErrorList);
relErrStd = std(relErrorList);
disp(['Relative Error Avg: ',num2str(relErrAvg),' Relative Error Std:',num2str(relErrStd)]);

queryResults3 = [addErrAvg addErrStd relErrAvg relErrStd];
