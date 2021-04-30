% Test runtimes of various sub-traj methods on Truck dataset

InitGlobalVars;

testMethods = [8];
reachType = 2; % 1 = small reach, 2 = large reach
numQueries = 10;
typeQ = 1;
eVal = 0;

rngSeed = 1;
rng(rngSeed); % reset random seed so experiments are reproducable

% load data
CCTType = 'CCT1';
dataName = 'TruckData';
load(['MatlabData/' CCTType dataName '.mat']);
InitDatasetVars(dataName);
CreateTrajStr;
eAdd = 0; eMult = 0;

if reachType == 1 % generate queries with smaller reach
    maxQsz = 25;
    for j = 1:numQueries
        Q = cell2mat(trajOrigData(randi(size(trajOrigData,1)),1));
        qSz = size(Q,1);
        sPos = randi(qSz-1); % randomly choose start/end positions
        ePos = min(randi(maxQsz) + sPos , qSz);
        Q = Q(sPos:ePos,:);
        queryStrData(j).traj = Q;
        PreprocessQuery(j);
    end
else % generate queries with larger reach
    maxQsz = 7;
    for j = 1:numQueries
        Q = queryStrData(j).traj;
        qSz = size(Q,1);
        sPos = randi(qSz-1);
        ePos = min(randi(maxQsz) + sPos , qSz);
        Q = Q(sPos:ePos,:);
        queryStrData(j).traj = Q;
        PreprocessQuery(j);
    end
end
  
disp(['================']);

for i = 1:size(testMethods,2) % sub-traj methods
    currMeth = testMethods(i);
    disp(['--------------']);
    if currMeth == 1 % slower CCT
        load(['MatlabData/TestSimpCCT.mat']); % load the pre-processed CCT, simp tree, inP, and simpLevelCCT
    else % faster CCT
        load(['MatlabData/TestSimpCCT2.mat']); % load the pre-processed CCT, simp tree, inP, and simpLevelCCT
    end

    % perform queries
    tic
    for j = 1:numQueries
        if currMeth == 1 
            txt = 'CCT (just Ball Simp) avg ms per query: ';
            RNN(j,2,tau+inpTrajErr(simpLevelCCT),0); 
        elseif currMeth == 2
            txt = 'CCT (also Agarwal Simp) avg ms per query: ';
            RNN(j,2,tau+inpTrajErr(simpLevelCCT),0); 
        elseif currMeth == 3
            txt = 'Vertex Aligned independent call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTree(j,tau,level,sIdx,eIdx,typeQ,eVal,0);
        elseif currMeth == 4
            txt = 'Vertex Aligned use CCT result avg ms per query: ';
            if size(queryStrData(j).decidetrajids,1) > 0
                [sIdx,eIdx] = GetVertAlignInclMin(j);
                SubRNNSimpTree(j,tau,simpLevelCCT,sIdx,eIdx,typeQ,eVal,0);
            end
        elseif currMeth == 5
            txt = 'Segment Interior independent call avg ms per query: ';
        elseif currMeth == 6
            txt = 'Segment Interior use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTreeDP(j,tau,level,sIdx,eIdx);
        elseif currMeth == 7
            txt = 'Vertex Aligned independent call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTreeVAIntraBall(j,tau,level,sIdx,eIdx,typeQ,eVal,0);
        elseif currMeth == 8
            txt = 'Vertex Aligned independent call avg ms per query: ';
            load(['MatlabData/TestSimpCCT.mat']);
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTreeVA(j,tau,level,sIdx,eIdx,typeQ,eVal,0);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);

end