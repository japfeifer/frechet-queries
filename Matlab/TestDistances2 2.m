% Test distances
% compare continuous frechet, discrete frechet, and approx discrete frechet

tic;
PSize = size(trajData,1);
numQuery = size(trajData,1);

PSize = 100;
numQuery = 20;

totTests = PSize * numQuery;
qcnt = 0; dist1 = 0; dist2 = 0; dist3 = 0;
testDist = {[]};
h = waitbar(0, 'Test Distances');
for i = 1:numQuery % number of different queries

    Q = cell2mat(trajData(i,1));
    for j = 1:PSize
        P = cell2mat(trajData(j,1));
        dist1 = ContFrechet(P,Q,1);
        
%         LBdist = GetBestConstLB(P,Q,Inf,2,j,i);
%         UBdist = GetBestUpperBound(P,Q,2,j,i);

        qcnt = qcnt + 1;
    end
    X = ['Test Distances ',num2str(qcnt),'/',num2str(totTests)];
    waitbar(qcnt/totTests, h, X);
end

close(h);
timeElapsed = toc;