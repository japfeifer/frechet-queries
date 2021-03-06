% Construct Simp Tree and CCT with a Truck dataset input traj
% Only use Driemel simplification (not Agarwal)

InitGlobalVars;

CCTType = 'CCT1';
dataName = 'TruckData';
load(['MatlabData/' CCTType dataName '.mat']);
InitDatasetVars(dataName);
CreateTrajStr;
doDFD = false;

inP = cell2mat(trajOrigData(34,1)); % input traj P
inP = DriemelSimp(inP,0); % get rid of duplicate vertices

tic
ConstTrajSimpTree(inP,2,10); % construct the simplification tree
t = toc;
disp(['Simplification tree construction time (s): ',num2str(t)]);

% tic
% ConstTrajSimpTree2(inP,3); % construct the simplification tree with "balanced" levels
% t = toc;
% disp(['Simplification tree construction time (s): ',num2str(t)]);

% simpLevelCCT = 7; % the level of the simplification tree to store in CCT
% simpPVertIdx = [inpTrajVert(1:inpTrajSz(simpLevelCCT),simpLevelCCT)]';
% szPSimp = inpTrajSz(simpLevelCCT);
% 
% % clear the CCT
% trajStrData = [];
% clusterNode = [];
% clusterTrajNode = [];
% trajStrData = struct;
% 
% % pre-allocate memory (faster)
% maxSz = sum(1:szPSimp-1);
% clusterNode((maxSz*2)-1,7) = 0;
% clusterTrajNode(maxSz,1) = 0;
% trajStrData = struct('traj',[1 1; 1 1],'se',0,'bb1',0,'bb2',0,'bb3',0,'st',0,'ustraj',[1 1; 1 1]);
% trajStrData(1:maxSz) = struct('traj',[1 1; 1 1],'se',0,'bb1',0,'bb2',0,'bb3',0,'st',0,'ustraj',[1 1; 1 1]);
% 
% % generate all pair-wise sub-traj
% tic
% trajCnt = 1;
% for i = 1:szPSimp - 1
%     for j = i+1:szPSimp
%         newP = inP(simpPVertIdx(i:j),:);
%         trajStrData(trajCnt).traj = newP;
%         trajStrData(trajCnt).simptrsidx = i; % simplification tree start index (for level simpLevelCCT)
%         trajStrData(trajCnt).simptreidx = j; % simplification tree end index (for level simpLevelCCT)
%         trajCnt = trajCnt + 1;
%     end
% end
% t = toc;
% disp(['Generate all pair-wise sub-traj time (s): ',num2str(t)]);
% 
% % pre-process traj bounds
% tic
% TrajDataPreprocessing;
% t = toc;
% disp(['Pre-process traj bounds time (s): ',num2str(t)]);
% 
% % Construct Relaxed CCT
% tic
% ConstructCCTGonzLite;
% t = toc;
% disp(['Construct Relaxed CCT time (s): ',num2str(t)]);
% 
% % get tree info
% GetAvgTreeHeight;
% GetCCTReductFact;
% [overlapMean, overlapStd] = GetOverlap();

% save(['MatlabData/TestSimpCCT.mat'],'trajStrData','clusterTrajNode','clusterNode','simpLevelCCT','inP','inpTrajErr','inpTrajErrF','inpTrajPtr','inpTrajSz','inpTrajVert','inpLen');
