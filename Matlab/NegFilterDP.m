% negative filter decision proc
% returns true if FreDist(P,Q) > ep, false otherwise

function dec = NegFilterDP(P,Q,ep)

    szQ = size(Q,1);
    szP = size(P,1);
    vertQ = 1;
    dec = false;
    
    for i = 1:szP % for each vertex in P
        while 1 == 1
            currDist = CalcPointDist(P(i,:),Q(vertQ,:));
            currDist = round(currDist,10)+0.00000000009;
            currDist = fix(currDist * 10^10)/10^10;
            if vertQ == szQ
                currDist2 = 0;
            else
                currDist2 = CalcPointDist(Q(vertQ,:),Q(vertQ+1,:));
                currDist2 = round(currDist2,10)+0.00000000009;
                currDist2 = fix(currDist2 * 10^10)/10^10;
            end
            
            if currDist - currDist2 <= ep % current Q vertex, is within distance
                break % do not increment Q, just process next P
            else % try and get next Q vertex
                if vertQ == szQ % there are no more Q vertices, 
                    dec = true;
                    break
                else
                    vertQ = vertQ + 1; % process next Q
                end
            end
        end
        if dec == true
            break
        end
    end
end