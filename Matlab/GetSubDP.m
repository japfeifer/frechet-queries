


function [ans,totCellCheck,totDPCalls,totSPVert] = GetSubDP(P,Q,currLen)

    totCellCheck = 0;
    totDPCalls = 0;
    totSPVert = 0;

    ans = 0;
    startPtsVertList = GetFreespaceStartPts(P,Q,currLen); % get the start points on freespace diagram right edge
    totSPVert = totSPVert + size(P,1);
    sz = size(startPtsVertList,1);
    if sz > 0 % there is at least one freespace interval on freespace diagram right edge
        for j = 1:sz % for each freespace interval
            [ans,numCellCheck] = FrechetDecideSubTraj(P,Q,currLen,startPtsVertList(j,1),startPtsVertList(j,2));
            totDPCalls = totDPCalls + 1;
            totCellCheck = totCellCheck + numCellCheck;
            if ans == 1
                break
            end
        end
    end

end