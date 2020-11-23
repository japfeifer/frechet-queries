% this code is specific to the KinTrans dataset
% export train and test datasets to ST-GCN format - "layout: 'openpose'",
% similar to the Kinetics dataset that they use.
% for info see https://github.com/yysijie/st-gcn/blob/master/OLD_README.md

% note that an experiment must first be loaded with trainSet and testSet data
% delete files in the Test and Train folders

% training data
targetFolder = 'Export\Train\train';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = trainSet;
KinTransExportStgcnSkeleton1;

labelFile = 'Export\kinetics_train_label.json';
typeFile = 'train';
delete(labelFile);
KinTransExportLabel;


% testing data
targetFolder = 'Export\Test\test';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = querySet;
KinTransExportStgcnSkeleton1;

labelFile = 'Export\kinetics_val_label.json';
typeFile = 'test';
delete(labelFile);
KinTransExportLabel;