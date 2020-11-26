InitGlobalVars;

scriptName = 'InsertImplicitReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
    "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
    "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
    "PenTipData"];

insertPct = [0 0.25 0.50 0.75 1.00];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));

    for jProc = 1:size(insertPct,2) 
        
        load(['MatlabData/' CCTType dataName '.mat']);
        eAdd = 0; eMult = 0;
        numInsertTraj = ceil(size(trajData,1) * insertPct(jProc));
        saveFileName = ['MatlabData/' CCTType dataName 'InsertImplicit' num2str(numInsertTraj) '.mat'];
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
        RandomSampleInsert(numInsertTraj,2); % perform Implicit NN searches
        
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
