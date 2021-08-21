% this script runs the NN exact vs approx Test for a list of real world datasets

InitGlobalVars;

scriptName = 'NNExactvsApproxTest';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

NNExactvsApproxTestList = [];

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

exactvsApproxList = [0.1 1 50];

for realListCnt = 1:size(realDataList,2)  
    realDataName = char(realDataList(realListCnt));
    realFolderName = char(realDataFolderList(realListCnt));
    disp(['--------------------']);
    disp(realDataName);
    load(['MatlabData/' realFolderName '/' realDataName]);
    InitDatasetVars(realDataName);
    
    for realListCnt2 = 1:size(exactvsApproxList,2) 
        eMult = exactvsApproxList(realListCnt2);
        ExactNNvsApproxNNRelative;
        ExactApproxResults;
        NNExactvsApproxTestList = [NNExactvsApproxTestList ; expResults1];
    end
    
end

save(matFile,'NNExactvsApproxTestList');
diary off;
