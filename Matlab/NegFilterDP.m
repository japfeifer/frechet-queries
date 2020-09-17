% negative filter decision proc
% can return true if FreDist(P,Q) > ep, otherwise it is unknown and return false 

function dec = NegFilterDP(P,Q,ep)

    n = size(P,1);
    m = size(Q,1);
    j = 1;
    dec = false;

    for i = 1:n % for each vertex in P
        while 1 == 1
            if j < m % get distance from point to edge
                currDist = CalcPointDist(Cplsp(Q(j,:),Q(j+1,:),P(i,:)),P(i,:));
            else % at last vertex, so get distance from point to point
                currDist = CalcPointDist(P(i,:),Q(j,:));
            end
            currDist = round(currDist,10)+0.00000000009;
            currDist = fix(currDist * 10^10)/10^10;

            if currDist <= ep % this LB check is less than ep
                break % so try and process next vertex on P
            end

            % get next Q vertex
            if j == m % there are no more Q vertices, so FreDist(P,Q) > ep
                dec = true;
                break
            else % thus far, lower bound dist from P to Q is > ep
                j = j + 1; % process next Q
            end
        end
        if dec == true
            break
        end
    end

end