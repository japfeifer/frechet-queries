

function startPtsList = GetFreespaceStartPts(P,Q,len)

    startPtsList = [];
    szP = size(P,1); 
    szQ = size(Q,1);
    currCellP = szP - 1;
    currCellQ = szQ - 1;
    segQ = [Q(currCellQ,:); Q(currCellQ+1,:)]; % end segment of traj Q
    inFreeSpace = 0;
    idx = 1;
    for i = currCellP:-1:1 % loop from end to beginning segment of P
        segP = [P(i,:); P(i+1,:)];
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(2,:),len,1); % get right edge free space
        if isempty(sp) == false && inFreeSpace == 0 % starting a new freespace
            if isempty(ep) == false
                startPtsList(idx,1:2) = [i ep];
            else
                startPtsList(idx,1:2) = [i sp];
            end
            idx = idx + 1;
            if sp == 0 % there is free space to the bottom of this cell
                inFreeSpace = 1;
            end
        elseif isempty(sp) == false && sp > 0 &&  inFreeSpace == 1  % ending freespace
            inFreeSpace = 0;
        end
    end

end