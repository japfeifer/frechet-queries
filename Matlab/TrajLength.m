
% Calculates the reach of a trajectory.  The reach is the distance from the
% origin vertex to the furthest vertex in the trajectory.
% Works for N-dimensional trajectories.

function lengthValue = TrajLength(P)

    % initialize variables
    lengthValue = 0;
    sizeP = size(P,1);

    if sizeP >= 1
        for i = 1:sizeP-1
            currDist = CalcPointDist(P(i,:),P(i+1,:));
            lengthValue = lengthValue + currDist;
        end
    else
        lengthValue = 0;  % only one vertex in traj, so length is 0
    end

end