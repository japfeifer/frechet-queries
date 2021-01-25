InitGlobalVars;

scriptName = 'ConstMtreeReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

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
    trajSimpData = []; trajOrigData = []; queryTraj = []; clusterTrajNode = []; clusterNode = [];
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp(['M-tree Construction']);
    disp([dataName]);
    InitDatasetVars(dataName);
    
    load(['MatlabData/CCT1' dataName '.mat']);  % load the CCT1 - use as base to construct M-tree
    CreateTrajStr;
    
    % construct M-tree
    ConstructMtree;
    
    % save result set
    save(['MatlabData/Mtree' dataName '.mat'],'trajSimpData','trajOrigData','trajStrData','queryTraj','clusterTrajNode','clusterNode','mTree','mTreeRootId','mTreeNodeCapacity','mTreePtrList','mTreeMaxCol');

    resultList = [resultList ; numCFD numDP];

end

save(matFile,'resultList');
diary off;
