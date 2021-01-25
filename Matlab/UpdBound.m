
function [newLB, newUB] = UpdBound(pDist,tID,LB,UB,pID,pTraj)

    global trajStrData
    
    tTraj = cell2mat(trajStrData(tID).traj;
    upBnd = GetBestUpperBound(tTraj,pTraj,2,tID,pID);
    newLB = max(LB, pDist - upBnd);
    newUB = min(UB, pDist + upBnd);

end