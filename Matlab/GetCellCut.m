% Check a free space diagram cell and generate a cell boundary cut
%
% Input:
% currCellP: P row in free-space diagram
% currSP: start point for cut in the cell
% segP, segQ: line segments for P and Q
% len: distance to check (radius of ball)
% startEdge: start edge for currSP, T top, B bottom, L left, R right
%
% Output:
% currCellCutS, currCellCutE: start and end points for cell cut edge
% dir: 1 = monotone path, 0 = non-monotone path
% nextEdge: next edge to check, T top, B bottom, L left, R right
% nextSP: next cell start point

function [currCellCutS,currCellCutE,dir,nextEdge,nextSP,nextDropFlg] = GetCellCut(currCellP,currSP,segP,segQ,len,startEdge,prevDropFlg,floorIdx,floorStack)

    currCellCutS = currSP;
    nextDropFlg = 1;
    
    if startEdge == 'T' % top edge
        
       if prevDropFlg == 0 % we are not allowed to fall in this state
           % check if there is free-space on right edge - cell type F
           [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
           if isempty(sp) == false
               if (isempty(ep) == true)
                   currCellCutE = [1 sp];
                   nextSP = [0 sp];
               else
                   currCellCutE = [1 ep];
                   nextSP = [0 ep];
               end
               dir = 0;
               nextEdge = 'L';
               return
           else % see if we can reach bottom edge free space to right of currSP - cell Type E
               [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(1,:),len,1); % get bottom edge free space
               if (isempty(sp) == false && isempty(ep) == true && sp > currSP(1)) || ...
                  (isempty(sp) == false && isempty(ep) == false && ep >= currSP(1) && ep < 1)
                   if isempty(ep) == true
                       currCellCutE = [sp 0];
                       nextSP = [sp 1];
                   else
                       currCellCutE = [ep 0];
                       nextSP = [ep 1];
                   end
                   nextEdge = 'T';
                   dir = 0;
                   nextDropFlg = 0; % For type E
                   return
               end
           end   
       end
        
        % check if we can "fall" down to bottom edge
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(1,:),len,1); % get bottom edge free space
        if (isempty(sp) == false && isempty(ep) == true && sp == currSP(1)) || ...
           (isempty(sp) == false && isempty(ep) == false && sp <= currSP(1) && ep >= currSP(1))

           if prevDropFlg == 1 % we are allowed to fall in this state - cell type A

               currCellCutE = [currSP(1) 0];
               nextSP = [currSP(1) 1];
               dir = 1;
               if currCellP == 1 % at bottom row in free-space diagram
                   if sp == 0 % we can reach bottom left edge
                       currCellCutE = [0 0];
                       nextSP = [1 0];
                       nextEdge = 'R';
                       dir = 1;
                   else % part of left side of cell is blocked, we must go up
                       [garbage,currCellCutE,dir,nextEdge,nextSP,nextDropFlg] = GetCellCut(currCellP,[sp 0],segP,segQ,len,'B',prevDropFlg,floorIdx,floorStack);
                       % seems to be a bug by with code below...
                       % Instead, just use values from above call to GetCellCut
