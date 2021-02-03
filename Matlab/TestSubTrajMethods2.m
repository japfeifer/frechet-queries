% Test runtimes of various sub-traj methods
% methodType: 1 = original CCT, 2 = new CCT, 3 = CCT + simp tree, 4 = only simp tree, 5 = modified dec proc

InitGlobalVars;

rngSeed = 1;
rng(rngSeed); % reset random seed so experiments are reproducable

% load data
dataName = 'TaxiData';
load(['MatlabData\RealInputData\TaxiDataOrig.mat']);
InitDatasetVars(dataName);
eAdd = 0; eMult = 0;

% create queries
numQueries = 10;
maxQsz = 25;
for j = 1:numQueries
    Q = trajStrData(randi(size(trajStrData,2))).traj;
    qSz = size(Q,1);
    sPos = randi(qSz-1); % randomly choose start/end positions
    ePos = min(randi(maxQsz) + sPos , qSz);
    Q = Q(sPos:ePos,:);
    queryStrData(j).traj = Q;
    PreprocessQuery(j);
end
    
for i = 1:6 % sub-traj methods
    disp(['--------------']);
    if i == 1 % slower CCT
        load(['MatlabData/TestSimpCCT.mat']); % load the pre-processed CCT, simp tree, inP, and simpLevelCCT
    else % faster CCT
        load(['MatlabData/TestSimpCCT2.mat']); % load the pre-processed CCT, simp tree, inP, and simpLevelCCT
    end

    % perform queries
    tic
    for j = 1:numQueries
        if i == 1 
            txt = 'Orig CCT avg ms per query: ';
            NN(j,2,eMult); 
        elseif i == 2
            txt = 'Fast CCT avg ms per query: ';
            NN(j,2,eMult); 
        elseif i == 3
            txt = 'Simp Tree using CCT result avg ms per query: ';
%             NN(j,2,eMult); 
            trajNNidx = queryStrData(j).decidetrajids;
            QidR = numQueries + 1;
            queryStrData(QidR).traj = trajStrData(trajNNidx).traj;
            PreprocessQuery(QidR);
            RNN(QidR,2,inpTrajErr(simpLevelCCT),eMult);
            trajRNNidx = queryStrData(QidR).decidetrajids(1,1);
            SubNNSimpTree(j,simpLevelCCT,trajStrData(trajNNidx).simptrsidx,trajStrData(trajNNidx).simptreidx,0);
        elseif i == 4
            txt = 'Only Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTree(j,level,sIdx,eIdx,0);
        elseif i == 5
            txt = 'Only Sub-traj Frechet DP avg ms per query: ';
            Q = queryStrData(j).traj;
            [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = ContFrechetSubTraj(inP,Q);
        elseif i == 6
            txt = 'Sub-traj Frechet DP using CCT result avg ms per query: ';
            Q = queryStrData(j).traj;
            trajNNidx = queryStrData(j).decidetrajids;
            sIdx = max(trajStrData(trajNNidx).simptrsidx - 1, 1);
            eIdx = min(trajStrData(trajNNidx).simptreidx + 1, inpTrajSz(simpLevelCCT));
            sIdx = inpTrajVert(sIdx,simpLevelCCT);
            eIdx = inpTrajVert(eIdx,simpLevelCCT);
            [frechetDist,totCellCheck,totDPCalls,totSPCalls,sP,eP] = ContFrechetSubTraj(inP(sIdx:eIdx,:),Q);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);

end