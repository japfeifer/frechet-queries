InitGlobalVars;

scriptName = 'ConstCCT2SynTenMillion';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT2';

dataList = ["SyntheticData25"];

for iProc = 1:size(dataList,2)   
    trajSimpData = []; trajOrigData = []; queryTraj = []; clusterTrajNode = []; clusterNode = [];
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
    ConstructCCTApproxRadii;
    
    % save result set
%     save(['MatlabData/' CCTType dataName '.mat'],'trajStrData','queryTraj','clusterTrajNode','clusterNode','-v7.3','-nocompression'); 
%     save(['MatlabData/' CCTType dataName '.mat'],'trajStrData','queryTraj','clusterTrajNode','clusterNode','-v7.3');  

    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();
    
    resultList = [resultList ; overlapMean ...
        overlapStd ceil(avgNodeHeight) ...
        std(totNodeList) maxNodeCnt ceil(log2(size(trajStrData,2))) ...
        reductFacMean reductFacStd];
    
end

save(matFile,'resultList');
diary off;
