% Test runtimes of various sub-traj methods on Taxi dataaset

InitGlobalVars;

testMethods = [1 3 4 5];
numQueries = 100;
maxQsz = 25;
typeQ = 1;
eVal = 0;

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
            txt = 'Segment Interior use Simp Tree avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubRNNSimpTreeDP(j,tau,level,sIdx,eIdx);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);
end
