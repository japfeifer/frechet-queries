% calculate the average # vertices per traj set

vertSum = 0;
for i = 1:size(trajData,1)
% for i = 1:500
    tmpTraj = cell2mat(trajData(i,1));
    vertSum = vertSum + size(tmpTraj,1);
end
avgVert = vertSum/i;
avgVert