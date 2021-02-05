% Qid = 6;
% level = 2;
% Q = queryStrData(Qid).traj;
% [frechetDist,totCellCheck,totDPCalls,totSPVert,sP,eP] = ContFrechetSubTraj2(Q,level,[1],[6]);


Qid = 6;
level = 1;
sVertList = 1;
eVertList = 2;
SubNNSimpTreeDP(Qid,level,sVertList,eVertList)

