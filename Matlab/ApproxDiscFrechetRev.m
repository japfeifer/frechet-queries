% Same as ApproxDiscFrechet but it runs in the Reverse direction

function approxDist = ApproxDiscFrechetRev(P,Q)
    
    approxDist = 0;
    sizeP = size(P,1);
    sizeQ = size(Q,1);
    i = sizeP; j = sizeQ;
    
    % get max dist from P origin to Q origin, and P dest to Q dest
    approxDist = max(CalcPointDist(P(1,:),Q(1,:)), CalcPointDist(P(sizeP,:),Q(sizeQ,:))); 
    
    % check all distances in between first and last vertices
    while (i > 1) || (j > 1)
        if (i > 1) && (j > 1) % i and j are both less than their curve sizes
            distA = CalcPointDist(P(i-1,:),Q(j,:));
            distB = CalcPointDist(P(i,:),Q(j-1,:));
            distC = CalcPointDist(P(i-1,:),Q(j-1,:));
            if distA <= distB && distA <= distC % dist A is smallest
                approxDist = max(approxDist,distA);
                i = i - 1;
            elseif distB <= distA && distB <= distC % dist B is smallest
                approxDist = max(approxDist,distB);
                j = j - 1;
            else % dist C is smallest
                approxDist = max(approxDist,distC);
                i = i - 1;
                j = j - 1;
            end
        elseif i > 1  % and j == 1
            distA = CalcPointDist(P(i-1,:),Q(j,:));
            approxDist = max(approxDist,distA);
            i = i - 1;
        else  % j > 1 and i == 1
            distA = CalcPointDist(P(i,:),Q(j-1,:));
            approxDist = max(approxDist,distA);
            j = j - 1;
        end
    end

    approxDist = round(approxDist,10)+0.00000000009;
    approxDist = fix(approxDist * 10^10)/10^10;

end