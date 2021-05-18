% compute the sub-traj continuous Frechet distance up to a decimal precision 
% uses the quadratic algo from Alt and Godau
% find answer that is vertex-aligned

function [frechetDist,cnt] = SubContFrechetAltVA(P,Q,decPrec)

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
    revP = fliplr(P')';
    revQ = fliplr(Q')';
    while maxBnd - minBnd > decPrec
        currLen = (minBnd + maxBnd) / 2;
        cnt = cnt + 1;
        [ans,numCell,z] = FrechetDecide(P,Q,currLen,0,0,0,0,1);
        if ans == 1
            ans = CheckVertexAlt(z); % check if z has vertex
            if ans == 1 % now check reversed P and Q
                cnt = cnt + 1;
                [ans,numCell,z] = FrechetDecide(revP,revQ,currLen,0,0,0,0,1);
                if ans == 1
                    ans = CheckVertexAlt(z); % check if z has vertex
                end
            end
        end
        if ans == 1
            maxBnd = currLen;
        else
            minBnd = currLen;
        end
    end
    frechetDist = (minBnd + maxBnd) / 2;

end
