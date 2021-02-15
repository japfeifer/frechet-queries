% Function: SubRNNPruneReduceDecide
%
% Computes and populates the LB dist, UB dist, and discarded Flg in the trajTbl.
% Uses NN Prune/Reduce/Decide logic, and the current level error to produce the info.
% NN Pruning is linear in the size of trajTbl (vs. sub-linear when using the CCT).
% Note that even if exact continous Frechet distance is called, result still may have LB/UB
% since we have to account for the level error (i.e. LB = dist - error, and UB = dist + error).
% The goal is to discard sub-traj in trajTbl, by using increasingly more computationally expensive
% distance computations.
%
% Inputs
% Qid: query ID
% Q: query trajectory vertices and coordinates
% level: simplification tree level to start at
% trajTbl: table to store pair-wise sub-traj, cols that are populated: start vertex Idx, end vertex Idx
% smallestUB: smallest upper bound from previous iteration for this candidate set
% maxLevel: max level in the simplification tree
% bestDistUB: smallest upper bound from all candidate sets
%
% Outputs
% trajTbl - table to store pair-wise sub-traj, cols that are computed: LB dist, UB dist, discarded Flg
% smallestLB - smallest LB dist in trajTbl
% smallestUB - smallest UB dist in trajTbl
% cntLB: number of lower bound computations
% cntUB: number of upper bound computations
% cntFDP: number of Frechet Decision Procedure computations
% cntCFD: number of Continuous Frechet Distance computations
% bestDistUB: smallest upper bound from all candidate sets

function [trajTbl,cntLB,cntUB,cntFDP] = ...
    SubRNNPruneReduceDecide(Qid,Q,tau,typeQ,eVal,level,trajTbl,maxLevel)

    global inpTrajVert inpTrajErr inpTrajErrF inP

    typeP = 2; % 1 = non-simp P, 2 = simp P
    useF = 1; % 1 = use frechet dist error, 0 = do not use frechet dist error
    cntLB = 0; cntUB = 0; cntFDP = 0;
    err = inpTrajErr(level); % current level error
    
    % get each sub-traj (vertices and coordinates) in trajTbl and store in subTrajStr
    subTrajStr = [];
    for i = 1:size(trajTbl,1)
        if typeP == 1 % non-simp P
            idx1 = inpTrajVert(trajTbl(i,1),level);
            idx2 = inpTrajVert(trajTbl(i,2),level);
            subTrajStr(i).traj = inP(idx1:idx2,:); % contiguous list of vertex indices in P (a sub-traj of P)
        else % simp P
            idxP = [inpTrajVert(trajTbl(i,1):trajTbl(i,2),level)]';
            subTrajStr(i).traj = inP(idxP,:); % contiguous list of vertex indices in simplified P (a sub-traj of P)
        end
        % compute error bounds
        if useF == 1
            idx3 = trajTbl(i,1);
            idx4 = trajTbl(i,2)-1;
            if level == maxLevel
                errF = 0;
            else
                errF = max([inpTrajErrF(idx3:idx4,level)]);
            end
            errLB = err + errF;
            if typeP == 1
                errUB = 0;
            else
                errUB = errF;
            end
        else
            errLB = 2 * err;
            if typeP == 1
                errUB = 0;
            else
                errUB = err;
            end
        end
        subTrajStr(i).errLB = errLB;
        subTrajStr(i).errUB = errUB;
    end
    
    % Prune/Reduce/Decide - three loops on trajTbl
    trajTbl(:,3) = 0;
    trajTbl(:,4) = Inf;

    % loop 1: compute using constant or linear LB/UB bounds
    for i = 1:size(trajTbl,1)
        P = subTrajStr(i).traj;
        trajTbl(i,3) = max(GetBestConstLB(P,Q,Inf,3,Qid,0,1) - subTrajStr(i).errLB, 0);  % get the LB
        trajTbl(i,3) = round(trajTbl(i,3),10)+0.00000000009;
        trajTbl(i,3) = fix(trajTbl(i,3) * 10^10)/10^10;
        cntLB = cntLB + 1;
        if trajTbl(i,3) > tau  % discard traj
            trajTbl(i,5) = 1;
            trajTbl(i,4) = trajTbl(i,3); % just set UB to LB
        else % check if traj is <= tau
            trajTbl(i,4) = GetBestUpperBound(P,Q,3,Qid,0,trajTbl(i,3),0) + subTrajStr(i).errUB; % get the UB
            trajTbl(i,4) = round(trajTbl(i,4),10)+0.00000000009;
            trajTbl(i,4) = fix(trajTbl(i,4) * 10^10)/10^10;
            cntUB = cntUB + 1;
            if trajTbl(i,4) <= tau
                trajTbl(i,6) = 1; % flag this sub-traj as <= tau (used later to build the "chain")
            end
        end
    end

    % loop 2: compute using Frechet DP, only look at non-discarded traj
    if level == maxLevel  % only compute these at leaf level
        for i = 1:size(trajTbl,1)
            if trajTbl(i,5) == 0
                P = subTrajStr(i).traj;
                if level == maxLevel % can only do FDP at leaf level with no errors (does not work with errors)
                    cntFDP = cntFDP + 1;
                    if FrechetDecide(P,Q,tau+0.0000001) == false % compute Frechet decision procedure, discard traj if = false
                        trajTbl(i,5) = 1;
                        trajTbl(i,4) = trajTbl(i,3); % just set UB to LB
                    else
                        trajTbl(i,6) = 1;
                    end
                end
            end
        end
    end

end