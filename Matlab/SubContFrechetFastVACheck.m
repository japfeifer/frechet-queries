

function [answ,totCellCheck,z,zRev] = SubContFrechetFastVACheck(P,Q,len,sCellP,sHeight)

    totCellCheck = 0;
    szQ = size(Q,1);
    z = []; zRev = [];

    [answ,numCellCheck,z] = FrechetDecideSubTraj(P,Q,len,sCellP,sHeight);
    totCellCheck = totCellCheck + numCellCheck;
    if answ == 1
        answ = CheckVertexBC(z,P(1:2,:),Q(szQ-1:szQ,:),len); % check if z has vertex
        if answ == 1 % now check reversed P and Q
            sCellPRev = size(P,1) - z(size(z,1),2);
            sCellLeftP = z(size(z,1),2);
            sHeightRev = 1 - z(size(z,1),6);
            revP = fliplr(P')';
            revQ = fliplr(Q')';
            [answ,numCellCheck,zRev] = FrechetDecideSubTraj(revP,revQ,len,sCellPRev,sHeightRev);
            totCellCheck = totCellCheck + numCellCheck;
            if answ == 1
                answ = CheckVertexBC(zRev,revP(1:2,:),revQ(szQ-1:szQ,:),len); % check if z has vertex
                if answ == 0 % does not have vertex, shrink P - remove start P vertices until reach next left-side free space interval
                    newCellStartP = GetLeftFreespaceStCell(P,Q,len,sCellLeftP);
                    if newCellStartP == -1 || (newCellStartP > sCellP) % no more left-side free space interval
                        answ = 0;
                    else % recursive call for next check with a smaller P 
                        cutsCellP = sCellP - newCellStartP + 1;
                        cutP = P(newCellStartP:size(P,1),:);
                        [answ,numCellCheck,zRev] = SubContFrechetFastVACheck(cutP,Q,len,cutsCellP,sHeight);
                        totCellCheck = totCellCheck + numCellCheck;
                    end
                end
            end
        end
    end

end