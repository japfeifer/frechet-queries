% this script imports a set of Bringmann queries from a file into the queryTraj cell datatype 

InitGlobalVars;

scriptName = 'RNNExactRealBringLessBnd';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["FootballData" "TaxiData" "GeoLifeData" "Hurdat2AtlanticData" "PenTipData"];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);

    dirName = 'MatlabData/Bringmann/BringmannQueries/';

    fileName = 'query-100.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    RNNSearchCompareLessBnd(1,0,2); % type query = exact, do Prune and Reduce stages
    resultList = [resultList ; rnnSearchResults];

end

save(matFile,'resultList');
diary off;
