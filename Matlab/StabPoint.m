% Function: StabPoint
%
% Determines "stab" point s on line segment p1p2 that first "stabs" disc
% with centre at point c and radius r.  Line segment starts at vertex p1 
% and ends at vertex p2. If the stab point does not exist, then return
% empty set in s.
%
% Works for d-dimensional line segments and discs

function s = StabPoint(p1,p2,c,r)

    s = [];  % begin by assuming line segment does not stab disc
    
    A = p1-c;
    B = p2-p1;
    d2 = dot(B,B);
    t = (r^2-dot(A,A))*d2+dot(A,B)^2;

    if t >= 0 % line segment may intersect disc
        % first check if distance from closest point on line segment to disc 
        % centre is less than radius of disc
        d1 = CalcPointDist(Cplsp(p1,p2,c),c);
        if d1 <= r
            % get disc intersection points I1 and I2
            Q = p1-dot(A,B)/d2*B;
            t2 = sqrt(t)/d2*B;
            I1 = Q + t2;
            I2 = Q - t2;
            if t == 0 % line segment intersects disc at only one point (stabs "edge" of disc)
                s = I1;
            else
                p1d = CalcPointDist(p1,c);
                if p1d >= r % start vertex p1 starts outside disc, so segment stabs disc
                    % determine if I1 or I2 is the stab point - choose the one closest to p1
                    p1d1 = CalcPointDist(p1,I1);
                    p1d2 = CalcPointDist(p1,I2);
                    if p1d1 < p1d2
                        s = I1;
                    else
                        s = I2;
                    end
                end
            end
        end
    end
end