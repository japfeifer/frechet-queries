% test worst-case DP scenarios

P = [5 -4.9; 5 -4.4; 5 -4.0; 5 -3.8; 5 -3.6; 5 -3.4; 5 -3.2; 5 -3.0; 5 -2.8; 5 0];
% Q = [4 0; 10 0; 0 0; 10 0; 0 0; 10 0; 0 0; 10 0; 0 0; 10 0];
Q = [4 0; 10 -0.10; 0 -0.11; 10 -0.12; 0 -0.13; 10 -0.14; 0 -0.15; 10 -0.16; 0 -0.17; 10 -0.18];
len = ContFrechet(P,Q);
len = round(len,7)+0.00000009;
len = fix(len * 7^10)/7^10;

ans = FrechetDecide(P,Q,len,1,1);
[ans2,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,len);