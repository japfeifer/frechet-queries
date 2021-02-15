% Test runtimes of various sub-traj methods on Taxi dataaset

InitGlobalVars;

testMethods = [1 3];
numQueries = 100;
maxQsz = 20;

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
            txt = 'CCT (just Ball) avg ms per query: ';
            NN(j,2,eMult); 
        elseif currMeth == 2
            txt = 'Simp Tree independent call ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTree2(j,level,sIdx,eIdx,1,0,Inf,0);
        elseif currMeth == 3
            txt = 'Simp Tree use CCT result avg ms per query: ';
            trajNNidx = queryStrData(j).decidetrajids;
            QidR = numQueries + 1;
            queryStrData(QidR).traj = trajStrData(trajNNidx).traj;
            PreprocessQuery(QidR);
            RNN(QidR,2,inpTrajErr(simpLevelCCT),eMult);
            trajRNNidx = queryStrData(QidR).decidetrajids(1,1);
            SubNNSimpTree2(j,simpLevelCCT,trajStrData(trajNNidx).simptrsidx,trajStrData(trajNNidx).simptreidx,1,0,Inf,0);
        elseif currMeth == 4
            txt = 'Sub-traj DP independent call avg ms per query: ';
            Q = queryStrData(j).traj;
            [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = SubNNIndependentDP(inP,Q);
        elseif currMeth == 5
            txt = 'Sub-traj DP use CCT result avg ms per query: ';
            Q = queryStrData(j).traj;
            trajNNidx = queryStrData(j).decidetrajids;
            sIdx = max(trajStrData(trajNNidx).simptrsidx - 1, 1);
            eIdx = min(trajStrData(trajNNidx).simptreidx + 1, inpTrajSz(simpLevelCCT));
            sIdx = inpTrajVert(sIdx,simpLevelCCT);
            eIdx = inpTrajVert(eIdx,simpLevelCCT);
            [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = SubNNIndependentDP(inP(sIdx:eIdx,:),Q);
        elseif currMeth == 6
            txt = 'Sub-traj DP use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTreeDP(j,level,sIdx,eIdx);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);
end
