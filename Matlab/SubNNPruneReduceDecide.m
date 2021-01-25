% Function: SubNNPruneReduceDecide
%
% Computes and populates the LB dist, UB dist, and discarded Flg in the trajTbl.
% Uses NN Prune/Reduce/Decide logic, and the current level error to produce the info.
% NN Pruning is linear in the size of trajTbl (vs. sub-linear when using the CCT).
% Note that even if exact continous Frechet distance is called, result still may have LB/UB
% since we have to account for the level error (i.e. LB = dist - error, and UB = dist + error).
% The goal is to discard sub-traj in trajTbl, by using increasingly more computationally expensive
% distance computations.
%
% Inputs:
% Q - query trajectory vertices and coordinates
% level - simplification tree level to start at
% trajTbl - table to store pair-wise sub-traj, cols that are populated: start vertex Idx, end vertex Idx
%
% Outputs:
% trajTbl - table to store pair-wise sub-traj, cols that are computed: LB dist, UB dist, discarded Flg
% smallestLB - smallest LB dist in trajTbl
% smallestUB - smallest UB dist in trajTbl

function [trajTbl,smallestLB,smallestUB] = SubNNPruneReduceDecide(Q,level,trajTbl)

    global inpTrajVert inpTrajErr inP
    
    err = inpTrajErr(level); % current level error
    
    % get each sub-traj (vertices and coordinates) in trajTbl and store in subTrajStr
    subTrajStr = [];
    for i = 1:size(trajTbl,1)
        idxP = [inpTrajVert(trajTbl(i,1):trajTbl(i,2),level)]';
        subTrajStr(i).traj = inP(idxP,:); % contiguous list of vertex indices in P (a sub-traj of P)
    end
    
    % Prune/Reduce/Decide - three loops on trajTbl
    
    smallestUB = Inf;
    
    % loop 1: compute using constant or linear LB/UB bounds
    for i = 1:size(trajTbl,1)
        P = subTrajStr(i).traj;
        trajTbl(i,3) = max(GetBestConstLB(P,Q,Inf,0,0,0,1) - err, 0);
        if trajTbl(i,3) > smallestUB % discard traj
            trajTbl(i,5) = 1;
            trajTbl(i,4) = trajTbl(i,3); % just set UB to LB
        else
            trajTbl(i,4) = GetBestUpperBound(P,Q,0,0,0,trajTbl(i,3),0) + err;
            if trajTbl(i,4) < smallestUB
                smallestUB = trajTbl(i,4);
            end
            if GetBestLinearLBDP(P,Q,smallestUB,0,0,0) == true % discard traj
                trajTbl(i,5) = 1;
            end
        end
    end
    
    % loop 2: compute using Frechet DP and cont Frechet dist, only look at non-discarded traj
    for i = 1:size(trajTbl,1)
        if trajTbl(i,5) == 0
            if trajTbl(i,3) > smallestUB % discard traj
                trajTbl(i,5) = 1;
            else
                P = subTrajStr(i).traj;
                if FrechetDecide(P,Q,smallestUB,1) == false % compute Frechet decision procedure, discard traj if = false
                    trajTbl(i,5) = 1;
                else
                    cfDist = ContFrechet(P,Q); % compute continuous Frechet distance
                    trajTbl(i,3) = max(cfDist - err, 0); % update LB/UB
                    trajTbl(i,4) = cfDist + err;
                    if trajTbl(i,4) < smallestUB
                        smallestUB = trajTbl(i,4);
                    end
                    if trajTbl(i,3) > smallestUB % discard traj
                        trajTbl(i,5) = 1;
                    end
                end
            end
        end
    end
    
    % loop 3: update discFlg, only look at non-discarded traj
    for i = 1:size(trajTbl,1)
        if trajTbl(i,5) == 0
            if trajTbl(i,3) > smallestUB % discard traj
                trajTbl(i,5) = 1; 
            end
        end
    end   
    
    % set smallest LB
    smallestLB = min(trajTbl(:,3));

end