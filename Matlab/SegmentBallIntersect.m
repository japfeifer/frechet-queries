% Function: SegmentBallIntersect
%
% Determines start point (sp) and end point (ep) of portion of a line segment that is within intersection of a ball.
% I.e. between sp and ep is "free space".
% There are six possibilites: 
% 1) segment is outside ball
% 2) segment is in interior of ball 
% 3) segment intersects ball once - seg touches "edge" of ball
% 4) segment intersects ball once - seg starts in ball and exists
% 5) segment intersects ball once - seg starts outside ball and enters       
% 6) segment intersects ball twice - seg starts outside ball and enters and then exits
%
% Line segment starts at vertex p1 and ends at vertex p2.
% Ball is centre c with radius r.
% Returns points sp,ep, normalized in the interval [0,1]
% Works for d-dimensional line segments and balls

function [sp,ep] = SegmentBallIntersect(p1,p2,c,r,norm)

    sp = [];  ep = [];
    
    % p1 and p2 are the same (i.e. they are a point not a line seg), so just check p1 dist to c
    if sum(p1 == p2) == size(p1,2)
        if CalcPointDist(p1,c) <= r
            sp = 0; ep = 1;
        end
    else % p1 and p2 are a line seg with some dist between them
        % first check if distance from closest point on line segment to disc 
        % centre is less than radius of disc
        d1 = CalcPointDist(Cplsp(p1,p2,c),c);
        if d1 <= r % check possibility 2-6 , if d1 > r then 1) segment is outside ball
            A = p1-c;
            B = p2-p1;
            d2 = dot(B,B);
            t = (r^2-dot(A,A))*d2+dot(A,B)^2;
            % get disc intersection points I1 and I2
            Q = p1-dot(A,B)/d2*B;
            t2 = sqrt(t)/d2*B;
            I1 = Q + t2;
            I2 = Q - t2;
            if t == 0 % 3) segment intersects ball once - seg touches "edge" of ball
                sp = I1;
            else % check possibility 2, 4-6
                pd1 = CalcPointDist(p1,c);
                pd2 = CalcPointDist(p2,c);
                if pd1 <= r && pd2 <= r % 2) segment is in interior of ball
                    sp = p1;
                    ep = p2;
                elseif pd1 <= r && pd2 > r % 4) segment intersects ball once - seg starts in ball and exists
                    sp = p1;
                    ep = I1;
                elseif pd1 > r && pd2 < r % 5) segment intersects ball once - seg starts outside ball and enters 
                    sp = I2;
                    ep = p2;
                else % 6) segment intersects ball twice - seg starts outside ball and enters and then exits
                    sp = I2;
                    ep = I1;
                end
            end
        end
        
        % normalize results to interval [0,1]
        if norm == 1
            if isempty(sp) == false || isempty(ep) == false
                segLen = CalcPointDist(p1,p2);
                if isempty(sp) == false
                    ptLen = CalcPointDist(p1,sp);
                    sp = ptLen / segLen;
                end
                if isempty(ep) == false
                    ptLen = CalcPointDist(p1,ep);
                    ep = ptLen / segLen;
                end
            end
        end
    
    end
    
    if isempty(sp) == false && isnan(sp) == true
        error('sp is NaN');
    end
    if (isempty(ep) == false && isnan(ep) == true)
        error('ep is NaN');
    end
    
end