InitGlobalVars;

CCTType = 'CCT1';
dataName = 'TruckData';
load(['MatlabData/' CCTType dataName '.mat']);
InitDatasetVars(dataName);
CreateTrajStr;
eAdd = 0; eMult = 0;
    
inP = cell2mat(trajOrigData(34,1)); % input traj P
inP = DriemelSimp(inP,0); % get rid of duplicate vertices

tic
ConstTrajSimpTree(inP,1.7,10); % construct the simplification tree
t = toc;
disp(['Simplification tree construction time (s): ',num2str(t)]);

% create a simple query
Qid = 1;
Q = queryStrData(Qid).traj;
Q = Q(17:18,:);
% Q = Q(17:20,:);
queryStrData(Qid).traj = Q;
PreprocessQuery(Qid);

% NN query on the simplification tree from the root
Qid = 1; level = 1; sIdx = 1; eIdx = 2;
tic
SubNNSimpTree(Qid,level,sIdx,eIdx,1);
t = toc;
disp(['Query time (s): ',num2str(t)]);
disp(['Prune time (s): ',num2str(timeSub)]);