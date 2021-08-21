InitGlobalVars;

scriptName = 'ProcessConstCCT1RealTaxi';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["TaxiData"];

for iProc = 1:size(dataList,2)   
    trajSimpData = []; trajOrigData = []; queryTraj = []; clusterTrajNode = []; clusterNode = [];
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    CreateTrajStr;

    % construct CCT
    ConstructCCTGonzLite;
    
%     % save result set
%     save(['MatlabData/' CCTType dataName '.mat'],'trajSimpData','trajOrigData','trajStrData','queryTraj','clusterTrajNode','clusterNode'); 
    
    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();
    
    resultList = [resultList ; avgVertBefore avgVert numCFD numDP overlapMean ...
        overlapStd ceil(avgNodeHeight) ...
        std(totNodeList) maxNodeCnt ceil(log2(size(trajStrData,2))) ...
        reductFacMean reductFacStd];

end

save(matFile,'resultList');
diary off;
