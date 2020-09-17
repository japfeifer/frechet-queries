% store a unique class ID for each seq
CompMoveData = sortrows(CompMoveData,[1,2,3]); % sort by class,subject,seq id
allClasses = CompMoveData(:,1);
classes = unique(allClasses); % list of unique classes
for i = 1:size(classes,1) % process each unique class
    classIDs = find(ismember(allClasses,classes(i))); % get list of class ID's for this unique class label
    for j = 1:size(classIDs,1) % process each item in classIDs list
        CompMoveData(classIDs(j),5) = num2cell(i); 
    end
end