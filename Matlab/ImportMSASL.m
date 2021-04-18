% Import the MS-ASL *.json files dataset
% This is a 2-d dataset (x,y axis), so just set z axis to 0

InitGlobalVars;
CompMoveData = {[]};
tic;

% import trainers
trainTest = 1;
fileName = ['C:\Users\johna\Downloads\pose-train-id\pose-train-id.log'];
dirName = ['C:\Users\johna\Downloads\pose-train-id\pose-train-id'];
ImportFncMSASL(trainTest,fileName,dirName);

% import testers
trainTest = 2;
fileName = ['C:\Users\johna\Downloads\pose-test-id\pose-test-id.log'];
dirName = ['C:\Users\johna\Downloads\pose-test-id\pose-test-id'];
ImportFncMSASL(trainTest,fileName,dirName);

timeElapsed = toc;
disp(['timeElapsed: ',num2str(timeElapsed)]);