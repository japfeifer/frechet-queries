rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
jNum = 1000;
kNum = 100;
timeBringFDP = 0;
timeCutFDP = 0;

h = waitbar(0, 'Test FDP');

for j = 1:jNum

    % get a P and Q curve
    sz = size(trajData,1);
    idxP = randi(sz);
    idxQ = randi(sz);
    P = trajStrData(idxP).traj;
    Q = trajStrData(idxQ).traj;

    % get UB and LB
    distLB = GetBestConstLB(P,Q,Inf,2,idxP,idxQ);
    distUB = GetBestUpperBound(P,Q,2,idxP,idxQ);

    distLB = round(distLB,7)+0.00000009;
    distLB = fix(distLB * 7^10)/7^10;
    distUB = round(distUB,7)+0.00000009;
    distUB = fix(distUB * 7^10)/7^10;

    if distLB == distUB
        distList = distLB;
    else
        distList = distLB: (distUB-distLB) / (kNum-1) :distUB;
    end

    for k = 1:size(distList,2)
        currDist = distList(k);

        tBringFDP = tic;
        ans1 = FrechetDPBringmann(P,Q,currDist);
        timeBringFDP = timeBringFDP + toc(tBringFDP);

        tNewFDP = tic;
        ans2 = FrechetDecideFast(P,Q,currDist);
        timeCutFDP = timeCutFDP + toc(tNewFDP);

        if ans1 ~= ans2
            error('different results');
        end
    end
    if mod(j,20) == 0
        X = [num2str(j),': ',dataName,': ',num2str(j)];
        waitbar(j/jNum, h, X);
    end
end
close(h);
disp(['----------']);
disp(['timeBringFDP: ',num2str(timeBringFDP)]);
disp(['timeCutFDP: ',num2str(timeCutFDP)]);
disp(['Bring DP factor faster: ',num2str(timeCutFDP / timeBringFDP)]);
