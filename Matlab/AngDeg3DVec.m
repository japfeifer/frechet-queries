% function AngDeg3DVec - get the angle in degrees (from 0 to 180) between
% line segment (a,b) and line segment (b,c), where a, b and c are points in 3D.
%
% Note that Theta can also be computed as: 2 * atan(norm(v1*norm(v2) - norm(v1)*v2) / norm(v1 * norm(v2) + norm(v1) * v2))
% Theta can also be computed as: acos(dot(v1,v2) / (norm(v1) * norm(v2)))

function Deg = AngDeg3DVec(a,b,c)

    v1 = a - b; % create 3D vector
    v2 = c - b; % create 3D vector
    Theta = atan2(norm(cross(v1,v2)),dot(v1,v2)); % angle in radians
    Deg = rad2deg(Theta); % angle in degrees

end