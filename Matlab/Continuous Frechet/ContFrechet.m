function [frechetDist] = ContFrechet(P,Q,frechetType,doBounds)

    global I J lP lQ lPQ bP bQ
    
    dfcn = @(u,v) sqrt(sum( (u-v).^2 ));

    if ~exist('frechetType','var')
        frechetType = 1;
    end
    
    if ~exist('doBounds','var')
        doBounds = 1;
    end

    frechetDist = 0;
    
    % Remove duplicate consecutive vertices as there is a bug in continuous 
    % frechet if multiple exact vertices appear.  Plus this will speed things up. 
    P = LinearSimp(P,0);
    Q = LinearSimp(Q,0);
    
    % get upper/lower bounds.  If they equal we are done
    if doBounds == 1
        upBnd = GetBestUpperBound(P,Q);
        lowBnd = GetBestLowerBound(P,Q);
        if upBnd == lowBnd % we are done, this is the Continuous Frechet dist
            frechetDist = upBnd;
            return
        end
        if upBnd < lowBnd % if there is a bug in up/low bounds, set them back to 0 and Inf
            upBnd = Inf;
            lowBnd = 0;
        end
    else
        upBnd = Inf;
        lowBnd = 0;
    end
    
    I = size(P,1); J = size(Q,1);
    lP = []; lQ = []; lPQ = []; bP = []; bQ = [];

    % There is a bug in cont Frechet if one of the trajectories is a single 
    % edge where each of the two vertices has the same values.  If this is
    % the case for either P or Q then just calc dist to vertex as this
    % is much faster than doing the Frechet calc.  Else do Frechet calc.
    PComp = P(1,:) == P(end,:);
    QComp = Q(1,:) == Q(end,:);
    if size(PComp,2) == sum(PComp) && I == 2
        for j = 1:J
            currDist = dfcn(P(1,:),Q(j,:));
            if currDist > frechetDist
                frechetDist = currDist;
                frechetDist = round(frechetDist,10)+0.00000000009;
                frechetDist = fix(frechetDist * 10^10)/10^10;
            end
        end
    elseif size(QComp,2) == sum(QComp) && J == 2
        for i = 1:I
            currDist = dfcn(Q(1,:),P(i,:));
            if currDist > frechetDist
                frechetDist = currDist;
                frechetDist = round(frechetDist,10)+0.00000000009;
                frechetDist = fix(frechetDist * 10^10)/10^10;
            end
        end        
    else % do actual frechet calc
        if frechetType == 1
            frechet_init2(P',Q');
            frechetDist = frechet_compute2(P',Q',0,upBnd,lowBnd);
        elseif frechetType == 0
            frechet_init(P',Q');
            frechetDist = frechet_compute(P',Q',0);
        end
    end

end  % function ContFrechet