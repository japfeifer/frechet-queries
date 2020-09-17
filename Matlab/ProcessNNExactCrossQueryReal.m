InitGlobalVars;

scriptName = 'NNExactCrossQueryReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT3';

dataList = ["FootballData" "TaxiData" "NBABasketballData" "GeoLifeData"];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    eAdd = 0; eMult = 0;
    NNS2;
    QueryResultsAvgStdDev;
    resultList = [resultList ; queryResults1];
end

save(matFile,'resultList');
diary off;
