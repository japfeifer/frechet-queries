% compute the continuous Frechet distance up to a decimal precision 

function [frechetDist,totCell] = ContFrechetPrecision(P,Q,decPrec,runBringmann)

    global decimalPrecision globalBringmann
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
        runBringmann = 1;
    end
    
    totCell = 0;
    
    if size(P,2) == 2 && runBringmann == 1 && globalBringmann == 1 % use Bringmann code for 2D traj
        frechetDist = FrechetDistBringmann(P,Q);
    else
        % get upper/lower bounds
        minBnd = GetBestConstLB(P,Q,Inf,0,0,0,1);
        maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd);
        totCell = totCell + (size(P,1) + size(Q,1))*5;
        if minBnd == maxBnd % we are done, this is the Continuous Frechet dist
            frechetDist = maxBnd;
            return
        end
        P = LinearSimp(P,0);
        Q = LinearSimp(Q,0);
        while maxBnd - minBnd > decPrec
            currLen = (minBnd + maxBnd) / 2;
            [ans,numCell] = FrechetDecide(P,Q,currLen,0,0,1);
            totCell = totCell + numCell;
            if ans == 1
                maxBnd = currLen;
            else
                minBnd = currLen;
            end
        end
        frechetDist = (minBnd + maxBnd) / 2;
    end

end
