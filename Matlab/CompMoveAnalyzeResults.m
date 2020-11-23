% put query results into a cell structure to make it easier to analyze

cnt = 1;
queryResults2 = {[]};
allClasses = CompMoveData(:,1);
classes = unique(allClasses); % list of unique classes
for i = 1:size(queryResults,1)
    queryResults2(cnt,1) = num2cell(i);
    queryResults2(cnt,2) = num2cell(queryResults(i,1));
    queryResults2(cnt,3) = num2cell(queryResults(i,2));
    queryResults2(cnt,4) = num2cell(queryResults(i,3));
    queryResults2(cnt,5) = classes(queryResults(i,4));
    queryResults2(cnt,6) = classes(queryResults(i,6));
    queryResults2(cnt,7) = num2cell(queryResults(i,5));
    cnt = cnt + 1;
end


% A = [trainLabels modelTrainMat];  
% B = [testLabels modelTestMat];
% C = [A;B];

A = [trainLabels trainMat];  
B = [testLabels testMat];
C = [A;B];

figure(10);
cm = confusionchart(queryResults2(:,5),queryResults2(:,6));
% cm.ColumnSummary = 'column-normalized';

