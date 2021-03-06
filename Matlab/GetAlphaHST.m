


function [alpha,totCellCheck,subStart,subEnd] = GetAlphaHST(subStr,level,Q)

    global decimalPrecision inP inpTrajVert
    
    minIdx = min(subStr(:,1));
    maxIdx = max(subStr(:,2));
    
    idxP = [inpTrajVert(minIdx:maxIdx,level)]'; % get non-simplified traj at leaf level
    P = inP(idxP,:);

    [alpha,totCellCheck,z,zRev] = SubContFrechetFastVA(P,Q,decimalPrecision);
    
    idxOffset = minIdx - 1; % need an offset to P, since P is most likely a sub-traj
    szCut = size(z,1);
    subStart = z(szCut,2) + idxOffset;
    subEnd = z(1,2) + idxOffset + 1; % a +1 is added since end is a freespace cell and not a vertex

end