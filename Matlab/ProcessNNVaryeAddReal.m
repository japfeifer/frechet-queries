InitGlobalVars;

scriptName = 'NNVaryeAddReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["GeoLifeData"];

procErrorList = [0.000 0.001 0.002 0.003 0.004 0.005 0.006 0.007 0.008 0.009 0.010];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    for jProc = 1:size(procErrorList,2)
        eAdd = procErrorList(jProc);
        NNS1;
        QueryResultsAvgStdDev;
        resultList = [resultList ; queryResults1];
    end
end

save(matFile,'resultList');
diary off;
