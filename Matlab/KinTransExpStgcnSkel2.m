% this code is specific to the KinTrans dataset
% export train and test datasets to ST-GCN format - "layout: 'openpose'",
% For 'openpose' joints that do not have a direct mapping to a KinTrans
% joint, this export maps them to the origin (the coordiantes are zeros).
% for info see https://github.com/yysijie/st-gcn/blob/master/OLD_README.md

% note that an experiment must first be loaded with trainSet and testSet data
% delete files in the Test and Train folders

% training data
targetFolder = 'Export\Train\train';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = trainSet;
KinTransExportStgcnSkeleton2;

labelFile = 'Export\kinetics_train_label.json';
typeFile = 'train';
delete(labelFile);
KinTransExportLabel;


% testing data
targetFolder = 'Export\Test\test';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = querySet;
KinTransExportStgcnSkeleton2;

labelFile = 'Export\kinetics_val_label.json';
typeFile = 'test';
delete(labelFile);
KinTransExportLabel;