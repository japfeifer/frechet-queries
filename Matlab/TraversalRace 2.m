% Lower bound decision procedure test.
% If it returns true, then ep <= FreDist(P,Q), otherwise if it returns false
% then no imformation is gained (undefined).

function dec = TraversalRace(P,Q,ep)

    n = size(P,1);
    m = size(Q,1);
    i = 1;
    j = 0;

    while 1 == 1
        % get distance between vertex on P and edge or vertex on Q
        if j == 0 % first vertex on Q
            d = CalcPointDist(P(i,:),Q(1,:));
        elseif j == m % last vertex on Q
            d = CalcPointDist(P(i,:),Q(j,:));
        else % edge on Q
            d = CalcPointDist(Cplsp(Q(j,:),Q(j+1,:),P(i,:)),P(i,:));
        end
        
        % increment i or j
        if d < ep
            i = i + 1;
        else
            j = j + 1;
        end
        
        %  test if done traversing P or Q
        if j > m 
            dec = true;
            break
        elseif i > n
            dec = false;
            break
        end
    end  

end