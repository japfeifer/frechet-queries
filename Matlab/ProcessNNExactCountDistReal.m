InitGlobalVars;

scriptName = 'NNExactCountDistReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
    "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
    "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
    "PenTipData"];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    eAdd = 0; eMult = 0;
    NNS2;
    QueryResultsAvgStdDev;
    zeroFrechet = sum(cell2mat(queryTraj(:,10)) == 0);
    oneFrechet = sum(cell2mat(queryTraj(:,10)) == 1);
    twoOrMoreFrechet = sum(cell2mat(queryTraj(:,10)) >= 2);
    resultList = [resultList ; zeroFrechet oneFrechet twoOrMoreFrechet];
end

save(matFile,'resultList');
diary off;
