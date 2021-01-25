NumTrain = 2;
rngSeed = 1;

rng(rngSeed); % reset random seed so experiments are reproducable

% load('MatlabData/KintransHealthData.mat')
load('MatlabData/KintransAirportData.mat');
% load('MatlabData/KintransBankData.mat');
% load('MatlabData/KintransSmallSampleData.mat');

KinTransTransformData(NumTrain); % create query and input sets
% KinTransTransformDataAng(1); % create query and input sets

% create inputSet2
% inputSet = [inputSet; querySet]; % concatenate input and query sets;
inputSet = sortrows(inputSet,[2 1],'ascend'); % sort by word id, then sample id
trajCounter = 0;
inputSet2 = {[]};
numInputTraj = size(inputSet,1);
inputSet2(numInputTraj,1:2) = {0}; % pre-populate trajData with nulls - performance improvement
trajDim = size(cell2mat(inputSet(1,3)),2);
for i=1:numInputTraj
    currTraj = [];
    for j=1:size(inputSet,2)-2 % for each trajectory
        tmpTraj = cell2mat(inputSet(i,j+2));
        idx1 = j*trajDim - trajDim+1;
        idx2 = idx1 + trajDim - 1;
        currTraj(:,idx1:idx2) = tmpTraj;
    end
    % store the new traj
    trajCounter = trajCounter + 1;
    inputSet2(trajCounter,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
    inputSet2(trajCounter,2) = inputSet(trajCounter,2);
end        

inputMat = zeros(numInputTraj);

h = waitbar(0, 'Compute Frechet');

for i=1:numInputTraj
    if mod(i,1) == 0
        X = ['Compute Frechet ',num2str(i),'/',num2str(numInputTraj)];
        waitbar(i/numInputTraj, h, X);
    end    
    P = cell2mat(inputSet2(i,1));
    for j=1:numInputTraj
        if i/j >= 1 % only compute left/bottom triangle of matrix
            if i~=j % if different traj then compute
                Q = cell2mat(inputSet2(j,1));
                dist = ContFrechet(P,Q);
%                 dist = GetBestConstLB(P,Q);
                inputMat(i,j) = dist;
            else
                inputMat(i,j) = 0; % traj are the same
            end
        end
    end
end
close(h);

% normalize results to [0 1]
normA = inputMat - min(inputMat(:));
normA = normA ./ max(normA(:));
inputMat = normA;

inputMat = tril(inputMat)+tril(inputMat,-1)'; % mirror lower triangle to upper triangle in matrix

% axVal = strings(1,numInputTraj);
% axValCnt = 1;
% % compute X and Y axis tick labels
% for i=1:numInputTraj
%     if mod(i-1,numSample) == 0
%         axVal(1,axValCnt) = num2str(cell2mat(inputSet2(axValCnt,2)));
%     else
%         axVal(1,axValCnt) = "";
%     end
%     axValCnt = axValCnt + 1;
% end

figure
% axes('Units', 'normalized', 'Position', [0 0 1 1])
hm = heatmap(inputMat);
cmap = bone(256);
cmap = flipud(cmap);
hm.Colormap = cmap;
hm.ColorScaling = 'log';
hm.GridVisible = 'off';
hm.XLabel = 'Word Id''s';
hm.YLabel = 'Word Id''s';
hm.XDisplayLabels = axVal;
hm.YDisplayLabels = axVal;

