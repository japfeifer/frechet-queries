% Test distances

tic;
sSize = size(trajStrData,2);
numQuery = 5000;
resList = zeros(1,numQuery);
rng('default'); % reset the random seed so that experiments are reproducable
h = waitbar(0, 'Test Distances');
for i = 1:numQuery 
    P = trajStrData(randi([1 sSize])).traj;
    Q = trajStrData(randi([1 sSize])).traj;

    % continuous frechet
    distCont = ContFrechet(P,Q);

    resLBTest1 = LBTest(P,Q,distCont - 0.000000001);
    resLBTest2 = LBTest(Q,P,distCont - 0.000000001);

    if resLBTest1 == true || resLBTest2 == true
        testDist(i) = 1;
    end
    
    if mod(i,100) == 0
        X = ['Test Distances ',num2str(i),'/',num2str(numQuery)];
        waitbar(i/numQuery, h, X);
    end
end

pctLB = sum(testDist) / size(testDist,2);
disp(['Percent the LB matches Frechet DP: ',num2str(pctLB)]);

close(h);
timeElapsed = toc;