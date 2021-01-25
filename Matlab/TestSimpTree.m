InitGlobalVars;

CCTType = 'CCT1';
dataName = 'TruckData';
load(['MatlabData/' CCTType dataName '.mat']);
CreateTrajStr;
eAdd = 0; eMult = 0;
    
inP = cell2mat(trajOrigData(34,1));

tic
ConstTrajSimpTree(inP,1.7,10);
toc

% create a simple query
Qid = 1;
Q = queryStrData(Qid).traj;
Q = Q(17:18,:);
queryStrData(Qid).traj = Q;
PreprocessQuery(Qid);

Qid = 1;
level = 1;
sIdx = 1;
eIdx = 2;

SubNNSimpTree(Qid,level,sIdx,eIdx)