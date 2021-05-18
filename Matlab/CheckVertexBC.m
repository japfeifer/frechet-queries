% check if result has vertex on right-edge of freespace - boundary cut method
function answ = CheckVertexBC(z,segP,segQ,len)

    answ = 0;
    if z(1,4) == 1 || z(1,4) == 0 || z(1,5) == 1 % starts in cell right edge top or bottom, or ends in cell right edge bottom
        answ = 1;
    elseif z(1,4) < 1 && z(1,4) > 0 && z(1,6) < 1 && z(1,6) > 0
        answ = 0;
    elseif z(1,2) == 1 % we are at the bottom right cell, so have to do an extra check
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
        if isempty(sp) == false
            if sp == 0
                answ = 1;
            elseif isempty(ep) == false
                if ep == 1
                    answ = 1;
                end
            end
        end
    end

end