sqSZ = size(queryTraj,1);
sumReach = 0;
for k = 1:sqSZ
    Q = cell2mat(queryTraj(k,1));
    reach = TrajReach(Q);
    sumReach = sumReach + reach;
end

avgReach = sumReach / sqSZ