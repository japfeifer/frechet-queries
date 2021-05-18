% compute the sub-traj continuous Frechet distance up to a decimal precision 
% uses our boundary cut method

function [frechetDist] = SubContFrechetFast(P,Q,decPrec)

    global decimalPrecision
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
    end
    
    % get upper/lower bounds
    minBnd = 0;
    maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd);
    P = LinearSimp(P,0);
    Q = LinearSimp(Q,0);
    while maxBnd - minBnd > decPrec
        currLen = (minBnd + maxBnd) / 2;
        startPtsVertList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
        ans = 0;
        for j = 1:size(startPtsVertList,1)
            if FrechetDecideSubTraj(P,Q,currLen,startPtsVertList(j,1),startPtsVertList(j,2)) == 1
                ans = 1;
                break
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
