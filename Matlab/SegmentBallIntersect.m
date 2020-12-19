% Function: SegmentBallIntersect
%
% Determines points in a line segment that intersect a ball.
% There are four possibilites: 
% 1) segment is outside ball
% 2) segment is in interior of ball 
% 3) segment intersects ball once (three sub possibilities - 
%            seg touches "edge" of ball, seg starts in ball and exists, seg starts outside ball and enters)        
% 4) segment intersects ball twice
%
% Line segment starts at vertex p1 and ends at vertex p2.
% Ball is centre c with radius r.
% Works for d-dimensional line segments and balls

function [s1,s2] = SegmentBallIntersect(p1,p2,c,r)

    s1 = [];  s2 = [];
    
    % first check if distance from closest point on line segment to disc 
    % centre is less than radius of disc
    d1 = CalcPointDist(Cplsp(p1,p2,c),c);
    if d1 <= r % possibility 2,3, or 4 
        A = p1-c;
        B = p2-p1;
        d2 = dot(B,B);
        t = (r^2-dot(A,A))*d2+dot(A,B)^2;
        % get disc intersection points I1 and I2
        Q = p1-dot(A,B)/d2*B;
        t2 = sqrt(t)/d2*B;
        I1 = Q + t2;
        I2 = Q - t2;
        if t == 0 % line segment intersects ball at only one point ("edge" of ball)
            s1 = I1;
        else
            pd1 = CalcPointDist(p1,c);
            pd2 = CalcPointDist(p2,c);
            if pd1 > r
                p1d1 = CalcPointDist(p1,I1);
                p1d2 = CalcPointDist(p1,I2);
                if p1d1 < p1d2
                    s1 = I1;
                else
                    s1 = I2;
                end
            else
                s1 = p1;
            end
            if pd2 > r
                p1d1 = CalcPointDist(p2,I1);
                p1d2 = CalcPointDist(p2,I2);
                if p1d1 < p1d2
                    s2 = I1;
                else
                    s2 = I2;
                end
            else
                s2 = p2;
            end
        end
    end

end