%                        if currCellCutE(2) <= currCellCutS(2) && currCellCutE(2) ~= 1 % still have monotone path
%                            dir = 1;
%                            nextEdge = 'R'; 
%                            nextSP = [1 currCellCutE(2)];
%                        end
                       if nextEdge == 'R' % still have a monotone path since we were "falling"
                           dir = 1;
                           nextSP = [1 currCellCutE(2)];
                       end
                   end
               else
                   nextEdge = 'T';
               end
               % check if we went beneath floor
               if floorIdx > 0 && currCellP == floorStack(floorIdx,2) && floorStack(floorIdx,3) > currCellCutE(2)
                   % we went beneath floor, get new cell cut and do not go beneath floor
                   [currCellCutE,dir,nextEdge,nextSP] = GetFloorCellCut(currSP,segP,segQ,len,floorIdx,floorStack);
               end
               return
           end
        end

        % check if there is free-space on bottom edge that is further left of currSP - cell type B
        % already got bottom edge free-space info so do not have to get it again
        if (isempty(sp) == false && isempty(ep) == true && sp <= currSP(1)) || ...
           (isempty(sp) == false && isempty(ep) == false && ep < currSP(1))
           if isempty(ep) == true 
               currCellCutE = [sp 0];
               nextSP = [sp 1];
           else
               currCellCutE = [ep 0];
               nextSP = [ep 1];
           end
           dir = 1;
           if currCellP == 1 % at bottom row in free-space diagram
               if sp == 0 % we can reach bottom left edge
                   currCellCutE = [0 0];
                   nextSP = [1 0];
                   nextEdge = 'R';
                   dir = 1;
               else % part of left side of cell is blocked, we must go up
                   [garbage,currCellCutE,dir,nextEdge,nextSP,nextDropFlg] = GetCellCut(currCellP,[sp 0],segP,segQ,len,'B',prevDropFlg,floorIdx,floorStack);
                   if currCellCutE(2) <= currCellCutS(2) && currCellCutE(2) ~= 1 % still have monotone path
                       dir = 1;
                       nextEdge = 'R';
                       nextSP = [1 currCellCutE(2)];
                   end
               end
           else
               nextEdge = 'T';
           end
           % check if we went beneath floor
           if floorIdx > 0 && currCellP == floorStack(floorIdx,2) && floorStack(floorIdx,3) > currCellCutE(2)
               % we went beneath floor, get new cell cut and do not go beneath floor
               [currCellCutE,dir,nextEdge,nextSP] = GetFloorCellCut(currSP,segP,segQ,len,floorIdx,floorStack);
           end
           return
        end

        % check if there is free-space on left edge - cell type C
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false
            currCellCutE = [0 sp];
            nextSP = [1 sp];
            dir = 1;
            nextEdge = 'R';
            % check if we went beneath floor
            if floorIdx > 0 && currCellP == floorStack(floorIdx,2) && floorStack(floorIdx,3) > currCellCutE(2)
               % we went beneath floor, get new cell cut and do not go beneath floor
               [currCellCutE,dir,nextEdge,nextSP] = GetFloorCellCut(currSP,segP,segQ,len,floorIdx,floorStack);
            end
            return
        end

        % check if there is free-space on top edge - cell type D
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end

        % check if there is free-space on right edge - cell type K
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
        if isempty(sp) == false
           if (isempty(ep) == true)
               currCellCutE = [1 sp];
               nextSP = [0 sp];
           else
               currCellCutE = [1 ep];
               nextSP = [0 ep];
           end
           dir = 0;
           nextEdge = 'L';
           return
        end
        
        error('Unknown cell cut scenario for startEdge = T');
        
    elseif startEdge == 'R' % right edge
        
        % check if there is free-space on bottom edge - cell type G
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(1,:),len,1); % get bottom edge free space
        if isempty(sp) == false
           if currCellP > 1 % not at bottom row in free-space diagram
               if isempty(ep) == true 
                   currCellCutE = [sp 0];
                   nextSP = [sp 1];
               else
                   currCellCutE = [ep 0];
                   nextSP = [ep 1];
               end
               dir = 1;
               nextEdge = 'T';
           else % at bottom row in free-space diagram
               if sp == 0 % we can reach bottom left edge
                   currCellCutE = [0 0];
                   nextSP = [1 0];
                   nextEdge = 'R';
                   dir = 1;
               else % part of left side of cell is blocked, we must go up
                   [garbage,currCellCutE,dir,nextEdge,nextSP,nextDropFlg] = GetCellCut(currCellP,[sp 0],segP,segQ,len,'B',prevDropFlg,floorIdx,floorStack);
                   if currCellCutE(2) <= currCellCutS(2) && currCellCutE(2) ~= 1 % still have monotone path
                       dir = 1;
                       nextEdge = 'R';
                       nextSP = [1 currCellCutE(2)];
                   end
               end
           end
           % check if we went beneath floor
           if floorIdx > 0 && currCellP == floorStack(floorIdx,2) && floorStack(floorIdx,3) > currCellCutE(2)
               % we went beneath floor, get new cell cut and do not go beneath floor
               [currCellCutE,dir,nextEdge,nextSP] = GetFloorCellCut(currSP,segP,segQ,len,floorIdx,floorStack);
           end
           return
        end
        
        % check if there is free-space on left edge that is same or below currSP  - cell type H
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false && sp <= currSP(2)
           currCellCutE = [0 sp];
           nextSP = [1 sp];
           dir = 1;
           nextEdge = 'R';
           % check if we went beneath floor
           if floorIdx > 0 && currCellP == floorStack(floorIdx,2) && floorStack(floorIdx,3) > currCellCutE(2)
               % we went beneath floor, get new cell cut and do not go beneath floor
               [currCellCutE,dir,nextEdge,nextSP] = GetFloorCellCut(currSP,segP,segQ,len,floorIdx,floorStack);
           end
           return
        end
        
        % check if there is free-space on left edge that is above currSP - cell type I
        % already got left edge free-space info so do not have to get it again
        if (isempty(sp) == false && sp > currSP(2))
           currCellCutE = [0 sp];
           nextSP = [1 sp];
           dir = 0;
           nextEdge = 'R';
           return
        end
        
        % check if there is free-space on top edge - cell type J
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end
        
        % check if there is free-space on right edge - cell type K
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
        if isempty(sp) == false
           if (isempty(ep) == true)
               currCellCutE = [1 sp];
               nextSP = [0 sp];
           else
               currCellCutE = [1 ep];
               nextSP = [0 ep];
           end
           dir = 0;
           nextEdge = 'L';
           return
        end
        
        error('Unknown cell cut scenario for startEdge = R');
   
    elseif startEdge == 'L' % left edge
        
        % check if there is free-space on top edge  - cell type L
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end
        
        % check if there is free-space on right edge - cell type M
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
        if isempty(sp) == false
           if (isempty(ep) == true)
               currCellCutE = [1 sp];
               nextSP = [0 sp];
           else
               currCellCutE = [1 ep];
               nextSP = [0 ep];
           end
           dir = 0;
           nextEdge = 'L';
           return
        end
        
        % check if there is free-space on bottom edge - cell type N
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(1,:),len,1); % get bottom edge free space
        if isempty(sp) == false
           if isempty(ep) == true 
               currCellCutE = [sp 0];
               nextSP = [sp 1];
           else
               currCellCutE = [ep 0];
               nextSP = [ep 1];
           end
           dir = 0;
           nextEdge = 'T';
           nextDropFlg = 0;
           return
        end
        
        % check if there is free-space on left edge - cell type O
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false
            currCellCutE = [0 sp];
            nextSP = [1 sp];
            dir = 1;
            nextEdge = 'R';
            return
        end
        
        error('Unknown cell cut scenario for startEdge = L');
        
    else % startEdge == 'B'  bottom edge
        
        % check if there is free-space on left edge - cell type P
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false
            currCellCutE = [0 sp];
            nextSP = [1 sp];
            dir = 0;
            nextEdge = 'R';
            return
        end
        
        % check if there is free-space on top edge - cell type Q
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end
        
        % check if there is free-space on right edge - cell type R
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
        if isempty(sp) == false
           if (isempty(ep) == true)
               currCellCutE = [1 sp];
               nextSP = [0 sp];
           else
               currCellCutE = [1 ep];
               nextSP = [0 ep];
           end
           dir = 0;
           nextEdge = 'L';
           return
        end
        
         % check if there is free-space on bottom edge - cell type S
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(1,:),len,1); % get bottom edge free space
        if isempty(sp) == false
           if isempty(ep) == true 
               currCellCutE = [sp 0];
               nextSP = [sp 1];
           else
               currCellCutE = [ep 0];
               nextSP = [ep 1];
           end
           dir = 0;
           nextEdge = 'T';
           nextDropFlg = 0;
           return
        end
        
        error('Unknown cell cut scenario for startEdge = B');
        
    end

end