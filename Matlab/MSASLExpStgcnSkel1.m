% This code is specific to the MSASL dataset.
% It exports train and test datasets to ST-GCN format - "layout: 'openpose'", 
% similar to the Kinetics dataset that they use (which is the coco format).
% For info see https://github.com/yysijie/st-gcn/blob/master/OLD_README.md
%
% *** this experiment duplicates training sequences ***
%
% Note that an experiment must first be loaded with trainSet and testSet data
% delete files in the Test and Train folders.
%
% sample command to copy files to Artemis:
% scp *.json jpfe0390@hpc.sydney.edu.au:/project/RDS-FEI-compGestClass-RW/data/cocomsasl/kinetics_train

repeatNum = 20;

% training data
targetFolder = 'C:\Users\johna\Downloads\Export\Train\train';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = trainSet;
MSASLExportStgcnSkeleton1;

labelFile = 'C:\Users\johna\Downloads\Export\kinetics_train_label.json';
typeFile = 'train';
delete(labelFile);
MSASLExportLabel;

repeatNum = 1;

% testing data
targetFolder = 'C:\Users\johna\Downloads\Export\Test\test';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = querySet;
MSASLExportStgcnSkeleton1;

labelFile = 'C:\Users\johna\Downloads\Export\kinetics_val_label.json';
typeFile = 'test';
delete(labelFile);
MSASLExportLabel;
