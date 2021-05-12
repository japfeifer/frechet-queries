% Construct Simp Tree with a straight monotone 2D traj

InitGlobalVars;
pSz = 100000;

% create input curve inP
inP(1:pSz,1:2) = 0;
inP(1,1:2) = [0 0];
for i = 2:pSz
    inP(i,1:2) = [inP(i-1,1)+1 0];
end
inP = DriemelSimp(inP,0);  % remove any "duplicate" vertices

tic
ConstTrajSimpTree(inP,2,18,1); % construct the simplification tree
t = toc;
disp(['Simplification tree construction time (s): ',num2str(t)]);

% tic
% ConstTrajSimpTree2(inP,2,1); % construct the simplification tree with "balanced" levels
% t = toc;
% disp(['Simplification tree construction time (s): ',num2str(t)]);


% save(['MatlabData/TestSimpCCT4.mat'],'inP','inpTrajErr','inpTrajErrF','inpTrajPtr','inpTrajSz','inpTrajVert','-v7.3');
