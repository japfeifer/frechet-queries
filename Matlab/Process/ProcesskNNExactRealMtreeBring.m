% this script compares Relaxed CCT vs Mtree for exact Bringman queries on 5
% largest 2-d real data sets.

InitGlobalVars;

scriptName = 'kNNExactRealMtreeBring';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

dataList = ["FootballData" "TaxiData" "GeoLifeData" "Hurdat2AtlanticData" "PenTipData"];

for iProc = 1:size(dataList,2)   
    
    tmpRes = [];
    
    % process Relaxed CCT
    CCTType = 'CCT1';
    
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    CreateTrajStr;
    InitDatasetVars(dataName);

    dirName = 'MatlabData/Bringmann/BringmannQueries/';

    fileName = 'query-0.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    kNum = 11;
    eMult = 0;
    kNNS2;
    QueryResultsAvgStdDev;
    tmpRes = [dAvg dStd cfdAvg cfdStd fdpAvg fdpStd];
    
    % process Relaxed M-Tree
    CCTType = 'Mtree';
    
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);

    dirName = 'MatlabData/Bringmann/BringmannQueries/';

    fileName = 'query-0.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    kNum = 11;
    kNNSMtree;
    QueryResultsAvgStdDev;
    tmpRes = [tmpRes queryResultsMtree];
    resultList = [resultList ; tmpRes];

end

save(matFile,'resultList');
diary off;
