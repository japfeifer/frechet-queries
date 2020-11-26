InitGlobalVars;

scriptName = 'NNVaryeMultReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["GeoLifeData"];

procErrorList = [0.0 0.2 0.4 0.6 0.8 1.0 1.5 2.0 2.5 3.0 3.5];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    for jProc = 1:size(procErrorList,2)
        eMult = procErrorList(jProc);
        NNS2;
        QueryResultsAvgStdDev;
        resultList = [resultList ; queryResults1];
    end
end

save(matFile,'resultList');
diary off;
