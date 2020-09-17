InitGlobalVars;

scriptName = 'kNNVaryk';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["FootballData" "Hurdat2AtlanticData"];

kNNVarykValues = [2 4 8 16 32 64 128];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    eAdd = 0; eMult = 0;
    
    for jProc = 1:size(kNNVarykValues,2)
        kNum = kNNVarykValues(jProc);
        kNNS2;
        QueryResultsAvgStdDev;
        resultList = [resultList ; queryResults1];
    end

end

save(matFile,'resultList');
diary off;
