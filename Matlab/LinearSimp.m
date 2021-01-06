% Simplifies a trajectory - reduces the number of vertices based on an
% epsilon value.  Based on the Driemel et al. (2012) method.
% search.

function [newTraj] = LinearSimp(P,epsilonDist)

    % initialize some variables
    Pos1 = 1; 
    Pos2 = 1;
    Pos1to2Dist = 0;

    % get current trajectory size
    sP = size(P,1);

    Pos2 = min(2,sP); % initialize Pos2 to 2, or the size of P if it is less than 2

    if sP <=2 % there are already 2 or less vertices, so can't simplify
        newTraj = P;
    else    
        % initialize the new traj with the first index
        newTraj = P(Pos1,:);

        for i = Pos2:sP
            Pos1to2Dist = CalcPointDist(P(Pos1,:),P(Pos2,:));
            if i == sP  % we are at the last vertex
                doneTraj = true;
                % only add last vertex if it is diff than  prev vertex
                xyz = P(Pos1,:) == P(Pos2,:);
                if size(xyz,2) ~= sum(xyz)
                    newTraj = [newTraj; P(i,:)];
                end
            elseif Pos1to2Dist > epsilonDist  % dist is greater than epsilon
                newTraj = [newTraj; P(i,:)];
                Pos1 = i;
                Pos2 = Pos1 + 1;
            else  % we can eliminate this vertex in the simplification
                Pos2 = Pos2 + 1;
            end
        end

    end % if sP <=2

    if size(newTraj,1) == 1 % simplified traj is only a single vertex
        newTraj = [newTraj; newTraj]; % so add one more vertex        
    end

end