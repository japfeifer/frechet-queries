

function [sIdx,eIdx] = GetVertAlignInclMin(Qid)

    global queryStrData trajStrData
    
    trajIds = queryStrData(Qid).decidetrajids; % get CCT result trajectory ids
    sz = size(trajIds,1);
    
    % create list of sub-traj: start vertex, end vertex, num vertices
    vertList(sz,1:4) = 0;
    for i = 1:sz
        vertList(i,1:2) = [trajStrData(trajIds(i,1)).simptrsidx trajStrData(trajIds(i,1)).simptreidx];
        vertList(i,3) = vertList(i,2) - vertList(i,1) + 1;
    end
    vertList = sortrows(vertList,[1,2]); % sort by start vertex, end vertex
    
    % update vertList with group id
    groupIdx = 0;
    for i = 1:sz
        if i == 1 % first result
            groupIdx = groupIdx + 1;
            vertList(i,4) = groupIdx;
        else
            if vertList(i,1) >= vertList(i-1,1) && vertList(i,1) <= vertList(i-1,2) % still part of same inclusion minimal result
                vertList(i,4) = groupIdx;
            else % new result
                groupIdx = groupIdx + 1;
                vertList(i,4) = groupIdx;
            end
        end
    end
    
    % now create start/end vertex index lists - choose smallest sub-traj from each group id
    sIdx = []; eIdx = [];
    for i = 1:groupIdx
        currList = vertList(vertList(:,4)==i,:); % get rows for this group id
        currList = sortrows(currList,[3,1,2]); % sort by number of vertices, start vertex, end vertex
        sIdx(i,1) = currList(1,1);
        eIdx(i,1) = currList(1,2);
    end

end
