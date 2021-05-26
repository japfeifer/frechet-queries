


function [alpha,totCellCheck,subStart,subEnd] = GetSubTrajNNVA2(subStr,level,Q,lb)

    global decimalPrecision inP inpTrajVert inpTrajPtr
    
    minIdx = min(subStr(:,1));
    maxIdx = max(subStr(:,2));
    
    newMinIdx = minIdx;
    newMaxIdx = maxIdx;
    for i = level:lb-1
        newMinIdx = inpTrajPtr(newMinIdx,i);
        newMaxIdx = inpTrajPtr(newMaxIdx,i);
    end
    
    idxP = [inpTrajVert(newMinIdx:newMaxIdx,lb)]'; % get non-simplified traj at leaf level
    P = inP(idxP,:);

    [alpha,totCellCheck,z,zRev] = SubContFrechetFastVA(P,Q,decimalPrecision);
    
    idxOffset = minIdx - 1; % need an offset to P, since P is most likely a sub-traj
    szCut = size(z,1);
    subStart = z(szCut,2) + idxOffset;
    subEnd = z(1,2) + idxOffset + 1; % a +1 is added since end is a freespace cell and not a vertex

end