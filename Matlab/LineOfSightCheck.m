function [dir,numCellCheck,boundCutPath,boundCutIdx,backCellP,backCellQ,backFromEdge,...
                    backCellStartPoint,backCellCutE,errFlg] = LineOfSightCheck(numCellCheck,boundCutPath,...
                    boundCutIdx,toCellP,toCellQ,toPoint,segP,Q,len)
    
    % Find point on boundCutPath to start line of sight (ray shooting) from.
    % Do a binary search - can do this since boundCutPath is monotone.
    maxIdx = boundCutIdx - 1;
    minIdx = 1;
    currIdx = maxIdx;
    loopCnt = 0;
    errFlg = 0;
    dir = 0;
    backCellP = 0;
    backCellQ = 0;
    backFromEdge = 'T';
    backCellStartPoint = [0 0];
    backCellCutE = [0 0];
    maxLoop = size(boundCutPath,1);
    while 1 == 1
       loopCnt = loopCnt + 1;
       currIdx = floor((maxIdx+minIdx)/2);
       if loopCnt > maxLoop || currIdx == 0
           errFlg = 1;
           disp(['Warning: too many loops in binary search of boundCutPath, or index is 0']);
           return
       end
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
            backCellP = 0;
            backCellQ = 0;
            backFromEdge = 'T';
            backCellStartPoint = fp;
            backCellCutE = [0 0];
            break
        end
        % shoot the ray from the right to left in this cell
        segQ = [Q(currCellQ,:); Q(currCellQ+1,:)];
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % look for opening on left side of cell
        numCellCheck = numCellCheck + 1;
        if (isempty(ep) == true && isempty(sp) == false && sp ~= fp(2)) || ...
           (isempty(sp) == false && fp(2) < sp) || ...
           (isempty(ep) == false && fp(2) > ep) || ...
           (isempty(ep) == true && isempty(sp) == true) % the ray encountered some non-free space on left side of cell
            if isempty(sp) == false && fp(2) < sp % can exit left side but non-monotone
                dir = 0;
                backCellP = toCellP;
                backCellQ = currCellQ;
                backFromEdge = 'R';
                backCellStartPoint = [1 sp];
                backCellCutE = [0 sp];
                if fromCellQ == currCellQ % at first cell to shoot ray from, update path
                    boundCutPath(boundCutIdx,:) = [currCellQ toCellP spFirst 0 toPoint(2)];
                    boundCutIdx = boundCutIdx + 1;
                end
                break;
            end
            [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % look for opening on top side of cell
            if isempty(sp) == false
                dir = 0;
                backCellP = toCellP;
                backCellQ = currCellQ;
                backFromEdge = 'B';
                backCellStartPoint = [sp 0];
                backCellCutE = [sp 1];
                if fromCellQ == currCellQ % at first cell to shoot ray from, update path
                    boundCutPath(boundCutIdx,:) = [currCellQ toCellP spFirst 0 toPoint(2)];
                    boundCutIdx = boundCutIdx + 1;
                end
                break
            end
            
            [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
            if isempty(sp) == false
                if (isempty(ep) == true)
                    backCellCutE = [1 sp];
                    backCellStartPoint = [0 sp];
                else
                    backCellCutE = [1 ep];
                    backCellStartPoint = [0 ep];
                end
                dir = 0;
                backCellP = toCellP;
                backCellQ = currCellQ;
                backFromEdge = 'L';
                break
            end

        end
        % the ray encountered only free space in this cell
        if fromCellQ == currCellQ % start point of cut in cell may be diff than [ep toPoint(2)]
            boundCutPath(boundCutIdx,:) = [currCellQ toCellP spFirst 0 toPoint(2)];
        else
            boundCutPath(boundCutIdx,:) = [currCellQ toCellP 1 toPoint(2) 0 toPoint(2)];
        end
        boundCutIdx = boundCutIdx + 1;
        fp = [1 toPoint(2)];
        tp = [0 toPoint(2)];
        currCellQ = currCellQ - 1;
    end
    
end