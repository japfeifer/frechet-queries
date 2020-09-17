% Test distances

tic;
PSize = size(trajData,1);
numQuery = size(trajData,1);

PSize = 100;
numQuery = 100;

totTests = PSize * numQuery;
qcnt = 0;
testDist = [];
h = waitbar(0, 'Test Distances');
for i = 1:numQuery % number of different queries
    Q = cell2mat(trajData(i,1));
    for j = 1:PSize
        P = cell2mat(trajData(j,1));
        % continuous frechet
        distCont = ContFrechet(P,Q);
        distOldCont = ContFrechet(P,Q,0);
        
        % Lower Bounds
        distLB = GetBestConstLB(P,Q,Inf,2,j,i);
        resLinDP = GetBestLinearLBDP(P,Q,distCont);
        resLinDP2 = GetBestLinearLBDP(Q,P,distCont);
        
        % Upper Bounds
        distDisc = DiscreteFrechetDist(P,Q);
        distADF = ApproxDiscFrechet(P,Q);
        distADFR = ApproxDiscFrechetRev(P,Q);
        distADFD = ApproxDiscFrechetDiag(P,Q);
        distUB = GetBestUpperBound(P,Q,2,j,i);
        
        qcnt = qcnt + 1;
        testDist(end+1,:) = [distCont distOldCont distLB resLinDP resLinDP2 distDisc distADF distADFR distADFD distUB];

        if distDisc < distCont
            error('distDisc < distCont');
        end
        
        if distDisc > distADF
            error('distDisc > distADF');
        end
        
        if distDisc > distADFR
            error('distDisc > distADFR');
        end
        
        if distDisc > distADFD
            error('distDisc > distADFD');
        end
        
        if distDisc > distUB
            error('distDisc > distUB');
        end

        if distCont < distLB
            error('distCont < distLB');
        end
        
        if resLinDP == true
            error('GetBestLinearLBDP > distCont');
        end
        
        if resLinDP2 == true
            error('GetBestLinearLBDP > distCont');
        end
        
%         if distCont ~= distOldCont
%             error('Old and new Continuous Frechet don''t match');
%         end

    end
    X = ['Test Distances ',num2str(qcnt),'/',num2str(totTests)];
    waitbar(qcnt/totTests, h, X);
end

close(h);
timeElapsed = toc;