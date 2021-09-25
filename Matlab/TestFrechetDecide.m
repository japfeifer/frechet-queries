Pid = 10;
Qid = 20;
% P = cell2mat(trajData(Pid,1));
% Q = cell2mat(trajData(Qid,1));
P = cell2mat(trajOrigData(Pid,1));
Q = cell2mat(trajOrigData(Qid,1));

simpFlag = 0;
plotFSD = 1;
bndCutFlg = 0;
bringFlg = 0;
subTrajFlg = 0;

dist = ContFrechet(P,Q);
len = dist;
ans = FrechetDecide(P,Q,len,simpFlag,plotFSD,bndCutFlg,bringFlg,subTrajFlg);