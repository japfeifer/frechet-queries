if datasetType == 1
    % load('MatlabData/KintransHealthData.mat')
    % load('MatlabData/KintransAirportData.mat');
    % load('MatlabData/KintransBankData.mat');
    % load('MatlabData/KintransSmallSampleData.mat');
    load('MatlabData/KintransAllData.mat');
elseif datasetType == 2
    load('MatlabData/MHADData.mat');
elseif datasetType == 3
    load('MatlabData/LMSubSeqData.mat');
elseif datasetType == 4
    load('MatlabData/UCFData.mat');
elseif datasetType == 5
    load('MatlabData/MSRDAData.mat');
end

CompMoveClassID; % create class ID's