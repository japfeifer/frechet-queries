

function [sIdx,eIdx] = GetCCTPairwiseCand(Qid)

    global queryStrData trajStrData simpLevelCCT inpTrajSz
    
    trajIds = queryStrData(Qid).decidetrajids; % get CCT result trajectory ids
    sz = size(trajIds,1);
    
    % create list of sub-traj: start vertex, end vertex *** these are idx for inpTrajVert table
    vertList(sz,1:2) = 0;
    for i = 1:sz
        vertList(i,1:2) = [trajStrData(trajIds(i,1)).simptrsidx trajStrData(trajIds(i,1)).simptreidx];
    end

    vertList = sortrows(vertList,[1,2]); % sort by start vertex, end vertex

    % create pairwise sub-traj candidates
    pairwiseList = [];
    for i = 1:size(vertList,1)
        if vertList(i,1) == 1 % start vertex is in first index position
            sList = [vertList(i,1)];
        else
            sList = [vertList(i,1) - 1,  vertList(i,1)];
        end
        if vertList(i,2) == inpTrajSz(simpLevelCCT) % end vertex is in last index position
            eList = [vertList(i,2)];
        else
            eList = [vertList(i,2), vertList(i,2) + 1];
        end
        for j = 1:size(sList,2)
            for k = 1:size(eList,2)
                pairwiseList = [pairwiseList; sList(j) eList(k)];
            end
        end
    end

    pairwiseList = unique(pairwiseList,'rows'); % remove duplicates
    pairwiseList(pairwiseList(:,1)==pairwiseList(:,2), :) = []; % remove rows where start and end vertex are the same
    
    % now create start/end vertex index lists
    sIdx = pairwiseList(:,1);
    eIdx = pairwiseList(:,2);

end
