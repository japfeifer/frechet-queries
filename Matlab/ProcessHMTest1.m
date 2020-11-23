% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMTest1';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

datasetType = 4; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF

% load the dataset
LoadModelDataset;

parfor i=1:1000 % do this to startup the parallel pool
	a=0;
end

tic;
rowMax = size(CompMoveData,1);
colMax = size(CompMoveData,1);
distList(1:rowMax,1:colMax) = 0;
totCells = rowMax * colMax;
distList2(1,1:totCells) = 0;

parfor i = 1:totCells
    currRow = floor((i - 1) / colMax) + 1;
    currCol = mod(i,colMax);
    if currCol == 0
        currCol = colMax;
    end
    seq1  = cell2mat(CompMoveData(currRow,4));
    seq2  = cell2mat(CompMoveData(currCol,4));
    distList2(1,i) = dtw(seq1',seq2','euclidean');
end


% parfor i = 1:iMax
%     seq1  = cell2mat(CompMoveData(i,4));
%     for j = 1:jMax
%         seq2  = cell2mat(CompMoveData(j,4));
%         distList(i,j) = dtw(seq1',seq2','euclidean');
%     end
% end

toc;

save(matFile,'resultList');
diary off;

