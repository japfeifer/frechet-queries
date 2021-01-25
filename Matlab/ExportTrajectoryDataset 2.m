% export trajectory dataset

trajExport = [];
for i=1:size(trajData,1)
% for i=1:2
    tmpTraj = cell2mat(trajData(i,1));
    tmpTrajSz = size(tmpTraj,1);
    c2 = i*ones(tmpTrajSz,1) ;  % column of traj id
    tmpTraj = [c2 tmpTraj];
    trajExport(end+1 : size(tmpTraj,1) + end , :) = tmpTraj;
end

dlmwrite('SyntheticData23.csv',trajExport,'precision',15)
