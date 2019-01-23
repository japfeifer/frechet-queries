% import the Pen tip data

tic;
trajData = {[]};
trajCount = 1;

trajData = mixout'; % transpose the mixout data

for k = 1:size(trajData,1)
    currTraj = cell2mat(trajData(k,1));
    currTraj = currTraj'; % transpose the mixout traj
    currTraj = currTraj(:,1:2); % only use the first 2 columns
    currTraj = currTraj( all(currTraj(:,1:2) ~= 0,2),:); % remove rows that are zeros 
    trajData(k,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2)); 
end
timeElapsed = toc;
