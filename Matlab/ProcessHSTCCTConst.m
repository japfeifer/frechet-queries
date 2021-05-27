InitGlobalVars;

scriptName = 'ProcessHSTCCTConst';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

% dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
%     "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
%     "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
%     "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
%     "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
%     "PenTipData"];

dataList = ["FootballData"; ...
            "PigeonHomingData"; ...
            "SyntheticLow"; ...
            "SyntheticHigh"];
scrList = ["MatlabData/HSTFootballDataSz1000Meth1.mat"; ...
           "MatlabData/HSTPigeonHomingDataSz1000Meth1.mat"; ...
           "MatlabData/HSTSyntheticLowSz1000Meth1.mat"; ...
           "MatlabData/HSTSyntheticHighSz1000Meth1.mat"];
       
globalBringmann = 0; % do not run bringmann c++ code, instead run matlab code

for iProc = 1:size(dataList,1)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([dataName]);
    disp([scrList(iProc)]);
    
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    
    load([scrList(iProc)]);
%     InitDatasetVars(dataName);
    
    simpLevelCCT = size(inpTrajSz,2); % the level of the simplification tree to store in CCT
    simpPVertIdx = [inpTrajVert(1:inpTrajSz(simpLevelCCT),simpLevelCCT)]';
    szPSimp = inpTrajSz(simpLevelCCT);

    % clear the CCT
    trajStrData = [];
    clusterNode = [];
    clusterTrajNode = [];
    trajStrData = struct;

    % pre-allocate memory (faster)
    maxSz = sum(1:szPSimp-1);
    clusterNode((maxSz*2)-1,7) = 0;
    clusterTrajNode(maxSz,1) = 0;
    trajStrData = struct('traj',[1 1; 1 1],'se',0,'bb1',0,'bb2',0,'bb3',0,'st',0,'ustraj',[1 1; 1 1]);
    trajStrData(1:maxSz) = struct('traj',[1 1; 1 1],'se',0,'bb1',0,'bb2',0,'bb3',0,'st',0,'ustraj',[1 1; 1 1]);

    % generate all pair-wise sub-traj
    tic
    trajCnt = 1;
    for i = 1:szPSimp - 1
        for j = i+1:szPSimp
            newP = inP(simpPVertIdx(i:j),:);
            trajStrData(trajCnt).traj = newP;
            trajStrData(trajCnt).simptrsidx = i; % simplification tree start index (for level simpLevelCCT)
            trajStrData(trajCnt).simptreidx = j; % simplification tree end index (for level simpLevelCCT)
            trajCnt = trajCnt + 1;
        end
    end
    t = toc;
    disp(['Generate all pair-wise sub-traj time (s): ',num2str(t)]);

    % pre-process traj bounds
    tic
    TrajDataPreprocessing;
    t = toc;
    disp(['Pre-process traj bounds time (s): ',num2str(t)]);

    % Construct Relaxed CCT
    tic
    ConstructCCTGonzLite;
    t = toc;
    disp(['Construct Relaxed CCT time (s): ',num2str(t)]);

%     % Construct Aprox Radii CCT
%     tic
%     ConstructCCTApproxRadii;
%     t = toc;
%     disp(['Construct Approx Radii CCT time (s): ',num2str(t)]);

    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();

    fileNameHST = ['MatlabData/HSTCCT' num2str(dataList(iProc)) 'Sz' num2str(size(inP,1)) '.mat'];
    save(fileNameHST,'inP','inpTrajErr','inpTrajErrF','inpTrajPtr','inpTrajSz','inpTrajVert','inpLen','queryStrData','trajStrData','clusterTrajNode','clusterNode','simpLevelCCT','-v7.3');
end

diary off;
