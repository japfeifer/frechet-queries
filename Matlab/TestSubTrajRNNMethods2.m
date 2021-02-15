% Test runtimes of various sub-traj methods on Taxi dataaset

InitGlobalVars;

testMethods = [1 2];
numQueries = 10;
maxQsz = 25;

rngSeed = 1;
rng(rngSeed); % reset random seed so experiments are reproducable

% load Taxi original trajectory data
dataName = 'TaxiData';
load(['MatlabData\RealInputData\TaxiDataOrig.mat']);

InitDatasetVars(dataName);
eAdd = 0; eMult = 0;

% create queries
queryStrData = [];
for j = 1:numQueries
    Q = trajStrData(randi(size(trajStrData,2))).traj;
    qSz = size(Q,1);
    sPos = randi(qSz-1); % randomly choose start/end positions
    ePos = min(randi(maxQsz) + sPos , qSz);
    Q = Q(sPos:ePos,:);
    queryStrData(j).traj = Q;
    PreprocessQuery(j);
end

% load pre-processed CCT and Simp Tree
load(['MatlabData\TestSimpCCT3.mat']);
    
disp(['================']);

for i = 1:size(testMethods,2) % sub-traj methods
    currMeth = testMethods(i);
    disp(['--------------']);
    % perform queries
    tic
    for j = 1:numQueries
        if currMeth == 1 
            txt = 'CCT (just Driemel) avg ms per query: ';
            RNN(j,2,tau,eMult); 
        elseif currMeth == 2
            txt = 'Sub-traj DP use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTreeDP(j,tau,level,sIdx,eIdx);
        elseif currMeth == 3
            txt = 'Simp Tree independent call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTree(j,tau,level,sIdx,eIdx,typeQ,eVal,0);
        elseif currMeth == 4
            txt = 'Sub-traj DP use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTreeDP(j,tau,level,sIdx,eIdx);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);
end
