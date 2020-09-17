% ExactNNvsHVRes Exact NN vs HV NN results

szQueryTraj = size(queryTraj,1);
numQuerySame = 0;
COSDistSum = 0;

for i = 1:szQueryTraj
    exactValues = cell2mat(queryTraj(i,12));
    HVValues = cell2mat(queryTraj(i,15));
    COSDist = cell2mat(queryTraj(i,16));
    COSDistSum = COSDistSum + COSDist;
    
    if exactValues(1,1) == HVValues(1,1) % approx and exact traj id's match
        numQuerySame = numQuerySame + 1;
    end

end


COSDistAvg = COSDistSum / szQueryTraj;
pctIdSame = numQuerySame/szQueryTraj * 100;
disp(['-------------------']);
disp(['Pct ID the same: ',num2str(pctIdSame)]);
disp(['Avg COS Dist: ',num2str(COSDistAvg)]);

expResults3 = [pctIdSame COSDistAvg];