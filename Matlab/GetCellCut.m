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

function [currCellCutS,currCellCutE,dir,nextEdge,nextSP] = GetCellCut(currCellP,currSP,segP,segQ,len,startEdge)

    currCellCutS = currSP;
    
    if startEdge == 'T' % top edge
        
        % check if we can "fall" down to bottom edge
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(1,:),len,1); % get bottom edge free space
        if (isempty(sp) == false && isempty(ep) == true && sp == currSP(1)) || ...
           (isempty(sp) == false && isempty(ep) == false && sp <= currSP(1) && ep >= currSP(1))
           currCellCutE = [currSP(1) 0];
           nextSP = [currSP(1) 1];
           dir = 1;
           if currCellP == 1 % at bottom row in free-space diagram
               [currCellCutS,currCellCutE,dir,nextEdge,nextSP] = GetCellCut(currCellP,currCellCutE,segP,segQ,len,'R');
           else
               nextEdge = 'T';
           end
           return
        end
        
        % check if there is free-space on bottom edge that is further left of currSP
        % already got bottom edge free-space info so do not have to get it again
        if (isempty(sp) == false && isempty(ep) == true && sp <= currSP(1)) || ...
           (isempty(sp) == false && isempty(ep) == false && ep < currSP(1))
           if isempty(ep) == true 
               currCellCutE = [sp 0];
               nextSP = [sp 0];
           else
               currCellCutE = [ep 0];
               nextSP = [ep 0];
           end
           dir = 1;
           if currCellP == 1 % at bottom row in free-space diagram
               [currCellCutS,currCellCutE,dir,nextEdge,nextSP] = GetCellCut(currCellP,currCellCutE,segP,segQ,len,'R');
           else
               nextEdge = 'T';
           end
           return
        end
        
        % check if there is free-space on left edge
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false
            currCellCutE = [0 sp];
            nextSP = [1 sp];
            dir = 1;
            nextEdge = 'R';
            return
        end
        
        error('Unknown cell cut scenario for startEdge = T');
        
    elseif startEdge == 'R' % right edge
        
        % check if there is free-space on bottom edge
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
                   currCellCutE = [sp 0];
                   [currCellCutS,currCellCutE,dir,nextEdge,nextSP] = GetCellCut(currCellP,currCellCutE,segP,segQ,len,'B');
               end
           end
           return
        end
        
        % check if there is free-space on left edge that is same or below currSP
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false && sp <= currSP(2)
           currCellCutE = [0 sp];
           nextSP = [1 sp];
           dir = 1;
           nextEdge = 'R';
           return
        end
        
        % check if there is free-space on left edge that is above currSP
        % already got left edge free-space info so do not have to get it again
        if (isempty(sp) == false && sp > currSP(2))
           currCellCutE = [0 sp];
           nextSP = [1 sp];
           dir = 0;
           nextEdge = 'R';
           return
        end
        
        % check if there is free-space on top edge
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end
        
        error('Unknown cell cut scenario for startEdge = R');
   
    elseif startEdge == 'L' % left edge
        
        % check if there is free-space on top edge
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end
        
        % check if there is free-space on right edge
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
        
        % check if there is free-space on bottom edge
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
           return
        end
        
        error('Unknown cell cut scenario for startEdge = L');
        
    else % startEdge == 'B'  bottom edge
        
        % check if there is free-space on left edge
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if isempty(sp) == false
            currCellCutE = [0 sp];
            nextSP = [1 sp];
            dir = 0;
            nextEdge = 'R';
            return
        end
        
        % check if there is free-space on top edge
        [sp,ep] = SegmentBallIntersect(segQ(1,:),segQ(2,:),segP(2,:),len,1); % get top edge free space
        if isempty(sp) == false
           currCellCutE = [sp 1];
           nextSP = [sp 0];
           dir = 0;
           nextEdge = 'B';
           return
        end
        
        % check if there is free-space on right edge
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
        
        error('Unknown cell cut scenario for startEdge = B');
        
    end

end