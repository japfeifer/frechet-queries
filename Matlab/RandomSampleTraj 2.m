
% sample traj uniformly at random without replacement
trajData2 = datasample(trajData,5000,'Replace',false);
trajData=trajData2;
trajData2 = [];
clear trajData2;