
% Calculates the reach of a trajectory.  The reach is the distance from the
% origin vertex to the furthest vertex in the trajectory.
% Works for N-dimensional trajectories.

function reachValue = TrajReach(P)

    % initialize variables
    reachValue = 0;
    sizeP = size(P,1);

    if sizeP >= 1
        for i = 1:sizeP
            currDist = CalcPointDist(P(1,:),P(i,:));
            if currDist > reachValue
                reachValue = currDist;
            end
        end
    else
        reachValue = 0;  % only one vertex in traj, so reach is 0
    end

end