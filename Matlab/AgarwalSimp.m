% Simplifies a trajectory - reduces the number of vertices based on an
% epsilon value.  Based on the Agarwal et al (2005) method. Utilizes exp/bin
% search.

function [newTraj,idxListP] = AgarwalSimp(P,epsilonDist)

    % initialize some variables
    Pos1 = 1; 
    Pos2 = 1;
    doneTraj = false; 
    doneExpBin = false;
    canMovePos2Back = false;
    expDone = false;
    currDist = 0;
    maxDist = 0;
    lowPos2 = 0;
    highPos2 = 0;
    nextPosAmt = 0;
    idxListP = [];

    % the Cont Frechet code sometimes errors out when there are duplicate 
    % vertices in a row, so let's remove them.  Plus, this will speed
    % things up anyways as there may be less vertices to compute.
    
    P = LinearSimp(P,0);

    % get current trajectory size
    sP = size(P,1);

    Pos2 = min(3,sP); % initialize Pos2 to 3, or the size of P if it is less than 3

    if sP <=2 % there are already 2 or less vertices, so can't simplify
        newTraj = P;
        if sP == 2
            idxListP = [1 sP];
        end
    else    
        % initialize the new traj with the first index
        newTraj = P(Pos1,:);
        idxListP = Pos1;

        while doneTraj == false % simplify sections of the trajectory

            doneExpBin = false;
            canMovePos2Back = false;
            lowPos2 = Pos2;
            highPos2 = Pos2;
            expDone = false;
            nextPosAmt = 4;
            decide = 0;
            
            while doneExpBin == false % do exp/bin search      
                % calc dist
                decide = FrechetDecide(P(Pos1:Pos2,:),cat(1,P(Pos1,:),P(Pos2,:)),epsilonDist);

                % let's see if we are finished this particular exp/bin search
                if decide == 0 && canMovePos2Back == false
                    % we have found the furthest Position (Pos2-1)
                    doneExpBin = true;
                    % also, if Pos2 is at the last vertex and Pos1 is the
                    % previous vertex then we are done processing
                    if (Pos2 == sP && Pos2-1 == Pos1)
                        doneTraj = true;
                    end
                elseif (decide == 1 && Pos2 == sP) 
                    % we have gotten to the last vertex of the traj and the
                    % dist is still less than epsilon, so we are done
                    % processing the entire traj
                    doneExpBin = true;
                    doneTraj = true;
                elseif decide == 1 && nextPosAmt == 1
                    % we have done exp bin search and ended with a vertex that
                    % was within epsilon, so add one to Pos2 and finish exp/bin
                    Pos2 = Pos2 + 1;
                    doneExpBin = true;
                else % there is more exp/bin search to do
                    if decide == 0 % binary backward search
                        expDone = true;
                        highPos2 = Pos2;
                        nextPosAmt = floor((highPos2 - lowPos2) / 2);
                        Pos2 = Pos2 - nextPosAmt;
                        if lowPos2 + 1 == Pos2
                            canMovePos2Back = false;
                        end   
                    elseif expDone == false % exponential forward search
                        lowPos2 = Pos2;
                        Pos2 = min(Pos2 + nextPosAmt, sP);
                        nextPosAmt = nextPosAmt * 2;
                        canMovePos2Back = true;
                    else % binary forward search
                        lowPos2 = Pos2;
                        nextPosAmt = floor((highPos2 - lowPos2) / 2);
                        Pos2 = Pos2 + nextPosAmt;
                        if nextPosAmt > 1
                            canMovePos2Back = true;   
                        else
                            canMovePos2Back = false;
                        end
                    end  
                end  
            end % while doneExpBin == false

            if doneTraj == true % we are done processing the traj
                newTraj = [newTraj; P(sP,:)]; % append last vertex to simplified traj
                idxListP = [idxListP sP];
            else % get next Position indexes
                newTraj = [newTraj; P(Pos2 - 1,:)]; % append Pos2-1 vertex to simplified traj
                idxListP = [idxListP Pos2 - 1];
                Pos1 = Pos2 - 1;
                Pos2 = min(Pos1+2,sP);
            end

        end  % while doneTraj == false
    end % if sP <=2

    if size(newTraj,1) == 1 % simplified traj is only a single vertex
        newTraj = [newTraj; newTraj]; % so add one more vertex   
        idxListP = [1 sP];
    end

end