% create trajectory and query structure datatypes (faster than cell datatype)

trajStrData = [];
for i=1:size(trajOrigData,1)
    trajStrData(i).traj = cell2mat(trajOrigData(i,1));
end

TrajDataPreprocessing;

queryStrData = [];
for i=1:size(queryTraj,1)
    queryStrData(i).traj = cell2mat(queryTraj(i,1));
    queryStrData(i).se = cell2mat(queryTraj(i,2));
    queryStrData(i).reduces1 = cell2mat(queryTraj(i,3));
    queryStrData(i).prunenodecnt = cell2mat(queryTraj(i,4));
    queryStrData(i).reduces1sz = cell2mat(queryTraj(i,5));
    queryStrData(i).prunedistcnt = cell2mat(queryTraj(i,6));
    queryStrData(i).reduces1trajid = cell2mat(queryTraj(i,7));
    queryStrData(i).prunes1 = cell2mat(queryTraj(i,8));
    queryStrData(i).prunes1sz = cell2mat(queryTraj(i,9));
    queryStrData(i).decidecfdcnt = cell2mat(queryTraj(i,10));
    queryStrData(i).decidedpcnt = cell2mat(queryTraj(i,11));
    queryStrData(i).decidetrajids = cell2mat(queryTraj(i,12));
    queryStrData(i).decidetrajcnt = cell2mat(queryTraj(i,13));
    queryStrData(i).decideeadd = cell2mat(queryTraj(i,14));
    queryStrData(i).decideemult = cell2mat(queryTraj(i,15));
    
    queryStrData(i).bb1 = cell2mat(queryTraj(i,20));
    queryStrData(i).bb2 = cell2mat(queryTraj(i,21));
    queryStrData(i).bb3 = cell2mat(queryTraj(i,22));
    queryStrData(i).st = cell2mat(queryTraj(i,23));
end