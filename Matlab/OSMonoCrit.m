% one-sided monotonicity criterion
% returns true if LB > ep

% *** there is currently a bug in this code. We should check dist from P to
% an edge or vertex in Q, but currently only check to a vertex in Q.

function dec = OSMonoCrit(P,Q,ep)

    dec = false; % default to false
    szQ = size(Q,1);
    szP = size(P,1);
    vertQ = 1;
    
    for i = 1:szP
        for j = vertQ:szQ
            currDist = CalcPointDist(P(i,:),Q(j,:));
            currDist = round(currDist,10)+0.00000000009;
            currDist = fix(currDist * 10^10)/10^10;
            if currDist > ep && j == vertQ
                dec = true;
                return
            elseif currDist > ep
                vertQ = j;
                break
            elseif j == szQ 
                vertQ = szQ;
            end
        end
    end
    
end