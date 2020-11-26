InitGlobalVars;

scriptName = 'RNNVaryTauReal';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["NBABasketballData"];

varyTauList = [1.0 1.2 1.4 1.6 1.8 2.0 2.2 2.4 2.6 2.8];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    eAdd = 0; eMult = 0;
    for jProc = 1:size(varyTauList,2)
        tau = varyTauList(jProc);
        RNNS2;
        QueryResultsAvgStdDev;
        resultList = [resultList ; queryResults2];
    end
end

save(matFile,'resultList');
diary off;
