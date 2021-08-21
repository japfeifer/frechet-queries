InitGlobalVars;

scriptName = 'ConstCCT3Real';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT3';

dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
    "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
    "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
    "PenTipData"];

for iProc = 1:size(dataList,2)   
    trajSimpData = []; trajOrigData = []; queryTraj = []; clusterTrajNode = []; clusterNode = [];
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    InitDatasetVars(dataName);
    
    load(['MatlabData/CCT1' dataName '.mat']);  % load the CCT1 - use as base to construct CCT3
    CreateTrajStr;
    
    % construct CCT
    ConstructCCTGonzComplete();
    
%     % save result set
%     save(['MatlabData/' CCTType dataName '.mat'],'trajSimpData','trajOrigData','trajStrData','queryTraj','clusterTrajNode','clusterNode'); 

    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();
    
    resultList = [resultList ; numCFD numDP overlapMean ...
        overlapStd ceil(avgNodeHeight) ...
        std(totNodeList) maxNodeCnt ceil(log2(size(trajStrData,2))) ...
        reductFacMean reductFacStd];

end

save(matFile,'resultList');
diary off;
