% Use a boundary cut method to answer true/false if curve P and Q are at most "len" Continuous Frechet distance apart
% For P & Q, rows are vertices, and columns dimensional coordinates

function [ans,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,len)

    ans = 0; % default answer is "false"
    numCellCheck = 0; % number of cells checked during the free-space search
    floorStack = [];
    floorIdx = 0;

    szP = size(P,1); szQ = size(Q,1);
    if szP == 0 || szQ == 0
        error('Trajectory P and/or Q are size 0'); 
    end
    if size(P,2) ~= size(Q,2)
        error('Trajectory P and Q do not have the same dimensionality'); 
    end
    if szP == 1 % P is a single vertex, create a second vertex by copying the first vertex
        P(2,:) = P(1,:);
        szP = 2;
    end
    if szQ == 1 % Q is a single vertex, create a second vertex by copying the first vertex
        Q(2,:) = Q(1,:);
        szQ = 2;
    end
    sDist = CalcPointDist(P(1,:),Q(1,:));
    eDist = CalcPointDist(P(szP,:),Q(szQ,:));
    
    state = 1;
    currFromEdge = 'T';
    currCellP = szP - 1;
    currCellQ = szQ - 1;
    currCellStartPoint = [1 1];
    boundCutPath = zeros(currCellP + currCellQ -1 , 6);
    boundCutIdx = 1;
    prevDropFlg = 1;
    loopCnt = 0;
    maxLoop = currCellP * currCellQ * 2;
    
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
    
    if szP - 1 == 1 && szQ - 1 == 1 % each curve has just 2 vertices, hence just one cell
        ans = 1; % there is a monotone path
        return
    end
    
    while 1 == 1
        loopCnt = loopCnt + 1;
        if loopCnt > maxLoop
%             error('too many loops in free-space cells');
            disp(['Warning: too many loops in free-space cells in FrechetDecideFast']);
        end
        if floorIdx > 0 % check if we can pop record off floor stack
            if currCellQ == floorStack(floorIdx,1) % got back to Q column, pop record
                floorIdx = floorIdx - 1;
            end
        end
        if state == 1
            if currCellP == 1 && currCellQ == 1 % made it to the first cell, a monotone path has been found
                [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint,nextDropFlg] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge,prevDropFlg,floorIdx,floorStack);
                numCellCheck = numCellCheck + 1;
                boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                boundCutIdx = boundCutIdx + 1;
                ans = 1; % there is a monotone path
                return
            end
            segP = [P(currCellP,:); P(currCellP+1,:)];
            segQ = [Q(currCellQ,:); Q(currCellQ+1,:)];
            [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint,nextDropFlg] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge,prevDropFlg,floorIdx,floorStack);
            numCellCheck = numCellCheck + 1;
            if dir == 1 % heading down or to the left
                boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                boundCutIdx = boundCutIdx + 1;
            else
                % still may need to save one more bound cut 
                if newCellCutS(1) >= newCellCutE(1) && newCellCutS(2) >= newCellCutE(2)
                    boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                    boundCutIdx = boundCutIdx + 1;
                end
                state = 2;
            end
            if (currCellQ == 1 && newCellCutE(1) == 0) || (currCellP == szP - 1 && newCellCutE(2) == 1)
                return % we hit the left or top free space boundary, return false
            end
            
            currCellStartPoint = nextCellStartPoint;

        else % state = 2
            segP = [P(currCellP,:); P(currCellP+1,:)];
            segQ = [Q(currCellQ,:); Q(currCellQ+1,:)];
            [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint,nextDropFlg] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge,prevDropFlg,floorIdx,floorStack);
            numCellCheck = numCellCheck + 1;
            if (currCellQ == 1 && newCellCutE(1) == 0 && currCellP > 1) || (currCellP == szP - 1 && newCellCutE(2) == 1)
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
                    if currCellP == 1 && currCellQ == 1 % made it to the first cell, a monotone path has been found
                        ans = 1; % there is a monotone path
                        return
                    end
                else %  non-free space is blocking direct line of sight, need to backtrack and head in a non-monotone path
                    % push record onto floorStack
                    floorIdx = floorIdx + 1;
                    floorStack(floorIdx,1:3) = [currCellQ currCellP newCellCutS(2)];
                    
                    currCellStartPoint = backCellStartPoint;
                    currCellP = backCellP;
                    currCellQ = backCellQ;
                    nextFromEdge = backFromEdge;
                    newCellCutE = backCellCutE;
                    
                end
                if (currCellQ == 1 && newCellCutE(1) == 0 && currCellP > 1) || (currCellP == szP - 1 && newCellCutE(2) == 1)
                    return % we hit the left or top free space boundary, return false
                end
            else
                currCellStartPoint = nextCellStartPoint;
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
        prevDropFlg = nextDropFlg;

    end
end