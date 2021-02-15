% Test runtimes of various sub-traj methods on Truck dataset

InitGlobalVars;

testMethods = [3];
reachType = 2; % 1 = small reach, 2 = large reach
numQueries = 100;

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
            txt = 'CCT (just Ball) avg ms per query: ';
            NN(j,2,eMult); 
        elseif currMeth == 2
            txt = 'CCT (also Agarwal) avg ms per query: ';
            NN(j,2,eMult); 
        elseif currMeth == 3
            txt = 'Simp Tree independent call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTree2(j,level,sIdx,eIdx,1,0,Inf,0);
        elseif currMeth == 4
            txt = 'Simp Tree use CCT result avg ms per query: ';
            trajNNidx = queryStrData(j).decidetrajids;
            QidR = numQueries + 1;
            queryStrData(QidR).traj = trajStrData(trajNNidx).traj;
            PreprocessQuery(QidR);
            RNN(QidR,2,inpTrajErr(simpLevelCCT),eMult);
            trajRNNidx = queryStrData(QidR).decidetrajids(1,1);
            SubNNSimpTree2(j,simpLevelCCT,trajStrData(trajNNidx).simptrsidx,trajStrData(trajNNidx).simptreidx,1,0,Inf,0);
        elseif currMeth == 5
            txt = 'Sub-traj DP independent call avg ms per query: ';
            Q = queryStrData(j).traj;
            [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = SubNNIndependentDP(inP,Q);
        elseif currMeth == 6
            txt = 'Sub-traj DP use CCT result avg ms per query: ';
            Q = queryStrData(j).traj;
            trajNNidx = queryStrData(j).decidetrajids;
            sIdx = max(trajStrData(trajNNidx).simptrsidx - 1, 1);
            eIdx = min(trajStrData(trajNNidx).simptreidx + 1, inpTrajSz(simpLevelCCT));
            sIdx = inpTrajVert(sIdx,simpLevelCCT);
            eIdx = inpTrajVert(eIdx,simpLevelCCT);
            [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = SubNNIndependentDP(inP(sIdx:eIdx,:),Q);
        elseif currMeth == 7
            txt = 'Sub-traj DP use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTreeDP(j,level,sIdx,eIdx);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);

end