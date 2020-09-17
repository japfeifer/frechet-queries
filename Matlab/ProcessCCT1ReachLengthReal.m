InitGlobalVars;

scriptName = 'CCT1ReachLengthReal';
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
    
    sqSZ = size(trajData,1);
    reachList = [];
    for i = 1:sqSZ
        P = cell2mat(trajData(i,1));
        reach = TrajReach(P);
        reachList(end+1) = reach;
    end

    avgReach = mean(reachList);
    stdReach = std(reachList);

    lengthList = [];
    for i = 1:sqSZ
        P = cell2mat(trajData(i,1));
        length = TrajLength(P);
        lengthList(end+1) = length;
    end

    avgLength = mean(lengthList);
    stdLength = std(lengthList);
        
    resultList = [resultList; avgReach stdReach avgLength stdLength];
end

save(matFile,'resultList');
diary off;
