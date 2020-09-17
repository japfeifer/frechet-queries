% this script imports a set of Bringmann queries from a file into the queryTraj cell datatype 

InitGlobalVars;

scriptName = 'RNNCCTvsBringSyn';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["SyntheticData1" "SyntheticData2" "SyntheticData3" ...
    "SyntheticData4" "SyntheticData5" "SyntheticData6" ...
    "SyntheticData7" "SyntheticData8" "SyntheticData9" ...
    "SyntheticData10" "SyntheticData11" "SyntheticData12" ...
    "SyntheticData13" "SyntheticData14" "SyntheticData15" ...
    "SyntheticData16" "SyntheticData17" ...
    "SyntheticData22" "SyntheticData23"];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);

    dirName = 'MatlabData/Bringmann/BringmannQueries/';

    fileName = 'query-0.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    RNNSearchCompare(1,0,2); % type query = exact, do Prune and Reduce stages
    resultList = [resultList ; rnnSearchResults];

    fileName = 'query-1.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    RNNSearchCompare(1,0,2); % type query = exact, do Prune and Reduce stages
    resultList = [resultList ; rnnSearchResults];

    fileName = 'query-10.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    RNNSearchCompare(1,0,2); % type query = exact, do Prune and Reduce stages
    resultList = [resultList ; rnnSearchResults];

    fileName = 'query-100.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    RNNSearchCompare(1,0,2); % type query = exact, do Prune and Reduce stages
    resultList = [resultList ; rnnSearchResults];

    fileName = 'query-1000.txt';
    disp(['--------------------']);
    disp(fileName);
    ProcBringQueries(fileName,dataName,dirName);
    QueryDataPreprocessing;
    RNNSearchCompare(1,0,2); % type query = exact, do Prune and Reduce stages
    resultList = [resultList ; rnnSearchResults];
end

save(matFile,'resultList');
diary off;
