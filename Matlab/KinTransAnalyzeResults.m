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
    queryResults2(cnt,6) = classes(queryResults(i,5));
    queryResults2(cnt,7) = CompMoveData(queryResults(i,1),6);
    queryResults2(cnt,8) = CompMoveData(queryResults(i,2),6);
    queryResults2(cnt,9) = CompMoveData(queryResults(i,3),6);
    queryResults2(cnt,10) = num2cell(queryResults(i,7));
    cnt = cnt + 1;
end