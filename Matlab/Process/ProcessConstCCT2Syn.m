InitGlobalVars;

scriptName = 'ConstCCT2Syn';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT2';

dataList = ["SyntheticData1" "SyntheticData2" "SyntheticData3" ...
    "SyntheticData4" "SyntheticData5" "SyntheticData6" ...
    "SyntheticData7" "SyntheticData8" "SyntheticData9" ...
    "SyntheticData10" "SyntheticData11" "SyntheticData12" ...
    "SyntheticData13" "SyntheticData14" "SyntheticData15" ...
    "SyntheticData16" "SyntheticData17" "SyntheticData18" ...
    "SyntheticData19" "SyntheticData20" "SyntheticData21" ...
    "SyntheticData22" "SyntheticData23"];

for iProc = 1:size(dataList,2)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    
    load(['MatlabData/CCT1' dataName '.mat']);  % load the CCT1 - use as base to construct CCT2
    CreateTrajStr;
    
    % construct CCT
    ConstructCCTApproxRadii;
    
    % save result set
    saveFileName = ['MatlabData/' CCTType dataName '.mat'];
    tmpScriptName = scriptName;
    tmpBothFile = bothFile;
    tmpMatFile = matFile;
    tmpDiaryFile = diaryFile;
    tmpResultList = resultList;
    tmpCCTType = CCTType;
    tmpDataList = dataList;
    
    clear scriptName bothFile matFile diaryFile resultList CCTType dataList
    save(saveFileName); 
    
    scriptName = tmpScriptName;
    bothFile = tmpBothFile;
    matFile = tmpMatFile;
    diaryFile = tmpDiaryFile;
    resultList = tmpResultList;
    CCTType = tmpCCTType;
    dataList = tmpDataList;
    
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
