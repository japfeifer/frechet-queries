
sumExactDist = 0;
for k = 1:50
% for k = 1:numQueryTraj
    exactDistList = cell2mat(queryTraj(k,6));
    sumExactDist = sumExactDist + exactDistList(1,2);
end
avgExactDist = sumExactDist/k;