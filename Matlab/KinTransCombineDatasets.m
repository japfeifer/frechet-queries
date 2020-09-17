% Combine KinTrans datasets

% concatenate three KinTrans datasets together
load('MatlabData/KintransAirportData.mat');
tmpMoveData = CompMoveData;
load('MatlabData/KintransHealthData.mat');
tmpMoveData = [tmpMoveData; CompMoveData];
load('MatlabData/KintransBankData.mat');
tmpMoveData = [tmpMoveData; CompMoveData];

% remove any duplicate seq
tmpMoveData = sortrows(tmpMoveData,[1,2,3]); % sort by class,subject,seq id
allClasses = tmpMoveData(:,1);
classes = unique(allClasses); % list of unique classes
delCnt = 0;
L2 = [];
for i = 1:size(classes,1) % process each unique class
    classIDs = find(ismember(allClasses,classes(i))); % get list of class ID's for this unique class label
    L1 = zeros(size(classIDs,1),1);
    for j = 1:size(classIDs,1) % process each item in classIDs list
        if L1(j) == 0
            X = cell2mat(tmpMoveData(classIDs(j),4));
            for k = j+1:size(classIDs,1)
                if L1(k) == 0
                    Y = cell2mat(tmpMoveData(classIDs(k),4));
                    if size(X,1) == size(Y,1) && size(X,2) == size(Y,2)
                        if isequal(X,Y)
                            L1(k) = 1;
                            delCnt = delCnt + 1;
                        end
                    end
                end
            end
        end
    end
    L2 = [L2; L1];
end
L2 = logical(L2);
tmpMoveData(L2,:)=[]; % delete duplicates
CompMoveData = tmpMoveData;
% save('KinTransAllData.mat','CompMoveData');
