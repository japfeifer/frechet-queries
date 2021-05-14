% Use a boundary cut method to answer true/false if sub-traj within traj P (large size) and traj Q (small size) 
% are at most "len" Continuous Frechet distance apart.
% The search looks for a sub-traj on curve P that is closest to Q.
%
% Inputs:
% P - vertex coordinates for curve P, rows are vertices, and columns dimensional coordinates
% Q - vertex coordinates for curve Q, rows are vertices, and columns dimensional coordinates
% len - continuous Frechet distance length to check
% sCellP - the P row to start search (for Q, start at |Q| - 1)
% sHeight - the height within cell P,Q to start search
% 
% Outputs:
% ans - if dist(P,Q) <= len then true, else false, where dist is continuous Frechet distance
% numCellCheck - number of freespace diagram cells that were checked during search
% boundCutPath - the monotone path from the right edge to left edge of the freespace diagram 

function [ans,numCellCheck,boundCutPath] = FrechetDecideSubTraj(P,Q,len,sCellP,sHeight)

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

    state = 1;
    currFromEdge = 'T';
    currCellP = sCellP;
    currCellQ = szQ - 1;
    maxCellP = szP - 1;
    currCellStartPoint = [1 sHeight];
    boundCutPath = zeros(currCellP + currCellQ -1 , 6); % prepopulate monotone path with zeros (faster)
    boundCutIdx = 1;
    prevDropFlg = 1;
    loopCnt = 0;
    maxLoop = currCellP * currCellQ * 2;
    
    while 1 == 1
        loopCnt = loopCnt + 1;
        if loopCnt > maxLoop
            error('too many loops in free-space cells');
        end
        if currCellP+1 > szP
            error('currCellP is too large');
        end
        if currCellQ+1 > szQ
            error('currCellQ is too large');
        end
        if currCellP == 0
            error('currCellP is too small');
        end
        if currCellQ == 0
            error('currCellQ is too small');
        end
        if floorIdx > 0 % check if we can pop record off floor stack
            if currCellQ == floorStack(floorIdx,1) % got back to Q column, pop record
                floorIdx = floorIdx - 1;
            end
        end
        segP = [P(currCellP,:); P(currCellP+1,:)];
        segQ = [Q(currCellQ,:); Q(currCellQ+1,:)];
        if state == 1
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
            if (currCellP == sCellP && newCellCutE(2) > sHeight) || (currCellP == maxCellP && newCellCutE(2) >= sHeight)  % we hit the ceiling (non-monotone path), return false
                return
            end
            if (currCellQ == szQ - 1 && dir == 0 && newCellCutE(1) == 1) % we hit the freespace right edge with a non-monotone path, return false
                return
            end
            if (currCellQ == 1 && newCellCutE(1) == 0 && dir == 1) % we hit the freespace left edge with a monotone path, return true
                ans = 1;
                if boundCutIdx <= size(boundCutPath,1)
                    boundCutPath(boundCutIdx:size(boundCutPath,1),:) = [];
                end
                return
            end
            currCellStartPoint = nextCellStartPoint;
            if (currCellQ == 1 && newCellCutE(1) == 0 && dir == 0) % we hit the freespace left edge with a non-monotone path, check the line-of-sight
                [dir,numCellCheck,boundCutPath,boundCutIdx,backCellP,backCellQ,backFromEdge,...
                    backCellStartPoint,backCellCutE] = LineOfSightCheck(numCellCheck,boundCutPath,...
                    boundCutIdx,currCellP,currCellQ,newCellCutE,segP,Q,len);
                if dir == 1 % we have direct line of sight, so a monotone path, return true
                    boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                    boundCutIdx = boundCutIdx + 1;
                    if boundCutIdx <= size(boundCutPath,1)
                        boundCutPath(boundCutIdx:size(boundCutPath,1),:) = [];
                    end
                    ans = 1;
                    return
                else % non-free space is blocking direct line of sight, need to backtrack and head in a non-monotone path
                    floorIdx = floorIdx + 1;
                    floorStack(floorIdx,1:3) = [currCellQ currCellP newCellCutS(2)]; % push record onto floorStack
                    currCellStartPoint = backCellStartPoint;
                    currCellP = backCellP;
                    currCellQ = backCellQ;
                    nextFromEdge = backFromEdge;
                    newCellCutE = backCellCutE;
                    if (backCellQ == szQ - 1 && backCellCutE(1) == 1) % we hit the freespace right edge with a non-monotone path, return false
                        return
                    end
                end
            end
        else % state = 2
            [newCellCutS,newCellCutE,dir,nextFromEdge,nextCellStartPoint,nextDropFlg] = GetCellCut(currCellP,currCellStartPoint,segP,segQ,len,currFromEdge,prevDropFlg,floorIdx,floorStack);
            numCellCheck = numCellCheck + 1;
            if (currCellP == sCellP && newCellCutE(2) >= sHeight) || (currCellP == maxCellP && newCellCutE(2) >= sHeight)  % we hit the ceiling, return false
                return
            end
            if (currCellQ == szQ - 1 && dir == 0 && newCellCutE(1) == 1) % we hit the freespace right edge with a non-monotone path, return false
                return
            end
            % if switch back to monotone path, or hit the freespace left edge in a non-monotone
            % path, then check if we can continue from here or need to backtrack
            if (dir == 1) || (currCellQ == 1 && newCellCutE(1) == 0)
                if (currCellQ == 1 && newCellCutE(1) == 0) && dir == 0
                    toPoint = newCellCutE;
                else
                    toPoint = newCellCutS;
                end
                [dir,numCellCheck,boundCutPath,boundCutIdx,backCellP,backCellQ,backFromEdge,...
                    backCellStartPoint,backCellCutE] = LineOfSightCheck(numCellCheck,boundCutPath,...
                    boundCutIdx,currCellP,currCellQ,toPoint,segP,Q,len);
                if dir == 1 % we have direct line of sight, can continue from here
                    state = 1;
                    boundCutPath(boundCutIdx,:) = [currCellQ currCellP newCellCutS newCellCutE];
                    boundCutIdx = boundCutIdx + 1;
                    currCellStartPoint = nextCellStartPoint;
                    if currCellQ == 1 && newCellCutE(1) == 0 % made it to the left edge of freespace diagram, a monotone path has been found
                        ans = 1; % there is a monotone path
                        if boundCutIdx <= size(boundCutPath,1)
                            boundCutPath(boundCutIdx:size(boundCutPath,1),:) = [];
                        end
                        return
                    end
                else % non-free space is blocking direct line of sight, need to backtrack and head in a non-monotone path
                    floorIdx = floorIdx + 1;
                    floorStack(floorIdx,1:3) = [currCellQ currCellP newCellCutS(2)]; % push record onto floorStack
                    currCellStartPoint = backCellStartPoint;
                    currCellP = backCellP;
                    currCellQ = backCellQ;
                    nextFromEdge = backFromEdge;
                    newCellCutE = backCellCutE;
                    if (backCellQ == szQ - 1 && newCellCutE(1) == 1) % we hit the freespace right edge with a non-monotone path, return false
                        return
                    end
                    if (currCellP == sCellP && newCellCutE(2) > sHeight) || (currCellP == maxCellP && newCellCutE(2) >= sHeight)  % we hit the ceiling, return false
                        return
                    end
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