% Exact/Approx NN Results

szQueryTraj = size(queryTraj,1);
distDiffList = [];
numIdSame = 0;
h = waitbar(0, 'Exact vs Approx Results');

for i = 1:szQueryTraj
    approxValues = cell2mat(queryTraj(i,12));
    exactValues = cell2mat(queryTraj(i,15));
    
    if approxValues(1,1) == exactValues(1,1) % approx and exact traj id's match
        numIdSame = numIdSame + 1;
    else % approx and exact id's do not match
        Q = cell2mat(queryTraj(i,1));
        Papprox = cell2mat(trajData(approxValues(1,1),1));
        Pexact = cell2mat(trajData(exactValues(1,1),1));
        approxDist = ContFrechet(Papprox,Q);
        exactDist = ContFrechet(Pexact,Q);
        distDiff = (approxDist - exactDist) / exactDist;
        distDiffList = [distDiffList; distDiff]; 
    end
    
    if mod(i,10) == 0
        X = ['Exact vs Approx Results: ',num2str(i),'/',num2str(numQueryTraj)];
        waitbar(i/numQueryTraj, h, X);
    end
    
end

close(h);

distDiffAvg = mean(distDiffList);
pctIdSame = numIdSame/szQueryTraj * 100;
disp(['-------------------']);
disp(['Pct ID the same: ',num2str(pctIdSame)]);
disp(['Avg mult error when IDs not the same: ',num2str(distDiffAvg)]);

expResults1 = [pctIdSame distDiffAvg];