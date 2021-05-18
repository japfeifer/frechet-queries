% compute the sub-traj continuous Frechet distance up to a decimal precision 
% uses our boundary cut method
% find answer that is vertex-aligned

function [frechetDist,totCellCheck,newz,newzRev] = SubContFrechetFastVA(P,Q,decPrec)

    global decimalPrecision
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
    end
    
    totCellCheck = 0;
    newz = [];
    newzRev = [];
    
    % get upper/lower bounds
    minBnd = 0;
    maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd);
    P = LinearSimp(P,0);
    Q = LinearSimp(Q,0);
    while maxBnd - minBnd > decPrec
        currLen = (minBnd + maxBnd) / 2;
        spList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
        answ = 0;
        for j = 1:size(spList,1)
            [answ,numCellCheck,z,zRev] = SubContFrechetFastVACheck(P,Q,currLen,spList(j,1),spList(j,2));
            totCellCheck = totCellCheck + numCellCheck;
            if answ == 1
                newz = z;
                newzRev = zRev;
                break
            end
        end
        if answ == 1
            maxBnd = currLen;
        else
            minBnd = currLen;
        end
    end
    frechetDist = (minBnd + maxBnd) / 2;
    if isempty(newz) == true
        newz = z;
        newzRev = z;
    end

end
