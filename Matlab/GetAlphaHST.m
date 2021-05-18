


function [alpha,totCellCheck,z,zRev] = GetAlphaHST(subStr,level,Q)

    global decimalPrecision inP inpTrajVert
    
    minIdx = min(subStr(:,1));
    maxIdx = max(subStr(:,2));
    
    idxP = [inpTrajVert(minIdx:maxIdx,level)]';
    P = inP(idxP,:);
    
    [alpha,totCellCheck,z,zRev] = SubContFrechetFastVA(P,Q,decimalPrecision);

end