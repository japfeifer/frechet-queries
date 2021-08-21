InitGlobalVars;

scriptName = 'ProcessCCT1TrajSizeStatsReal';
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
    
    szList = [];
    szList(size(trajStrData,2),1) = 0;
    for i = 1:size(trajStrData,2)
        R = trajStrData(i).traj;
        currSz = size(R,1);
        szList(i) = currSz;
    end
    mean1 = mean(szList);

    if size(trajOrigData,1) > 0
        szList = [];
        szList(size(trajOrigData,1),1) = 0;
        for i = 1:size(trajOrigData,1)
            R = cell2mat(trajOrigData(i,1));
            currSz = size(R,1);
            szList(i) = currSz;
        end
        mean2 = mean(szList);
    else
        mean2 = 0;
    end
        
    resultList = [resultList; mean1 mean2];
end

save(matFile,'resultList');
diary off;
