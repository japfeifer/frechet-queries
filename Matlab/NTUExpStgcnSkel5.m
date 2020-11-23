% This code is specific to the NTU dataset.
% Export train and test datasets to ST-GCN format - "layout: 'ntu-rgb+d'" with 25 joints.

% *** this experiment DOES NOT duplicate sequences ***
% For info see https://github.com/shahroudy/NTURGB-D/blob/master/Matlab/read_skeleton_file.m
% and https://github.com/shahroudy/NTURGB-D/blob/master/README.md

% note that an experiment must first be loaded with trainSet and testSet data
% delete files in the Test and Train folders

skelTrackID = 1;  % skeleton tracking ID

% training data
repeatNum = 1;
targetFolder = 'C:\Users\jpfe0390\Documents\MATLAB\Export\Train\';
% targetFolder = 'Export\Train\';
targetType = 1;
delete([targetFolder,'*.skeleton']);
currSeqSet = {[]};
currSeqSet = trainSet;
NTUExportStgcnSkeleton5;

% testing data
repeatNum = 1;
targetFolder = 'C:\Users\jpfe0390\Documents\MATLAB\Export\Test\';
% targetFolder = 'Export\Test\';
targetType = 2;
delete([targetFolder,'*.skeleton']);
currSeqSet = {[]};
currSeqSet = querySet;
NTUExportStgcnSkeleton5;
