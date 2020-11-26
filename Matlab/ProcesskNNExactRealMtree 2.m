InitGlobalVars;

scriptName = 'kNNExactRealMtree';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'Mtree';

% dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
%     "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
%     "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
%     "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
%     "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
%     "PenTipData"];

dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
    "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
    "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
    "PenTipData"];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    kNum = 5;
    kNNSMtree;
    QueryResultsAvgStdDev;
    resultList = [resultList ; queryResultsMtree];
end

save(matFile,'resultList');
diary off;
