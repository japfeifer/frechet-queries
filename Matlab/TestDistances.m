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
%     Q = cell2mat(trajData(randi(PSize),1));
    Q = cell2mat(trajData(i,1));
    for j = 1:PSize
        P = cell2mat(trajData(j,1));
        dist1 = ContFrechet(P,Q);
        dist2 = DiscreteFrechetDist(P,Q);
        dist2Pad = DiscreteFrechetDist(PadTraj(P,2),PadTraj(Q,2));
        dist3 = ApproxDiscFrechet(P,Q);
        dist3Pad = ApproxDiscFrechet(PadTraj(P,2),PadTraj(Q,2));
        dist4 = ContFrechet(P,Q,0);
        NFResult = NegFilterDP(P,Q,dist1);
        NFResult2 = NegFilterDP(Q,P,dist1);
        LBdist = GetBestLowerBound(P,Q,Inf,2,j,i);
        UBdist = GetBestUpperBound(P,Q,2,j,i);
        NFResult3 = NegFilterDP(P,Q,LBdist);
        NFResult4 = NegFilterDP(Q,P,LBdist);
        NFResult5 = NegFilterDP(PadTraj(P,2),PadTraj(Q,2),LBdist);
        NFResult6 = NegFilterDP(PadTraj(Q,2),PadTraj(P,2),LBdist);
        
        qcnt = qcnt + 1;
        testDist(qcnt,1) = mat2cell(dist1,size(dist1,1),size(dist1,2));
        testDist(qcnt,2) = mat2cell(dist2,size(dist2,1),size(dist2,2));
        testDist(qcnt,3) = mat2cell(dist3,size(dist3,1),size(dist3,2));
        testDist(qcnt,4) = mat2cell(dist4,size(dist4,1),size(dist4,2));

        if UBdist < LBdist
            error('LB UBdist < LBdist');
        end

        if dist1 < LBdist
            error('LB dist > Continuous Frechet');
        end
        
        if NFResult == true
            error('Neg Filter > Continuous Frechet');
        end
        
        if NFResult2 == true
            error('Neg Filter2 > Continuous Frechet');
        end
        
        if dist2 < dist1
            error('Discrete Frechet < Continuous Frechet');
        end
        
        if dist3 < dist2
            error('Approx Discrete Frechet < Discrete Frechet');
        end
        
        if dist3Pad < dist2Pad
            error('Approx Discrete Frechet with padding < Discrete Frechet with padding');
        end
        
        if dist1 ~= dist4
            error('Old and new Continuous Frechet don''t match');
        end
        
        if NFResult3 == true && NFResult5 ~= true
            error('Neg Filter no pad is better than Neg Filter with pad');
        end
        
        if NFResult4 == true && NFResult6 ~= true
            error('Neg Filter no pad is better than Neg Filter with pad');
        end
        
    end
    X = ['Test Distances ',num2str(qcnt),'/',num2str(totTests)];
    waitbar(qcnt/totTests, h, X);
end

close(h);
timeElapsed = toc;