% use a boundary cut method to answer if curve P and Q are at most len Continuous Frechet distance apart

function [ans] = FrechetDecideFast(P,Q,len)

    ans = 0;
    
    szP = size(P,1); szQ = size(Q,1);
    sDist = CalcPointDist(P(1,:),Q(1,:));
    eDist = CalcPointDist(P(szP,:),Q(szQ,:));
    
    if eDist < len || sDist < len % P & Q start/end vertices are too far apart
        return
    end
    
    % see if start cell has an opening
    [s1,s2] = SegmentBallIntersect(P(1,:),P(2,:),Q(2,:),len);
    if isempty(s1) == true && isempty(s2) == true
        [s1,s2] = SegmentBallIntersect(Q(1,:),Q(2,:),P(2,:),len);
        if isempty(s1) == true && isempty(s2) == true
            return % no opening in start cell
        end
    end
    
    state = 1;
    currCellP = [szP - 1];
    currCellQ = [szQ - 1];
    prevCellCutS = [1 1];
    prevCellCutE = [1 1];
    boundCutPath = [];
    
    while 1 == 1
        alreadyGotNextCellFlg = 0;
        if state == 1
            if currCellP == 1 && currCellQ == 1 % made it to the first cell, there is opening, we are done
                ans = 1; % there is a monotone path
                return
            end
            [currCellCutS,currCellCutE,dir]  = GetCellCut(state,currCellP,currCellQ,prevCellCutE);
            if dir == 1 % heading down or to the left
                boundCutPath(end+1,:) = [currCellP currCellQ currCellCutS currCellCutE];
            else
                state = 2;
            end
            if (currCellQ == 1 && currCellCutE == 0) || (currCellP == szP - 1 && currCellCutE == 1)
                return % we hit the left or top free space boundary
            end
            
            prevCellCutE = currCellCutE;

        else % state = 2
            [currCellCutS,currCellCutE,dir]  = GetCellCut(state,currCellP,currCellQ,prevCellCutE);
            
            if (currCellQ == 1 && currCellCutE == 0) || (currCellP == szP - 1 && currCellCutE == 1)
                return % we hit the left or top free space boundary
            end
            
            if dir == 1 % heading down or to the left
                
                [sightRes,blockedPoint,newBoundCutPath,currCellP,currCellQ] = LineOfSightCheck();
                
                if sightRes == 1
                    state = 1;
                    boundCutPath = newBoundCutPath; % update boundary cut path with new horizontal path
                    prevCellCutE = currCellCutE;
                    
                else
                    prevCellCutE = blockedPoint;
                    alreadyGotNextCellFlg = 1;
                end
            end
        end
        
        % get cell for next iteration
        if alreadyGotNextCellFlg == 0
            if state == 1
                if currCellCutE(1,1) == 0 && currCellCutE(1,2) == 0 % go diagonal (left and down)
                    currCellP = currCellP - 1;
                    currCellQ = currCellQ - 1;
                elseif currCellCutE(1,1) == 0 % go left
                    currCellQ = currCellQ - 1;
                else % go down
                    currCellP = currCellP - 1;
                end
            else % state = 2
                if currCellCutE(1,1) == 1 && currCellCutE(1,2) == 0 % go diagonal (left and up)
                    currCellP = currCellP + 1;
                    currCellQ = currCellQ - 1;
                elseif currCellCutE(1,1) == 0 && currCellCutE(1,2) == 1 % go diagonal (right and down)
                    currCellP = currCellP - 1;
                    currCellQ = currCellQ + 1;
                elseif currCellCutE(1,1) == 1 && currCellCutE(1,2) == 1 % go diagonal (right and up)
                    currCellP = currCellP + 1;
                    currCellQ = currCellQ + 1;
                elseif currCellCutE(1,1) == 1 % go up
                    currCellP = currCellP + 1;
                else % go right
                    currCellQ = currCellQ + 1;
                end
            end
        end
    end
end