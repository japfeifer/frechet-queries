InitGlobalVars;

scriptName = 'ConstCCT1SynOneMillion';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["SyntheticData24"];

for iProc = 1:size(dataList,2)   
    trajSimpData = []; trajOrigData = []; trajData = []; queryTraj = []; clusterTrajNode = []; clusterNode = [];
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    
    InitSyntheticDatasetVars;
    GenerateTraj;
    RandomSampleQuery;
    QueryDataPreprocessing;
    GenerateNoiseTraj;
    TrajDataPreprocessing;
    AverageVert

    % construct CCT
    ConstructCCTGonzLite;
    
    % save result set
    save(['MatlabData/' CCTType dataName '.mat'],'trajSimpData','trajOrigData','trajData','queryTraj','clusterTrajNode','clusterNode');  
    
    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();
    
    resultList = [resultList ; avgVert avgVert numCFD numDP overlapMean ...
        overlapStd ceil(avgNodeHeight) ...
        std(totNodeList) maxNodeCnt ceil(log2(size(trajData,1))) ...
        reductFacMean reductFacStd];

end

save(matFile,'resultList');
diary off;
