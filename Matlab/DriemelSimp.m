% Simplifies a trajectory - reduces the number of vertices based on an
% epsilon value.  Based on the Driemel et al. (2012) method.
% search.

function [newTraj,idxListP] = DriemelSimp(P,epsilonDist)

    % initialize some variables
    Pos1 = 1; 
    Pos2 = 1;
    Pos1to2Dist = 0;

    % get current trajectory size
    sP = size(P,1);
    
    % pre-allocate memory - faster than incremental memory alloc
    newTraj(sP,size(P,2)) = 0;
    newTrajCnt = 1;
    idxListP(sP,1) = 0;
    idxListPCnt = 1;
    
    Pos2 = min(2,sP); % initialize Pos2 to 2, or the size of P if it is less than 2

    if sP <=2 % there are already 2 or less vertices, so can't simplify
        newTraj = P;
        newTrajCnt = newTrajCnt + sP;
        idxListP(idxListPCnt:sP,1) = 1:sP;
        idxListPCnt = idxListPCnt + sP;
    else    
        % initialize the new traj with the first index
        newTraj(newTrajCnt,:) = P(Pos1,:);
        newTrajCnt = newTrajCnt + 1;
        idxListP(idxListPCnt,1) = Pos1;
        idxListPCnt = idxListPCnt + 1;

        for i = Pos2:sP
            Pos1to2Dist = CalcPointDist(P(Pos1,:),P(Pos2,:));
            if i == sP  % we are at the last vertex
                doneTraj = true;
                % only add last vertex if it is diff than  prev vertex
                xyz = P(Pos1,:) == P(Pos2,:);
                if size(xyz,2) ~= sum(xyz)
                    newTraj(newTrajCnt,:) = P(i,:);
                    newTrajCnt = newTrajCnt + 1;
                    idxListP(idxListPCnt,1) = i;
                    idxListPCnt = idxListPCnt + 1;
                end
            elseif Pos1to2Dist > epsilonDist  % dist is greater than epsilon
                newTraj(newTrajCnt,:) = P(i,:);
                newTrajCnt = newTrajCnt + 1;
                idxListP(idxListPCnt,1) = i;
                idxListPCnt = idxListPCnt + 1;
                Pos1 = i;
                Pos2 = Pos1 + 1;
            else  % we can eliminate this vertex in the simplification
                Pos2 = Pos2 + 1;
            end
        end

    end % if sP <=2
    
    newTraj = newTraj(1:newTrajCnt - 1,:);
    idxListP = idxListP(1:idxListPCnt - 1,1);

    if size(newTraj,1) == 1 % simplified traj is only a single vertex
        newTraj = [newTraj; newTraj]; % so add one more vertex    
        idxListP = [1; 1];
    end

end