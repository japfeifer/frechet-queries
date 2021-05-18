


function [answ,totCellCheck,totDPCalls,totSPVert] = GetSubDPVA(P,Q,len)

    totCellCheck = 0;
    totDPCalls = 0;
    totSPVert = 0;

    answ = 0;
    spList = GetFreespaceStartPts(P,Q,len); % get the start points on freespace diagram right edge
    totSPVert = totSPVert + size(P,1);
    sz = size(spList,1);
    if sz > 0 % there is at least one freespace interval on freespace diagram right edge
        for j = 1:sz % for each freespace interval
            [answ,numCellCheck] = SubContFrechetFastVACheck(P,Q,len,spList(j,1),spList(j,2));
            totCellCheck = totCellCheck + numCellCheck;
            if answ == 1
                break
            end
        end
    end

end