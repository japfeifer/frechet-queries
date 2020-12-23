function [dir,numCellCheck,boundCutPath,boundCutIdx,backCellP,backCellQ,backFromEdge,...
                    backCellStartPoint,backCellCutE] = LineOfSightCheck(numCellCheck,boundCutPath,...
                    boundCutIdx,toCellP,toCellQ,toPoint,segP,Q,len)
    
    % Find point on boundCutPath to start line of sight (ray shooting) from.
    % Do a binary search - can do this since boundCutPath is monotone.
    maxIdx = boundCutIdx - 1;
    minIdx = 1;
    loopCnt = 0;
    maxLoop = size(boundCutPath,1);
    while 1 == 1
       loopCnt = loopCnt + 1;
       if loopCnt > maxLoop
           error('too many loops in binary search of boundCutPath');
       end
       currIdx = floor((maxIdx+minIdx)/2);
       boundPathP = boundCutPath(currIdx,2);
       if boundPathP > toCellP
           minIdx = currIdx + 1;
       elseif boundPathP < toCellP
           maxIdx = currIdx - 1;
       else % we are on the correct row in the free-space diagram
           spFirst = boundCutPath(currIdx,3:4);
           epFirst = boundCutPath(currIdx,5:6);
           if spFirst(2) < toPoint(2)
               maxIdx = currIdx - 1;
           elseif epFirst(2) > toPoint(2)
               minIdx = currIdx + 1;
           elseif spFirst(2) == toPoint(2) && epFirst(2) == toPoint(2)
               minIdx = currIdx + 1;
           else % found the correct index
               break
           end
       end
    end
    
    % compute the fromPoint
    xCoordFromPoint = GetSegPoint(spFirst,epFirst,toPoint(2),2);
    if isnan(xCoordFromPoint) == true
        error('xCoordFromPoint is NaN');
    end
    
    % delete rows in boundCutPath that are no longer part of monotone path
    currCellQ = boundCutPath(currIdx,1);
    fromCellQ = currCellQ;
    boundCutPath(currIdx:boundCutIdx-1 , 1:6) = 0;
    boundCutIdx = currIdx;
    
    % shoot ray from fromPoint to toPoint, and stop if hit non-free space
    fp = [xCoordFromPoint toPoint(2)]; % iteration from point
    tp = [0 toPoint(2)]; % iteration to point
    loopCnt = 0;
    maxLoop = fromCellQ - toCellQ + 1;
    while 1 == 1 % keep on checking cells until hit toPoint, or non-free space
        loopCnt = loopCnt + 1;
        if loopCnt > maxLoop
           error('too many loops in ray shooting');
        end
        if currCellQ == toCellQ % we made it back to toPoint
            dir = 1;
            % just set variables below to any values (they are not used if we make it back to toPoint)
            backCellP = [0 0];
            backCellQ = [0 0];
            backFromEdge = 'T';
            backCellStartPoint = [0 0];
            backCellCutE = [0 0];
            break
        end
        % shoot the ray from the right to left in this cell
        segQ = [fp; Q(currCellQ+1,:)];
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); 
        numCellCheck = numCellCheck + 1;
        if sp > 0 % we have hit a non-free space cell
            % get next cell cut, push from bottom (it will be a non-monotone direction)
            [newCellCutS,backCellCutE,dir,backFromEdge,backCellStartPoint] = GetCellCut(toCellP,fp,segP,segQ,len,'B');
            numCellCheck = numCellCheck + 1;
            backCellP = toCellP;
            backCellQ = currCellQ;
            break
        end
        % the ray encountered only free space in this cell
        if fromCellQ == currCellQ % start point of cut in cell may be diff than [ep toPoint(2)]
            boundCutPath(boundCutIdx,:) = [currCellQ toCellP spFirst sp toPoint(2)];
        else
            boundCutPath(boundCutIdx,:) = [currCellQ toCellP ep toPoint(2) sp toPoint(2)];
        end
        boundCutIdx = boundCutIdx + 1;
        fp = [1 toPoint(2)];
        tp = [0 toPoint(2)];
        currCellQ = currCellQ - 1;
    end
    
end