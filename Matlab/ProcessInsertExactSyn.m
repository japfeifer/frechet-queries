InitGlobalVars;

scriptName = 'InsertExactSyn';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

% dataList = ["SyntheticData1" "SyntheticData2" "SyntheticData3" ...
%     "SyntheticData4" "SyntheticData5" "SyntheticData6" ...
%     "SyntheticData7" "SyntheticData8" "SyntheticData9" ...
%     "SyntheticData10" "SyntheticData11" "SyntheticData12" ...
%     "SyntheticData13" "SyntheticData14" "SyntheticData15" ...
%     "SyntheticData16" "SyntheticData17" "SyntheticData18" ...
%     "SyntheticData19" "SyntheticData20" "SyntheticData21" ...
%     "SyntheticData22" "SyntheticData23"];

dataList = ["SyntheticData1" "SyntheticData2" "SyntheticData3" ...
    "SyntheticData4" "SyntheticData5"];

insertPct = [1.00];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));

    for jProc = 1:size(insertPct,2) 
        
        load(['MatlabData/' CCTType dataName '.mat']);
        eAdd = 0; eMult = 0;
        numInsertTraj = ceil(size(trajData,1) * insertPct(jProc));
        saveFileName = ['MatlabData/' CCTType dataName 'InsertExact' num2str(numInsertTraj) '.mat'];
        disp(['--------------------']);
        disp(saveFileName);
        
        rng('default'); % reset the random seed so that experiments are reproducable
        
        % uniformly Randomly shuffle the traj in trajData
        newOrder = randperm(numel(trajData(:,1)));
        trajData = trajData(newOrder,:);

        insertTrajData = trajData(1:numInsertTraj,:);
        trajData(1:numInsertTraj,:) = [];

        % build Gonzalez lite CCT
        ConstructCCTGonzLite;
        numConstrCFD = numCFD;
        numConstrDP = numDP;

        % insert traj into CCT
        RandomSampleInsert(numInsertTraj,1); % perform Exact NN searches
        
        save(saveFileName,'trajSimpData','trajOrigData','trajData','queryTraj','clusterTrajNode','clusterNode'); % save the new CCT
        
        eAdd = 0; eMult = 0;
        NNS1;
        QueryResultsAvgStdDev;
        
        % get tree info
        GetAvgTreeHeight;
        GetCCTReductFact;
        [overlapMean, overlapStd] = GetOverlap();

        resultList = [resultList; numInsertTraj numConstrCFD numConstrDP numInsCFD ...
            numInsDP overlapMean overlapStd ceil(avgNodeHeight) ...
            std(totNodeList) maxNodeCnt ceil(log2(size(trajData,1))) ...
            reductFacMean reductFacStd dAvg dStd S1Avg S1Std S2Avg S2Std];
        
    end
end

save(matFile,'resultList');
diary off;