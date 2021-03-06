% Test runtimes of various sub-traj methods on Football dataset

InitGlobalVars;

testMethods = [16];
reachType = 1; % 1 = small reach, 2 = large reach
numQueries = 10;

rngSeed = 1;
rng(rngSeed); % reset random seed so experiments are reproducable

CCTType = 'CCT1';
dataName = 'FootballData';
load(['MatlabData/' CCTType dataName '.mat']);
% load(['MatlabData\RealInputData\FootballData.mat']);
load(['MatlabData/TestSimpCCT5.mat']);
InitDatasetVars(dataName);
CreateTrajStr;
doDFD = false;
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

    % perform queries
    tic
    for j = 1:numQueries
        if currMeth == 1 
            txt = 'CCT (just Ball Simp) avg ms per query: ';
            NN(j,2,eMult); 
        elseif currMeth == 2
            txt = 'CCT (also Agarwal Simp) avg ms per query: ';
            NN(j,2,eMult); 
        elseif currMeth == 3
            txt = 'Vertex Aligned independent call avg ms per query: ';
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
        elseif currMeth == 7
            txt = 'Vertex Aligned independent call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTreeVAIntraBall(j,level,sIdx,eIdx,typeQ,eVal,0);
        elseif currMeth == 8
            txt = 'Vertex Aligned independent call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            SubNNSimpTreeVA(j,level,sIdx,eIdx,typeQ,eVal,0);
        elseif currMeth == 9
            txt = 'Vertex Aligned use CCT result avg ms per query: ';
            NN(j,2,eMult);
            trajNNidx = queryStrData(j).decidetrajids;
            NNdist = ContFrechet(trajStrData(trajNNidx).traj,queryStrData(j).traj);
            QidR = numQueries + 1;
            queryStrData(QidR).traj = queryStrData(j).traj;
            PreprocessQuery(QidR);
            RNN(QidR,2,NNdist + inpTrajErr(simpLevelCCT),0);
            [sIdx,eIdx] = GetCCTPairwiseCand(QidR);
            SubNNSimpTreeVA(j,simpLevelCCT,sIdx,eIdx,typeQ,eVal,0);
            queryStrData(j).nnsearchtime = queryStrData(j).searchtime;
            queryStrData(j).rnnsearchtime = queryStrData(QidR).searchtime;
        elseif currMeth == 12
            txt = 'Base avg ms per query: ';
            BaseSubNN(j);
        elseif currMeth == 13
            txt = 'Main Vertex Aligned avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            MainSubNN(j,level,[sIdx eIdx]);
        elseif currMeth == 14
            txt = 'Main Improved call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2;
            MainImprovedSubNN(j,level,[sIdx eIdx],0);
        elseif currMeth == 15
            txt = 'Main Improved (use for approx queries) call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2; typeQ = 2; eVal = 2;
            MainImprovedSubNN2(j,level,[sIdx eIdx],0,typeQ,eVal);
        elseif currMeth == 16
            txt = 'Main Improved (Bringmann UB/LB) call avg ms per query: ';
            level = 1; sIdx = 1; eIdx = 2; typeQ = 2; eVal = 0;
            MainImprovedSubNN3(j,level,[sIdx eIdx],0,typeQ,eVal);
        end
    end
    t1 = toc;
    t1 = round(t1/numQueries*1000); % average ms per query
    disp([txt,num2str(t1)]);

end