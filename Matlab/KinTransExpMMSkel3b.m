% This code is specific to the KinTrans dataset.
% It exports train and test datasets to MMSkeleton format - for "layout: 'openpose'" with 18 joints.
% For 'openpose' joints that do not have a direct mapping to a KinTrans
% joint, this export interpolates the joints.
% For info see https://github.com/open-mmlab/mmskeleton/blob/master/doc/CUSTOM_DATASET.md

% Note that an experiment must first be loaded with trainSet and testSet data.
% It deletes previous *.json files in the Test and Train folders.

idcnt = 0;

% training data
targetFolder = 'Export\Train\train';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = trainSet;
KinTransExportMMSkeleton3b;

% testing data
targetFolder = 'Export\Test\test';
delete([targetFolder,'*.json']);
currSeqSet = {[]};
currSeqSet = querySet;
KinTransExportMMSkeleton3b;
