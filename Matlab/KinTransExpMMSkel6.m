% this code is specific to the KinTrans dataset
% It exports train and test datasets to mmskeleton format - for "layout: 'coco'" with 17 joints.
% For 'coco' joints that do not have a direct mapping to a KinTrans
% joint, this export maps them to the origin (the coordiantes are zeros).
% For info see https://github.com/open-mmlab/mmskeleton/blob/master/doc/CUSTOM_DATASET.md

% note that an experiment must first be loaded with trainSet and testSet data
% delete files in the Test and Train folders

idcnt = 0;

% training data
targetFolder = 'Export\Train\train';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = trainSet;
KinTransExportMMSkeleton6;

% testing data
targetFolder = 'Export\Test\test';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = querySet;
KinTransExportMMSkeleton6;
