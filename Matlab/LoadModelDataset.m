
if ~exist('doConfFlg','var')
    doConfFlg = 0;
end

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
elseif datasetType == 6
    if doConfFlg == 1
        load('MatlabData/NTURGBD60NoSimpSingleSubjectConfData.mat');
    else
        load('MatlabData/NTURGBD60NoSimpSingleSubjectData.mat');
    end
    % load('MatlabData/NTURGBD60NoSimpSingleSubjectCutData.mat');
    % load('MatlabData/NTURGBD60NoSimpData.mat');
    % load('MatlabData/NTURGBD60SimpData.mat');
elseif datasetType == 7
    load('MatlabData/MSASLData.mat');
end

CompMoveClassID; % create class ID's

if ~exist('groupClassesFlg','var')
    groupClassesFlg = 0;
end

if ~exist('subsetClassesFlg','var')
    subsetClassesFlg = 0;
end

if groupClassesFlg == 1
    for i = 1:size(groupClassesList,1)
        currGrpClsLst = cell2mat(groupClassesList(i,1));
        currGrpClsNew = cell2mat(groupClassesList(i,2));
        for j = 1:size(CompMoveData,1)
            currClassID = cell2mat(CompMoveData(j,5));
            if ismember(currClassID,currGrpClsLst) == 1
                CompMoveData(j,1) = {['Group ' num2str(currGrpClsNew)]};
                CompMoveData(j,5) = {currGrpClsNew};
            end
        end
    end
end

if subsetClassesFlg == 1
    CompMoveDataTmp = {[]};
    cnt = 1;
    for i = 1:size(CompMoveData,1)
        currClassID = cell2mat(CompMoveData(i,5));
        if ismember(currClassID,subsetClassesList) == 1
            CompMoveDataTmp(cnt,1:5) = CompMoveData(i,:);
            cnt = cnt + 1;
        end
    end
    CompMoveData = CompMoveDataTmp;
    CompMoveDataTmp = {[]};
end