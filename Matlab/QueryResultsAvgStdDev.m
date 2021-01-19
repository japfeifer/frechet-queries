% calculate query result avg and std dev

queryResults1 = [];

% number of cluster centre tree distance computations
distList = [];
% for i = 1:size(queryTraj,1)
%     distList = [distList; cell2mat(queryTraj(i,6))]; 
% end
for i = 1:size(queryStrData,2)
    distList = [distList; queryStrData(i).prunedistcnt]; 
end

% number of cluster centre tree node accesses
pList = [];
% for i = 1:size(queryTraj,1)
%     pList = [pList; cell2mat(queryTraj(i,4))]; 
% end
for i = 1:size(queryStrData,2)
    pList = [pList; queryStrData(i).prunenodecnt]; 
end

% size of S1
S1List = [];
% for i = 1:size(queryTraj,1)
%     currPrune = cell2mat(queryTraj(i,9));
for i = 1:size(queryStrData,2)
    currPrune = queryStrData(i).prunes1sz;
    if currPrune ~= 0
        S1List = [S1List; currPrune];
    end
end

% size of S2
S2List = [];
% for i = 1:size(queryTraj,1)
%     currPrune = cell2mat(queryTraj(i,5));
for i = 1:size(queryStrData,2)
    currPrune = queryStrData(i).reduces1sz;
    if currPrune ~= 0
        S2List = [S2List; currPrune];
    end
end

% CFD computations
cfdList = [];
% for i = 1:size(queryTraj,1)
%     currPrune = cell2mat(queryTraj(i,5));
%     cfd = cell2mat(queryTraj(i,10));
for i = 1:size(queryStrData,2)
    currPrune = queryStrData(i).reduces1sz;
    cfd = queryStrData(i).decidecfdcnt;
    if currPrune ~= 0
        cfdList = [cfdList; cfd];
    end
end

% FDP computations
fdpList = [];
% for i = 1:size(queryTraj,1)
%     currPrune = cell2mat(queryTraj(i,5));
%     fdp = cell2mat(queryTraj(i,11));
for i = 1:size(queryStrData,2)
    currPrune = queryStrData(i).reduces1sz;
    fdp = queryStrData(i).decidedpcnt;
    if currPrune ~= 0
        fdpList = [fdpList; fdp];
    end
end

% num results
numresList = [];
% for i = 1:size(queryTraj,1)
%     currPrune = cell2mat(queryTraj(i,5));
%     numres = cell2mat(queryTraj(i,13));
for i = 1:size(queryStrData,2)
    currPrune = queryStrData(i).reduces1sz;
    numres = queryStrData(i).decidetrajcnt;
    if currPrune ~= 0
        numresList = [numresList; numres];
    end
end

disp(['-----------------------------']);

dAvg = mean(distList);
dStd = std(distList);
disp(['LBConstAvg:',num2str(dAvg),' LBConstStd:',num2str(dStd)]);

pAvg = mean(pList);
pStd = std(pList);
disp(['MtreeNodeVisitsAvg:',num2str(pAvg),' MtreeNodeVisitsStd:',num2str(pStd)]);

% pAvg = mean(pList);
% pStd = std(pList);
% disp(['AllVisitAvg:',num2str(pAvg),' AllVisitStd:',num2str(pStd)]);

S1Avg = mean(S1List);
S1Std = std(S1List);
disp(['S1Avg:',num2str(S1Avg),' S1Std:',num2str(S1Std)]);

S2Avg = mean(S2List);
S2Std = std(S2List);
disp(['S2Avg:',num2str(S2Avg),' S2Std:',num2str(S2Std)]);

cfdAvg = mean(cfdList);
cfdStd = std(cfdList);
disp(['cfdAvg:',num2str(cfdAvg),' cfdStd:',num2str(cfdStd)]);

fdpAvg = mean(fdpList);
fdpStd = std(fdpList);
disp(['fdpAvg:',num2str(fdpAvg),' fdpStd:',num2str(fdpStd)]);

numresAvg = mean(numresList);
numresStd = std(numresList);
disp(['numresAvg:',num2str(numresAvg),' numresStd:',num2str(numresStd)]);

queryResults1 = [dAvg dStd S1Avg S1Std S2Avg S2Std cfdAvg cfdStd fdpAvg fdpStd];
queryResults2 = [dAvg dStd S1Avg S1Std S2Avg S2Std fdpAvg fdpStd numresAvg numresStd];
queryResultsCCT3 = [dAvg dStd];
queryResultsMtree = [pAvg pStd cfdAvg cfdStd fdpAvg fdpStd];
