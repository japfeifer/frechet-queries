% test naive brute-force (no query error)

InitGlobalVars;

scriptName = 'ProcessConstCCT1KrugerBuffaloSubTrajTest';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["KrugerBuffaloData"];

for iProc = 1:size(dataList,2)   
    trajSimpData = []; trajOrigData = []; queryTraj = []; clusterTrajNode = []; clusterNode = [];
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    InitDatasetVars(dataName);
    
    % load trajectory input file
    load(['MatlabData/RealInputData/' dataName '.mat']);  
    CreateTrajStr2;
    
    % generate all pair-wise sub-traj
    Pidx = 1;
    P = trajStrData(Pidx).traj;
    sizeofP = size(P,1);
    trajStrData = [];
    trajCnt = 1;
    for i = 1:size(P,1)
        for j = i:size(P,1)
            newP = P(i:j,:);
            trajStrData(trajCnt).traj = newP;
            trajCnt = trajCnt + 1;
        end
    end
    
    
    % generate queries and Pre-process input
    InitDatasetVars(dataName);
    TrajDataPreprocessing;
    GenerateQueryTraj;
    QueryDataPreprocessing;
    
    % construct CCT
    ConstructCCTGonzLite;
    
    % get n-th largest cluster radius
    clusterNodeTmp = sortrows(clusterNode,4,'descend');
    nthClustRad = clusterNodeTmp(sizeofP,4);
    dispFact = 100;
    disp(['nthClustRad: ',num2str(nthClustRad*dispFact)]);
    
    
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
