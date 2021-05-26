% compute the sub-traj continuous Frechet distance up to a decimal precision 
% uses our boundary cut method
% find answer that is vertex-aligned

function [frechetDist,totCellCheck,newz,newzRev] = SubContFrechetFastVA(P,Q,decPrec,alpha,maxLoop)

    global decimalPrecision
    
    switch nargin
    case 2
        decPrec = decimalPrecision;
        alpha = Inf;
        maxLoop = Inf;
    case 3
        alpha = Inf;
        maxLoop = Inf;
    case 4
        maxLoop = Inf;
    end
    
    totCellCheck = 0;
    loopCnt = 0;
    z = [];
    newz = [];
    newzRev = [];
    minBnd = 0;
    ansEqOneFlg = 0;
    
    % if alpha < Inf then check FDP on alpha, if false then stop
    if alpha < Inf
        currLen = alpha;
        spList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
        totCellCheck = totCellCheck + size(P,1);
        answ = 0;
        for j = 1:size(spList,1)
            [answ,numCellCheck,z,zRev] = SubContFrechetFastVACheck(P,Q,currLen,spList(j,1),spList(j,2));
            totCellCheck = totCellCheck + numCellCheck;
            if answ == 1
                newz = z;
                newzRev = zRev;
                ansEqOneFlg = 1;
                break
            end
        end
        if answ == 0
            frechetDist = Inf;
            newz = [];
            newzRev = [];
            return 
        else
            maxBnd = min(GetBestUpperBound(P,Q,0,0,0,minBnd),alpha);
            totCellCheck = totCellCheck + (size(P,1) * 4);
        end
    else
        maxBnd = GetBestUpperBound(P,Q,0,0,0,minBnd);
        totCellCheck = totCellCheck + (size(P,1) * 4);
    end

    % do sub-traj CFD
    while maxBnd - minBnd > decPrec
        if alpha < minBnd
            frechetDist = Inf;
            newz = [];
            newzRev = [];
            return 
        end
        currLen = (minBnd + maxBnd) / 2;
        spList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
        totCellCheck = totCellCheck + size(P,1);
        answ = 0;
        for j = 1:size(spList,1)
            [answ,numCellCheck,z,zRev] = SubContFrechetFastVACheck(P,Q,currLen,spList(j,1),spList(j,2));
            totCellCheck = totCellCheck + numCellCheck;
            if answ == 1
                newz = z;
                newzRev = zRev;
                ansEqOneFlg = 1;
                break
            end
        end
        if answ == 1
            maxBnd = currLen;
        else
            minBnd = currLen;
        end

        loopCnt = loopCnt + 1;
        if loopCnt >= maxLoop && ansEqOneFlg == 1 % we can stop searching here
            break
        end
        
    end
    frechetDist = (minBnd + maxBnd) / 2;
    if isempty(newz) == true
        newz = z;
        newzRev = z;
    end

end
