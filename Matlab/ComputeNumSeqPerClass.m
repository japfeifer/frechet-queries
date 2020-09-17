allClasses = CompMoveData(:,1);
classes = unique(allClasses); 
x = [];
for i = 1:size(classes,1) % process each unique class
        classIDs = find(ismember(allClasses,classes(i)));
    x(end+1,1) = size(classIDs,1);
end
disp(['min: ',num2str(min(x)),', max: ',num2str(max(x)),', mean: ',num2str(mean(x)),', median: ',num2str(median(x))]);

h = histogram(x,40);
