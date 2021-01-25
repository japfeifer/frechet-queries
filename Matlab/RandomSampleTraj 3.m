
% sample traj uniformly at random without replacement
trajStrData2 = datasample(trajStrData,5000,'Replace',false);
trajStrData=trajStrData2;
trajStrData2 = [];
clear trajStrData2;