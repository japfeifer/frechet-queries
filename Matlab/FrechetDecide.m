function [decide,numCell,z] = FrechetDecide(P,Q,len,simpFlag,plotFSD,bndCutFlg,bringFlg,subTrajFlg)

    global I J lP lQ lPQ bP bQ globalBringmann

    switch nargin
    case 3
        simpFlag = 1;
        plotFSD = 0;
        bndCutFlg = 1;
        bringFlg = 1;
        subTrajFlg = 0;
    case 4
        plotFSD = 0;
        bndCutFlg = 1;
        bringFlg = 1;
        subTrajFlg = 0;
    case 5
        bndCutFlg = 1;
        bringFlg = 1;
        subTrajFlg = 0;
    case 6
        bringFlg = 1;
        subTrajFlg = 0;
    end
    
    numCell = 0;
    z = [];
    
    if size(P,2) == 2 && bringFlg == 1 && globalBringmann == 1 % use Bringmann code for 2D space
        decide = FrechetDPBringmann(P,Q,len);
        return
    end

    % Remove duplicate consecutive vertices as there is a bug in continuous 
    % frechet if multiple exact vertices appear.  Plus this will speed things up. 
    if simpFlag == 1
        P = LinearSimp(P,0);
        Q = LinearSimp(Q,0);    
    end
    
    I = size(P,1); J = size(Q,1);
    lP = []; lQ = []; lPQ = []; bP = []; bQ = [];
    
    % There is a bug in cont Frechet if one of the trajectories is a single 
    % edge where each of the two vertices has the same values.  If this is
    % the case for either P or Q then just calc dist to vertex as this
    % is much faster than doing the Frechet calc.  Else do Frechet calc.
    PComp = P(1,:) == P(end,:);
    QComp = Q(1,:) == Q(end,:);
    frechetDist = 0;
    if size(PComp,2) == sum(PComp) && I == 2
        for i = 1:J
            currDist = CalcPointDist(P(1,:),Q(i,:));
            if currDist > frechetDist
                frechetDist = currDist;
            end
        end
        if frechetDist <= len
            decide = 1;
        else
            decide = 0;
        end
    elseif size(QComp,2) == sum(QComp) && J == 2
        for i = 1:I
            currDist = CalcPointDist(Q(1,:),P(i,:));
            if currDist > frechetDist
                frechetDist = currDist;
            end
        end  
        if frechetDist <= len
            decide = 1;
        else
            decide = 0;
        end
    else % do actual frechet decision calc
        if bndCutFlg == 1
            [decide,numCell] = FrechetDecideFast(P,Q,len);
        else
            frechet_init2(P',Q');
            if subTrajFlg == 0
                decide = frechet_decide2(P',Q',len,plotFSD,0);
            else
                [decide,z,numCell] = frechet_decide4(P',Q',len,plotFSD,0);
            end
        end
    end    

end  % function FrechetDecide