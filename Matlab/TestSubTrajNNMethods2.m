% Test runtimes of various sub-traj methods on Taxi dataaset

InitGlobalVars;

testMethods = [1 4];
numQueries = 100;
maxQsz = 20;
typeQ = 2;
eVal = 0.5;

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
            txt = 'CCT (just Ball Simp) avg ms per query: ';
            NN(j,2,eMult); 
        elseif currMeth == 3
            txt = 'Vertex Aligned independent call ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTree(j,level,sIdx,eIdx,typeQ,eVal,Inf,0);
        elseif currMeth == 4
            txt = 'Vertex Aligned use CCT result avg ms per query: ';
            trajNNidx = queryStrData(j).decidetrajids;
            QidR = numQueries + 1;
            queryStrData(QidR).traj = trajStrData(trajNNidx).traj;
            PreprocessQuery(QidR);
            RNN(QidR,2,inpTrajErr(simpLevelCCT),0);
            [sIdx,eIdx] = GetVertAlignInclMin(QidR);
            SubNNSimpTree(j,simpLevelCCT,sIdx,eIdx,typeQ,eVal,Inf,0);
        elseif currMeth == 5
            txt = 'Segment Interior independent call avg ms per query: ';
            tSearch = tic;
            Q = queryStrData(j).traj;
            [lowBnd,upBnd,totCellCheck,totDPCalls,totSPCalls,sP,eP] = GetSubDist(inP,Q);
            timeSearch = toc(tSearch);
            queryStrData(j).sub2svert = sP(1,1);
            queryStrData(j).sub2sseginterior = sP(1,2);
            queryStrData(j).sub2evert = eP(1,1);
            queryStrData(j).sub2eseginterior = eP(1,2);
            queryStrData(j).sub2lb = lowBnd;
            queryStrData(j).sub2ub = upBnd;
            queryStrData(j).sub2cntcellcheck = totCellCheck;
            queryStrData(j).sub2cntdpcalls = totDPCalls;
            queryStrData(j).sub2cntspvert = totSPCalls;
            queryStrData(j).sub2searchtime = timeSearch;
        elseif currMeth == 6
            txt = 'Segment Interior use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTreeDP(j,level,sIdx,eIdx);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);
end
