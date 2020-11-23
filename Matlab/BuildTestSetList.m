testSetList = [];
CurrPredClassID = 32;
CurrActClassID = 24;

for i = 1:size(queryResults,1)
    if queryResults(i,6) == CurrPredClassID && queryResults(i,4) == CurrActClassID
        testSetList(1,end+1) = queryResults(i,1);
    end
end