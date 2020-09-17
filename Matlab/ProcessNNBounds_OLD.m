% this script runs the NN Bounds Test for a list of real world datasets

InitGlobalVars;

scriptName = 'NNBoundsTest';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

NNBoundsTestList = [];

realDataList = ["ResultsTruckData.mat" "ResultsSchoolBusData.mat" "ResultsPetCatsData.mat" ...
    "ResultsShippingMississippiData.mat" "ResultsShippingYangtzeData.mat" "ResultsFootballData.mat" ...
    "ResultsTaxiData.mat" "ResultsBlackBackedGullsData.mat" "ResultsPigeonHomingData.mat" ...
    "ResultsMaskedBoobiesData.mat" "ResultsKrugerBuffaloData.mat" "ResultsTrawlingBatsData.mat" ...
    "ResultsNBABasketballData.mat" "ResultsGeoLifeData.mat" "ResultsHurdat2AtlanticData.mat" ...
    "ResultsPenTipData.mat"];
    
realDataFolderList = ["TrucksData" "SchoolBusData" "PetCatsData" ...
    "ShippingVesselData"  "ShippingVesselData" "FootballData" ...
    "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2Data" ...
    "PenTipData"];

for realListCnt = 1:size(realDataList,2)
    realDataName = char(realDataList(realListCnt));
    realFolderName = char(realDataFolderList(realListCnt));
    disp(['--------------------']);
    disp(realDataName);
    load(['MatlabData/' realFolderName '/' realDataName]);
    InitDatasetVars(realDataName);
    eAdd = 0; eMult = 0;
    NNBoundsTest;
    BoundsTestResult;
    NNBoundsTestList = [NNBoundsTestList ; boundsTestRes];
end

save(matFile,'NNBoundsTestList');
diary off;
