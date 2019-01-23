% import football data
% Four of the PL matches have been segmented into trajectories for each player-possession.

tic;

% massage data to new format
trajData = {[]};
currTraj = [];
dataSize = size(POSSESSIONS,1);

for i = 1:dataSize 
    
    currTraj = cell2mat(POSSESSIONS.oriented_trajectory(i));
    currTraj = currTraj(:,2:3);
    trajData(i,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
    
end

timeElapsed = toc;