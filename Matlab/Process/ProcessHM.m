% Human Movement Experiment

InitGlobalVars;

scriptName = 'HM';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = [];
 
disp(['--------------------']);
disp([scriptName]);

% testType, 1 = kNN, 2 = Num Trainers, 3 = Dist Meas & Traj Features,  
% 4 = Classifier, 5 = Training Method, 6 = Seq Normalize
testType = 1; 
datasetType = 1; % 1 = KinTrans, 2 = MHAD
rngSeed = 1; % random seed value

implicitErrorFlg = 0;
ConstructCCTType = 2;

% test variables
kList = [1;2;3;4;5;6;7;8;9;10]; % number of kNN
numTrainList = [1; 2; 4; 6; 8; 10; 0.01; 0.05; 0.10; 0.20; 0.30; 0.40; 0.50];
% first col is distance measure, second col is traj feature list
distMeasTrajFeatList = {[1 0] 1; ...
                        [1 0] 2; ...
                        [1 0] 3; ...
                        [1 0] 4; ...
                        [1 0] 5; ...
                        [1 0] [1 2 3]; ...
                        [1 0] [1 2 3 4 5 6]; ...
                        [0 1] 1; ...
                        [0 1] 2; ...
                        [0 1] 3; ...
                        [0 1] 4; ...
                        [0 1] 5; ...
                        [0 1] [1 2 3]; ...
                        [0 1] [1 2 3 4 5 6]; ...
                        [1 1] [1 2 3 4 5 6]}; 
classifierList = [1; 2; 3]; % 1 = SVM norm, 2 = SVM ones, 3 = Maj Vote
trainMethodList = [1; 2; 3]; % 1 = No shift, 2 = half/half, 3 = shift one
% seqNormalList, col 1 = neck at origin, col 2 = neck & torso alignment,  
% col 3 = R/L shoulders face camera, col 4 = standard limb lengths, col 5 = at rest pose
seqNormalList = [0 0 0 0 0; 1 0 0 0 0; 0 1 0 0 0; 0 0 1 0 0; ...
                 0 0 0 1 0; 0 0 0 0 1; 1 1 1 1 1]; 
numTestList = [-1];
numBestTrainRepFlgList = [0];

% baselines
baselineList = {1 1  {[1 0] [1]}           1 1 [0 0 0 0 0] -1 0; ...
                2 2  {[1 0] [1 2]}         1 1 [1 1 0 0 0] -1 0; ...
                3 4  {[1 0] [1 2 3]}       1 1 [1 1 1 0 0] -1 0; ...
                4 6  {[1 0] [1 2 3]}       1 1 [1 1 1 1 1] -1 0; ...
                5 8  {[1 0] [1 2 3 4 5 6]} 1 1 [1 1 1 1 1] -1 0; ...
                6 10 {[1 0] [1 2 3 4 5 6]} 1 1 [1 1 1 1 1] -1 0};

LoadModelDataset;
RunModel;

resultList % output the results

save(matFile,'resultList');
diary off;

