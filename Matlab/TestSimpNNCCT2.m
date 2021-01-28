InitGlobalVars;

CCTType = 'CCT1';
dataName = 'TruckData';
load(['MatlabData/' CCTType dataName '.mat']);
InitDatasetVars(dataName);
CreateTrajStr;
eAdd = 0; eMult = 0;

load(['MatlabData/TestSimpCCT2.mat']); % load the pre-processed CCT, simp tree, inP, and simpLevelCCT
disp(['--------------']);

% create a simple query
Qid = 1;
Q = queryStrData(Qid).traj;
% Q = Q(17:18,:);
Q = Q(17:20,:);
queryStrData(Qid).traj = Q;
PreprocessQuery(Qid);

% exact NN query on CCT
tic
NN(Qid,2,eMult); 
t1 = toc;
disp(['Exact CCT NN time (s): ',num2str(t1)]);
trajNNidx = queryStrData(Qid).decidetrajids;

% exact Range query on CCT
tic
QidR = Qid + 1;
queryStrData(QidR).traj = trajStrData(trajNNidx).traj;
PreprocessQuery(QidR);
RNN(QidR,2,inpTrajErr(simpLevelCCT),eMult);
t2 = toc;
disp(['Exact CCT RNN time (s): ',num2str(t2)]);

% NN query on the simplification tree from level simpLevelCCT
trajRNNidx = queryStrData(QidR).decidetrajids(1,1);
tic
SubNNSimpTree(Qid,simpLevelCCT,trajStrData(trajNNidx).simptrsidx,trajStrData(trajNNidx).simptreidx,0);
t3 = toc;
disp(['Simp Tree Query time from level ',num2str(simpLevelCCT),' (s): ',num2str(t3)]);
% disp(['Simp Tree Prune time from level ',num2str(simpLevelCCT),' (s): ',num2str(timeSub)]);
disp(['Total query time (s): ',num2str(t1+t2+t3)]);

% NN query on the simplification tree from the root
Qid = 1; level = 1; sIdx = 1; eIdx = 2;
tic
SubNNSimpTree(Qid,level,sIdx,eIdx,0);
t4 = toc;
disp(['Simp Tree Query time from root (No CCT) (s): ',num2str(t4)]);
% disp(['Simp Tree Prune time from root (s): ',num2str(timeSub)]);