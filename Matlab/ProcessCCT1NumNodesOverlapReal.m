InitGlobalVars;

scriptName = 'CCT1NumNodesOverlapReal';
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
    CreateTrajStr;
    
    % get tree info
    [stabMean,stabSTD] = GetCCTTrajOverlap();

    disp(['Num Overlap Nodes Mean: ',num2str(mean(trajOverlapNodesCnt))]);
    disp(['Num Overlap Nodes STD: ',num2str(std(trajOverlapNodesCnt))]);
        
    resultList = [resultList; mean(trajOverlapNodesCnt) std(trajOverlapNodesCnt)];
end

save(matFile,'resultList');
diary off;
