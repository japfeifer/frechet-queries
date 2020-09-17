InitGlobalVars;

scriptName = 'InsertImplicitParentNodeOverlapReal';
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

        numInsertTraj = ceil(size(trajData,1) * insertPct(jProc));
        saveFileName = ['MatlabData/' CCTType dataName 'InsertImplicit' num2str(numInsertTraj) '.mat'];
        disp(['--------------------']);
        disp(saveFileName);
        
        load([saveFileName]);
        
        % get tree info
        [stabMean,stabSTD] = GetCCTTrajOverlap();
        
        resultList = [resultList; stabMean stabSTD];
        
    end
end

save(matFile,'resultList');
diary off;
