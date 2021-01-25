% export trajectory dataset

trajExport = [];
for i=1:size(trajStrData,2)
% for i=1:2
    tmpTraj = trajStrData(i).traj;
    tmpTrajSz = size(tmpTraj,1);
    c2 = i*ones(tmpTrajSz,1) ;  % column of traj id
    tmpTraj = [c2 tmpTraj];
    trajExport(end+1 : size(tmpTraj,1) + end , :) = tmpTraj;
end

dlmwrite('SyntheticData23.csv',trajExport,'precision',15)
