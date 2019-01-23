    % calculate query result avg and std dev

queryResults1 = [];

% number of cluster centre tree node accesses
pList = [];
for i = 1:size(queryTraj,1)
    pList = [pList; cell2mat(queryTraj(i,4))]; 
end

% size of pruning
pruneList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    if currPrune ~= 0
        pruneList = [pruneList; currPrune];
    end
end

% size of approx cluster centres
clusterList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    currCluster = cell2mat(queryTraj(i,9));
    if currPrune ~= 0
        clusterList = [clusterList; currCluster];
    end
end

% CFD computations
cfdList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    cfd = cell2mat(queryTraj(i,10));
    if currPrune ~= 0
        cfdList = [cfdList; cfd];
    end
end

% FDP computations
fdpList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    fdp = cell2mat(queryTraj(i,11));
    if currPrune ~= 0
        fdpList = [fdpList; fdp];
    end
end

% num results
numresList = [];
for i = 1:size(queryTraj,1)
    currPrune = cell2mat(queryTraj(i,8));
    numres = cell2mat(queryTraj(i,13));
    if currPrune ~= 0
        numresList = [numresList; numres];
    end
end

disp(['-----------------------------']);

pAvg = mean(pList);
pStd = std(pList);
disp(['pAvg:',num2str(pAvg),' pStd:',num2str(pStd)]);

pruneAvg = mean(pruneList);
pruneStd = std(pruneList);
disp(['pruneAvg:',num2str(pruneAvg),' pruneStd:',num2str(pruneStd)]);

clusterAvg = mean(clusterList);
clusterStd = std(clusterList);
disp(['clusterAvg:',num2str(clusterAvg),' clusterStd:',num2str(clusterStd)]);

cfdAvg = mean(cfdList);
cfdStd = std(cfdList);
disp(['cfdAvg:',num2str(cfdAvg),' cfdStd:',num2str(cfdStd)]);

fdpAvg = mean(fdpList);
fdpStd = std(fdpList);
disp(['fdpAvg:',num2str(fdpAvg),' fdpStd:',num2str(fdpStd)]);

numresAvg = mean(numresList);
numresStd = std(numresList);
disp(['numresAvg:',num2str(numresAvg),' numresStd:',num2str(numresStd)]);

queryResults1 = [pAvg pStd pruneAvg pruneStd cfdAvg cfdStd fdpAvg fdpStd];
queryResults2 = [pAvg pStd pruneAvg pruneStd fdpAvg fdpStd numresAvg numresStd];
