% Use a boundary cut method to answer true/false if curve P and Q are at most "len" Continuous Frechet distance apart

function [ans,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,len)

    ans = 0; % default answer is "false"
    numCellCheck = 0; % number of cells checked during the free-space search
    
    szP = size(P,1); szQ = size(Q,1);
    sDist = CalcPointDist(P(1,:),Q(1,:));
    eDist = CalcPointDist(P(szP,:),Q(szQ,:));
    
    if  sDist > len || eDist > len % P & Q start/end vertices are too far apart
        return
    end
    
    % see if start cell has an opening
    numCellCheck = numCellCheck + 1;
    [sp,ep] = SegmentBallIntersect(P(1,:),P(2,:),Q(2,:),len,1);
    if isempty(sp) == true && isempty(ep) == true
        [sp,ep] = SegmentBallIntersect(Q(1,:),Q(2,:),P(2,:),len,1);
        if isempty(sp) == true && isempty(ep) == true
            return % no opening in start cell
        end
    end
    
    state = 1;
    currFromEdge = 'T';
    currCellP = szP - 1;
    currCellQ = szQ - 1;
    currCellStartPoint = [1 1];
    boundCutPath = zeros(currCellP + currCellQ -1 , 6);
    boundCutIdx = 1;
    loopCnt = 0;
    maxLoop = currCellP * currCellQ * 2;
    
    while 1 == 1
        loopCnt = loopCnt + 1;
        if loopCnt > maxLoop
            error('too many loops in free-space cells');
        end
        if state == 1
            if currCellP == 1 && currCellQ == 1 % made it to the first cell, a monotone path has been found
                [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge);
                numCellCheck = numCellCheck + 1;
                boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                boundCutIdx = boundCutIdx + 1;
                ans = 1; % there is a monotone path
                return
            end
            segP = [P(currCellP,:); P(currCellP+1,:)];
            segQ = [Q(currCellQ,:); Q(currCellQ+1,:)];
            [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge);
            numCellCheck = numCellCheck + 1;
            if dir == 1 % heading down or to the left
                boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                boundCutIdx = boundCutIdx + 1;
            else
                state = 2;
            end
            if (currCellQ == 1 && newCellCutE(1) == 0) || (currCellP == szP - 1 && newCellCutE(2) == 1)
                return % we hit the left or top free space boundary, return false
            end
            
            currCellStartPoint = nextCellStartPoint;

        else % state = 2
            segP = [P(currCellP,:); P(currCellP+1,:)];
            segQ = [Q(currCellQ,:); Q(currCellQ+1,:)];
            [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge);
            numCellCheck = numCellCheck + 1;
            if (currCellQ == 1 && newCellCutE(1) == 0) || (currCellP == szP - 1 && newCellCutE(2) == 1)
                return % we hit the left or top free space boundary, return false
            end
            
            if dir == 1 % switching back to monotone path, check if we can continue from here or need to backtrack
              
                [dir,numCellCheck,boundCutPath,boundCutIdx,backCellP,backCellQ,backFromEdge,...
                    backCellStartPoint,backCellCutE] = LineOfSightCheck(numCellCheck,boundCutPath,...
                    boundCutIdx,currCellP,currCellQ,newCellCutS,segP,Q,len);

                if dir == 1 % we have direct line of sight, can continue from here
                    state = 1;
                    boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                    boundCutIdx = boundCutIdx + 1;
                    currCellStartPoint = nextCellStartPoint;
                else %  non-free space is blocking direct line of sight, need to backtrack and head in a non-monotone path
                    currCellStartPoint = backCellStartPoint;
                    currCellP = backCellP;
                    currCellQ = backCellQ;
                    nextFromEdge = backFromEdge;
                    newCellCutE = backCellCutE;
                end
                if (currCellQ == 1 && newCellCutE(1) == 0) || (currCellP == szP - 1 && newCellCutE(2) == 1)
                    return % we hit the left or top free space boundary, return false
                end
            end
        end
        
        if nextFromEdge == 'B'
            currCellP = currCellP + 1;
        elseif nextFromEdge == 'T'
            currCellP = currCellP - 1;
        elseif nextFromEdge == 'L'
            currCellQ = currCellQ + 1;
        else % nextFromEdge == 'R'
            currCellQ = currCellQ - 1;
        end
                
        currFromEdge = nextFromEdge;

    end
end