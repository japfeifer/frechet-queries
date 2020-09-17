
function [newLB, newUB] = UpdBound(pDist,tID,LB,UB,pID,pTraj)

    global trajData
    
    tTraj = cell2mat(trajData(tID,1));
    upBnd = GetBestUpperBound(tTraj,pTraj,2,tID,pID);
    newLB = max(LB, pDist - upBnd);
    newUB = min(UB, pDist + upBnd);

end