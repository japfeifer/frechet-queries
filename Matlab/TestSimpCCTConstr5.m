% Construct Simp Tree and CCT with a large Taxi dataset input traj (combine several traj together)
% Only use Driemel simplification (not Agarwal)

InitGlobalVars;

dataName = 'FootballData';
load(['MatlabData\RealInputData\FootballData.mat']);
InitDatasetVars(dataName);
doDFD = false;

% create input curve inP
inP = [];
for i = 1:size(trajData,1)
    currTraj = cell2mat(trajData(i,1));
    inP = [inP; currTraj];
    if size(inP,1) > 103200
        break 
    end
end
inP = DriemelSimp(inP,0);  % remove any "duplicate" vertices

tic
% ConstTrajSimpTree(inP,2,17,1); % construct the simplification tree
ConstTrajSimpTree2(inP,2,1); % construct the simplification tree with "balanced" levels
t = toc;
disp(['Simplification tree construction time (s): ',num2str(t)]);

% simpLevelCCT = 9; % the level of the simplification tree to store in CCT
% simpPVertIdx = [inpTrajVert(1:inpTrajSz(simpLevelCCT),simpLevelCCT)]';
% szPSimp = inpTrajSz(simpLevelCCT);

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
% % % Construct Relaxed CCT
% % tic
% % ConstructCCTGonzLite;
% % t = toc;
% % disp(['Construct Relaxed CCT time (s): ',num2str(t)]);
% 
% % Construct Aprox Radii CCT
% tic
% ConstructCCTApproxRadii;
% t = toc;
% disp(['Construct Approx Radii CCT time (s): ',num2str(t)]);
% 
% % get tree info
% GetAvgTreeHeight;
% GetCCTReductFact;
% [overlapMean, overlapStd] = GetOverlap();

% save(['MatlabData/TestSimpCCT5.mat'],'inP','inpTrajErr','inpTrajErrF','inpTrajPtr','inpTrajSz','inpTrajVert','inpLen','-v7.3');
