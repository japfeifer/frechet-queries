% Test runtimes of various sub-traj methods on synthetic dataset

InitGlobalVars;
load(['MatlabData/TestSimpCCT4.mat']);

numQueries = 10;
maxQSegSz = 1;

rngSeed = 1;
rng(rngSeed); % reset random seed so experiments are reproducable

for j = 1:numQueries
    qSeg = randi(maxQSegSz);
    sPos = randi(size(inP,1)-qSeg-1);
    ePos = sPos + qSeg;
    Q = inP(sPos:ePos,:);
    queryStrData(j).traj = Q;
    PreprocessQuery(j);
end

disp(['================']);

% perform queries
tic
for j = 1:numQueries
%     txt = 'Segment Interior use Simp Tree avg ms per query: ';
%     level = 1; sIdx = 1; eIdx = 2;
%     SubNNSimpTreeDP(j,level,sIdx,eIdx);
    
    txt = 'Main Improved (Bringmann UB/LB) call avg ms per query: ';
    level = 1; sIdx = 1; eIdx = 2; typeQ = 2; eVal = 0;
    MainImprovedSubNN3(j,level,[sIdx eIdx],0,typeQ,eVal);
end
t1 = toc;
t1 = round(t1/numQueries*1000); % average ms per query
disp([txt,num2str(t1)]);

