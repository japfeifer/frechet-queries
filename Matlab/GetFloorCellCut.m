function [currCellCutE,dir,nextEdge,nextSP] = GetFloorCellCut(currCellP,currSP,segP,segQ,len,startEdge,prevDropFlg,floorIdx,floorStack)

    currCellCutS = currSP;
    floorYPos = floorStack(floorIdx,3);
    
    [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
    if isempty(sp) == false % there is some free space on left edge
        if sp >= floorYPos % sp is above the floor
            currCellCutE = [0 sp];
            nextSP = [1 sp];
            nextEdge = 'R';
            if currCellCutS(2) >= currCellCutE(2)
                dir = 1;
            else
                dir = 0;
            end
            return
        elseif isempty(ep) == false && ep >= floorYPos % ep is above the floor (and sp is beneath the floor)
            currCellCutE = [0 floorYPos];
            nextSP = [1 floorYPos];
            nextEdge = 'R';
            if currCellCutS(2) >= currCellCutE(2)
                dir = 1;
            else
                dir = 0;
            end
            return
        end
    end 
    
    [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
    if isempty(sp) == false % there is some free space on top edge
        
        
    end

    error('Unknown cell cut scenario in GetFloorCellCut');

end