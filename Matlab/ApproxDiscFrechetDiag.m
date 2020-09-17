% This function returns an approximate frechet distance in linear
% O(n+m) time.  This is an upper bound on discrete frechet, and hence an
% upper bound on continuous frechet.
% Algorithm referenced in:
% Karl Bringmann et al. 2019. Walking the Dog Fast in Practice. SoCG

function approxDist = ApproxDiscFrechetDiag(P,Q)
    
    approxDist = 0; i = 1; j = 1;
    n = size(P,1);
    m = size(Q,1);
    incN = false;
    incM = false;
    
    if n >= m
        incN = true;
    else
        incM = true;
    end
 
    % get max dist from P origin to Q origin, and P dest to Q dest
    approxDist = max(CalcPointDist(P(i,:),Q(j,:)), CalcPointDist(P(n,:),Q(m,:))); 

    % check all distances in between first and last vertices
    while (i < n) || (j < m)
        if incN == true
            i = i + 1;
            % work around a precision error
            if i==n
                j = m;
            else
                j = ceil(m/n*i);
            end
        else
            j = j + 1;
            % work around a precision error
            if j==m
                i = n;
            else
                i = ceil(n/m*j);
            end
        end
        distA = CalcPointDist(P(i,:),Q(j,:));
        approxDist = max(approxDist,distA);
    end

    approxDist = round(approxDist,10)+0.00000000009;
    approxDist = fix(approxDist * 10^10)/10^10;

end