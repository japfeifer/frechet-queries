% compute the sub-traj continuous Frechet distance up to a decimal precision 
% uses the quadratic algo from Alt and Godau

function [frechetDist,cnt] = SubContFrechetAlt(P,Q,decPrec)

    global decimalPrecision
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
    end
    
    % get upper/lower bounds
    cnt = 0;
    minBnd = 0;
    maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd);
    P = LinearSimp(P,0);
    Q = LinearSimp(Q,0);
    while maxBnd - minBnd > decPrec
        currLen = (minBnd + maxBnd) / 2;
        cnt = cnt + 1;
        if FrechetDecide(P,Q,currLen,0,0,0,0,1) == 1
            maxBnd = currLen;
        else
            minBnd = currLen;
        end
    end
    frechetDist = (minBnd + maxBnd) / 2;

end
