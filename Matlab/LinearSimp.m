% Simplifies a trajectory - reduces the number of vertices based on an
% epsilon value.  Based on the Driemel et al. (2012) method.
% search.

function [newTraj,idxListP] = LinearSimp(P,epsilonDist)

    % initialize some variables
    Pos1 = 1; 
    Pos2 = 1;
    Pos1to2Dist = 0;
    idxCnt = 0;    
    sP = size(P,1); % get current trajectory size
    
    % pre-allocate memory - faster than incremental memory alloc
    newTraj(sP,size(P,2)) = 0;
    idxListP(sP,1) = 0;
    
    Pos2 = min(2,sP); % initialize Pos2 to 2, or the size of P if it is less than 2

    if sP <=2 % there are already 2 or less vertices, so can't simplify
        newTraj = P;
        newTrajCnt = sP;
        idxCnt = idxCnt + 1;
        idxListP(idxCnt:sP,1) = 1:sP;
    else    
        % initialize the new traj with the first index
        idxCnt = idxCnt + 1;
        newTraj(idxCnt,:) = P(Pos1,:);
        idxListP(idxCnt,1) = Pos1;
        while Pos2 <= sP
            Pos1to2Dist = CalcPointDist(P(Pos1,:),P(Pos2,:));
            if Pos2 == sP  % we are at the last vertex on non-simp P
                % save last vertex
                idxCnt = idxCnt + 1;
                newTraj(idxCnt,:) = P(Pos2,:);
                idxListP(idxCnt,1) = Pos2;
                break
            elseif Pos1to2Dist > epsilonDist  % dist is greater than epsilon
                idx = Pos2;
                idxCnt = idxCnt + 1;
                newTraj(idxCnt,:) = P(idx,:);
                idxListP(idxCnt,1) = idx;
                Pos1 = idx;
                Pos2 = Pos1 + 1;
            else  % we can eliminate this vertex in the simplification
                Pos2 = Pos2 + 1;
            end
        end
    end % if sP <=2
    
    newTraj = newTraj(1:idxCnt,:);
    idxListP = idxListP(1:idxCnt,1);

    if size(newTraj,1) == 1 % simplified traj is only a single vertex
        newTraj = [newTraj; newTraj]; % so add one more vertex    
        idxListP = [1; 2];
    end

end