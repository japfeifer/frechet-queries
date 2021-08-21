% test more advanced sub-traj CCT construction method (has query error)

InitGlobalVars;

scriptName = 'ProcessConstCCT1KrugerBuffaloSubTrajTest2';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

resultList = [];

CCTType = 'CCT1';

dataList = ["KrugerBuffaloData"];

for iProc = 1:size(dataList,2)   
    tProcess = tic;
    
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    CreateTrajStr2;

    % choose a trajectory P
    Pidx = 2;
    P = cell2mat(trajOrigData(Pidx,1));

    % find a good simplification error err, and its subtrajectory PSimp, for P
    [err,idxListP,PSimp,maxSegLenP,maxSegLenPSimp] = DriemelError(P,5,1);
    disp(['err: ',num2str(err),' size P: ',num2str(size(P,1)),' size simp P: ',num2str(size(PSimp,1)),' maxSegLenP: ',num2str(maxSegLenP),' maxSegLenPSimp: ',num2str(maxSegLenPSimp)]);
    szPSimp = size(PSimp,1);
    
    doDFD = false;

    % clear the CCT
    trajStrData = [];
    clusterNode = [];
    clusterTrajNode = [];
    trajStrData = struct;
    queryStrData = [];

    % pre-allocate memory (faster)
    maxSz = sum(1:szPSimp-1);
    clusterNode((maxSz*2)-1,7) = 0;
    clusterTrajNode(maxSz,1) = 0;
    trajStrData = struct('traj',[1 1; 1 1],'se',0,'bb1',0,'bb2',0,'bb3',0,'st',0,'ustraj',[1 1; 1 1]);
    trajStrData(1:maxSz) = struct('traj',[1 1; 1 1],'se',0,'bb1',0,'bb2',0,'bb3',0,'st',0,'ustraj',[1 1; 1 1]);

    % process each pair-wise sub-traj from simplified P
    nextTrajID = 1;
    szNode = 0;
    totNumInsCFD = 0;
    totNumInsDP = 0;

    time1Sum = 0;
    h = waitbar(0, 'Insert sub traj into CCT');
    for i = 1:szPSimp - 1
        X = ['Insert sub traj i: ',num2str(i)];
        waitbar(i/szPSimp, h, X);
        t1 = tic;
        time2Sum = 0;
        time3Sum = 0;
        time4Sum = 0;
        time5Sum = 0;
        time6Sum = 0;
        for j = i+1:szPSimp

            subPSimp = PSimp(i:j,:); % get Driemel simplified traj
            subP = P(idxListP(i):idxListP(j),:);
            subPSimp = TrajSimp(subP,err); % using the underlying non-simp sub traj, get the agarwal simplification

            % insert sub-traj into CCT
            [numCFD, numDP, nextTrajID] = SubTrajInsCCT(subPSimp,subP,2,nextTrajID,err);
            totNumInsCFD = totNumInsCFD + numCFD;
            totNumInsDP = totNumInsDP + numDP;

            time2Sum = time2Sum + time2;
            time3Sum = time3Sum + time3;
            time4Sum = time4Sum + time4;

        end
        time1 =  toc(t1);
        time1Sum = time1Sum + time1;
        disp(['i: ',num2str(i),' time1: ',num2str(time1),' time2Sum: ',num2str(time2Sum),...
            ' time3Sum: ',num2str(time3Sum),' time4Sum: ',num2str(time4Sum),...
            ' time5Sum: ',num2str(time5Sum),' time6Sum: ',num2str(time6Sum)]);

    end
    close(h);
    
    % trim results
    clusterNode = clusterNode(1:szNode,:);
    clusterTrajNode = clusterTrajNode(1:nextTrajID-1,:);
    trajStrData = trajStrData(1:nextTrajID-1);
    
    disp(['totNumInsCFD: ',num2str(totNumInsCFD)]);
    disp(['totNumInsDP: ',num2str(totNumInsDP)]);

%     % construct CCT
%     ConstructCCTGonzLite;
    

    % get tree info
    GetAvgTreeHeight;
    GetCCTReductFact;
    [overlapMean, overlapStd] = GetOverlap();
    
    timeProcess = toc(tProcess);
    disp(['timeProcess: ',num2str(timeProcess)]);
    
%     resultList = [resultList ; avgVertBefore avgVert numCFD numDP overlapMean ...
%         overlapStd ceil(avgNodeHeight) ...
%         std(totNodeList) maxNodeCnt ceil(log2(size(trajStrData,2))) ...
%         reductFacMean reductFacStd];

end

% save(matFile,'resultList');
diary off;
