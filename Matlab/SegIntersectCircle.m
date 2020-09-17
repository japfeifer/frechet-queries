% function SegIntersectCircle
%
% Decides if a line segment p1p2 intersects a circle c with radius r.  
% Taken from - https://au.mathworks.com/matlabcentral/answers/401724-how-to-check-if-a-line-segment-intersects-a-circle

function doIntersect = SegIntersectCircle(p1,p2,c,r)

%     P12 = p2 - p1;
%     N   = P12 / norm(P12);  % Normalized vector in direction of the line
%     P1C = c - p1;           % Line from one point to center
%     v   = abs(N(1) * P1C(2) - N(2) * P1C(1));  % Norm of the 2D cross-product
%     doIntersect = (v <= r);

    d1 = CalcPointDist(Cplsp(p1,p2,c),c);
    if d1 <= r
        doIntersect = true;
    else
        doIntersect = false;
    end

end