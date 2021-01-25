% Avg exact NN distance
%
% First run NNS1 with exact search
% Then run this script to calc avg exact NN distance for the queries

szQueryTraj = size(queryTraj,1);
sumDist = 0;
h = waitbar(0, 'Avg exact NN distance');

for i = 1:szQueryTraj
    PID = cell2mat(queryTraj(i,12));
    Q = cell2mat(queryTraj(i,1));
    P = cell2mat(trajData(PID(1,1),1));
    exactDist = ContFrechet(P,Q);
    sumDist = sumDist + exactDist;
    
    if mod(i,10) == 0
        X = ['Avg exact NN distance: ',num2str(i),'/',num2str(numQueryTraj)];
        waitbar(i/numQueryTraj, h, X);
    end
    
end

close(h);

avgDist = sumDist / szQueryTraj