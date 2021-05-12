% Load MS-ASL video files, run openpose to extract 2D joint data, and save
% the resulting json files.

maxClassId = 100;
openposeDir = 'C:\Program Files\OpenPose\openpose';
aslDir = 'C:\Users\johna\Downloads\MS-ASL\';

% Import training videos
vidDir = 'C:\Users\johna\Downloads\down-train-id\down-train-id\';
aslFile = 'MSASL_train.json';
resDir = 'C:\Users\johna\Downloads\pose-train-id\';
resFile = 'pose-train-id.log';
resDir2 = 'C:\Users\johna\Downloads\pose-train-id\pose-train-id\';
MSASLImpVid(aslDir,aslFile,resDir,resFile,resDir2,openposeDir,vidDir,maxClassId);

% Import test videos
vidDir = 'C:\Users\johna\Downloads\down-test-id\down-test-id\';
aslFile = 'MSASL_test.json';
resDir = 'C:\Users\johna\Downloads\pose-test-id\';
resFile = 'pose-test-id.log';
resDir2 = 'C:\Users\johna\Downloads\pose-test-id\pose-test-id\';
MSASLImpVid(aslDir,aslFile,resDir,resFile,resDir2,openposeDir,vidDir,maxClassId);