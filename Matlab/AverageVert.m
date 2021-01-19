% calculate the average # vertices per traj set

vertSum = 0;
for i = 1:size(trajStrData,2)
% for i = 1:500
    tmpTraj = trajStrData(i).traj;
    vertSum = vertSum + size(tmpTraj,1);
end
avgVert = vertSum/i;
disp(['avgVert: ',num2str(avgVert)]);