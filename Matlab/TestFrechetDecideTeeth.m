P = [0 1; 1 1];
Q = [0.5 1; 0.50001 1; 0.1 1; 0.1 0.44; 0.1 1; 0.1 0.42; 0.1 1; 0.1 0.40; 0.1 1; 0.1 0.38; 0.1 1; 0.1 0.375; 0.1 1; 0.1 0.373; 0.1 1; 0.1 0.371; 0.1 1];

simpFlag = 0;
plotFSD = 1;
bndCutFlg = 0;
bringFlg = 0;
subTrajFlg = 0;

dist = ContFrechet(P,Q);
len = dist * 0.7 ;
ans = FrechetDecide(P,Q,len,simpFlag,plotFSD,bndCutFlg,bringFlg,subTrajFlg);