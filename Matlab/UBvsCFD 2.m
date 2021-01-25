rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
jNum = 1000;
timeUB = 0;
timeCFD = 0;
resList(jNum,1:2) = 0;
h = waitbar(0, 'UB vs CFD');
    
for j = 1:jNum
    % get a P and Q curve
    sz = size(trajStrData,2);
    idxP = randi(sz);
    idxQ = randi(sz);
    P = trajStrData(idxP).traj;
    Q = trajStrData(idxQ).traj;

    % get Approx Discrete Frechet UB
    tUB = tic;
    distUB = ApproxDiscFrechet(P,Q);
    timeUB = toc(tUB);

    % get CFD
    tCFD = tic;
    distFrechet = FrechetDistBringmann(P,Q);
    timeCFD = toc(tCFD);
    
    resList(j,1:2) = [timeUB timeCFD];

    if mod(j,100) == 0
        X = ['Dataset ',dataName,': ',num2str(j)];
        waitbar(j/jNum, h, X);
    end
end

close(h);
timeUBMean = mean(resList(:,1)) * 1000;
timeUBStd = std(resList(:,1)) * 1000;
timeCFDMean = mean(resList(:,2)) * 1000;
timeCFDStd = std(resList(:,2)) * 1000;
disp(['timeUBMean: ',num2str(timeUBMean),'   timeUBStd: ',num2str(timeUBStd),...
      '   timeCFDMean: ',num2str(timeCFDMean),'   timeCFDStd: ',num2str(timeCFDStd),...
      '   Factor UB Faster (mean): ',num2str(timeCFDMean/timeUBMean)]);

