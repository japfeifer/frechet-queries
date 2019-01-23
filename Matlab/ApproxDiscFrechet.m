% This function returns an approximate discrete frechet distance in linear
% O(n+m) time.  This is an upper bound on discrete frechet, and hence an
% upper bound on continuous frechet.
% Algorithm referenced in:
% Karl Bringmann and Wolfgang Mulzer. 2016. Approximability of the discrete
% Fréchet distance. JoCG 7, 2 (2016), 46/76.

function approxDist = ApproxDiscFrechet(P,Q)
    
    approxDist = 0; i = 1; j = 1;
    sizeP = size(P,1);
    sizeQ = size(Q,1);
    
    % get max dist from P origin to Q origin, and P dest to Q dest
    approxDist = max(CalcPointDist(P(i,:),Q(j,:)), CalcPointDist(P(sizeP,:),Q(sizeQ,:))); 
    
    % check all distances in between first and last vertices
    while (i < sizeP) || (j < sizeQ)
        if (i < sizeP) && (j < sizeQ) % i and j are both less than their curve sizes
            distA = CalcPointDist(P(i+1,:),Q(j,:));
            distB = CalcPointDist(P(i,:),Q(j+1,:));
            distC = CalcPointDist(P(i+1,:),Q(j+1,:));
            if distA <= distB && distA <= distC % dist A is smallest
                approxDist = max(approxDist,distA);
                i = i + 1;
            elseif distB <= distA && distB <= distC % dist B is smallest
                approxDist = max(approxDist,distB);
                j = j + 1;
            else % dist C is smallest
                approxDist = max(approxDist,distC);
                i = i + 1;
                j = j + 1;
            end
        elseif i < sizeP  % and j == sizeQ
            distA = CalcPointDist(P(i+1,:),Q(j,:));
            approxDist = max(approxDist,distA);
            i = i + 1;
        else  % j < sizeQ and i == sizeP
            distA = CalcPointDist(P(i,:),Q(j+1,:));
            approxDist = max(approxDist,distA);
            j = j + 1;
        end
    end
    
    approxDist = round(approxDist,10)+0.00000000009;
    approxDist = fix(approxDist * 10^10)/10^10;
    
end