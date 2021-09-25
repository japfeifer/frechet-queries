Q = [0 0; 0 1.4; 0.42 0.5; 0.425 0.475; 0.43 0.45; 0.435 0.425; 0.44 0.4; 0.445 0.375; 0.45 0.35; 0.455 0.325; 0.46 0.3; 0.465 0.275; 0.47 0.25; 0.475 0.225; 0.48 0.2; 0.46 0.3];
P = [0 0; 0 1; -0.4 0.5; 0 0; 0 1; -0.4 0.5; 0 0; 0 1; -0.4 0.5; 0 0; 0 1; -0.4 0.5; 0 0; 0 1];

simpFlag = 0;
plotFSD = 1;
bndCutFlg = 0;
bringFlg = 0;
subTrajFlg = 0;

dist = ContFrechet(P,Q);
len = 0.5;
ans = FrechetDecide(P,Q,len,simpFlag,plotFSD,bndCutFlg,bringFlg,subTrajFlg);
