InitGlobalVars;

scriptName = 'ConstCCT2Real';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT2';

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
    InitDatasetVars(dataName);
    
    load(['MatlabData/CCT1' dataName '.mat']);  % load the CCT1 - use as base to construct CCT2
    CreateTrajStr;
    
    % construct CCT
    ConstructCCTApproxRadii;
    
%     % save result set
%     saveFileName = ['MatlabData/' CCTType dataName '.mat'];
%     tmpScriptName = scriptName;
%     tmpBothFile = bothFile;
%     tmpMatFile = matFile;
%     tmpDiaryFile = diaryFile;
%     tmpResultList = resultList;
%     tmpCCTType = CCTType;
%     tmpDataList = dataList;
%     
%     clear scriptName bothFile matFile diaryFile resultList CCTType dataList
%     save(saveFileName); 
%     
%     scriptName = tmpScriptName;
%     bothFile = tmpBothFile;
%     matFile = tmpMatFile;
%     diaryFile = tmpDiaryFile;
%     resultList = tmpResultList;
%     CCTType = tmpCCTType;
%     dataList = tmpDataList;
    
    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();
    
    resultList = [resultList ; overlapMean ...
        overlapStd ceil(avgNodeHeight) ...
        std(totNodeList) maxNodeCnt ceil(log2(size(trajStrData,2))) ...
        reductFacMean reductFacStd];

end

save(matFile,'resultList');
diary off;
