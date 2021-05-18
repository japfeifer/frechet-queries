

function newCellStartP = GetLeftFreespaceStCell(P,Q,len,sCellLeftP)

    newCellStartP = -1;
    szP = size(P,1);
    segQ = [Q(1,:); Q(2,:)]; % first segment of traj Q
    inFirstFlg = 1;
    for i = sCellLeftP:szP-1
        segP = [P(i,:); P(i+1,:)];
        [sp,ep] = SegmentBallIntersect(segP(1,:),segP(2,:),segQ(1,:),len,1); % get left edge free space
        if i == sCellLeftP || inFirstFlg == 1 
            if isempty(ep) == false
                if ep < 1
                    inFirstFlg = 0;
                end
            elseif isempty(sp) == false && isempty(ep) == true
                inFirstFlg = 0;
            end
        elseif inFirstFlg == 0 && isempty(sp) == false
            newCellStartP = i;
            break
        end

    end

end