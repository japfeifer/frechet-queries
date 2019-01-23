% import the Robot data

trajData = {[]};
currTraj = [meas_lei.x meas_lei.y];
currTraj = currTraj(6:size(currTraj,1),:);
trajData(1,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
