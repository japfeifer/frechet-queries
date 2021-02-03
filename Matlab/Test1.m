Qid = 6;
level = 10;
err = inpTrajErr(level);

vertList = [inpTrajVert(1:inpTrajSz(level),level)]';

Q = queryStrData(Qid).traj;
P = inP(vertList,:);

[frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = ContFrechetSubTraj2(P,Q,err);

decide = FrechetDecide(P,Q,frechetDist,0,1,0,0);

% SubNNSimpTree(2,1,1,2,1);