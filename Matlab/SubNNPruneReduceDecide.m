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

function [trajTbl,smallestLB,smallestUB,cntLB,cntUB,cntFDP,cntCFD,bestDistUB] = ...
    SubNNPruneReduceDecide(Qid,Q,level,trajTbl,smallestUB,maxLevel,bestDistUB)

    global inpTrajVert inpTrajErr inpTrajErrF inP

    typeP = 2; % 1 = non-simp P, 2 = simp P
    useF = 1; % 1 = use frechet dist error, 0 = do not use frechet dist error
    cntLB = 0; cntUB = 0; cntFDP = 0; cntCFD = 0;
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
    smallestUBidx = 0;

    % loop 1: compute using constant or linear LB/UB bounds
    for i = 1:size(trajTbl,1)
        P = subTrajStr(i).traj;
        trajTbl(i,3) = max(GetBestConstLB(P,Q,Inf,3,Qid,0,1) - subTrajStr(i).errLB, 0);  % get the LB
        trajTbl(i,3) = round(trajTbl(i,3),10)+0.00000000009;
        trajTbl(i,3) = fix(trajTbl(i,3) * 10^10)/10^10;
        cntLB = cntLB + 1;
        if trajTbl(i,3) > smallestUB || trajTbl(i,3) > bestDistUB % discard traj
            trajTbl(i,5) = 1;
            trajTbl(i,4) = trajTbl(i,3); % just set UB to LB
        else
            trajTbl(i,4) = GetBestUpperBound(P,Q,3,Qid,0,trajTbl(i,3),0) + subTrajStr(i).errUB; % get the UB
            trajTbl(i,4) = round(trajTbl(i,4),10)+0.00000000009;
            trajTbl(i,4) = fix(trajTbl(i,4) * 10^10)/10^10;
            cntUB = cntUB + 1;
            if trajTbl(i,4) < smallestUB
                smallestUB = trajTbl(i,4);
                smallestUBidx = i;
            end
            if trajTbl(i,4) < bestDistUB
                bestDistUB = trajTbl(i,4);
            end
        end
    end
    
    % there is a scenario where smallestUBidx = 0, so update it
    if smallestUBidx == 0
        smallestUB = Inf;
        for i = 1:size(trajTbl,1)
            if trajTbl(i,5) == 0
                if trajTbl(i,4) < smallestUB
                    smallestUB = trajTbl(i,4);
                    smallestUBidx = i;
                end
            end
        end
    end
    
    % loop 2a: get frechet dist UB/LB for sub-traj that has smallest UB
    if smallestUBidx > 0
        P = subTrajStr(smallestUBidx).traj;
        cfDist = ContFrechet(P,Q); % compute continuous Frechet distance
        cfDist = round(cfDist,10)+0.00000000009;
        cfDist = fix(cfDist * 10^10)/10^10;
        cntCFD = cntCFD + 1;
        trajTbl(smallestUBidx,3) = max(cfDist - subTrajStr(smallestUBidx).errLB, 0); % update LB/UB
        trajTbl(smallestUBidx,4) = cfDist + subTrajStr(smallestUBidx).errUB ;
        if trajTbl(smallestUBidx,4) < smallestUB
            smallestUB = trajTbl(smallestUBidx,4);
        end
    end
    
    % loop 2b: compute using Frechet DP and cont Frechet dist, only look at non-discarded traj
    if level == maxLevel  % only compute these at leaf level
        for i = 1:size(trajTbl,1)
            if trajTbl(i,5) == 0
                if trajTbl(i,3) > smallestUB || trajTbl(i,3) > bestDistUB % discard traj
                    trajTbl(i,5) = 1;
                else
                    P = subTrajStr(i).traj;
                    discFlg = 0;
                    if level == maxLevel % can only do FDP at leaf level with no errors (does not work with errors)
                        cntFDP = cntFDP + 1;
                        if FrechetDecide(P,Q,bestDistUB+0.0000001) == false % compute Frechet decision procedure, discard traj if = false
                            trajTbl(i,5) = 1;
                            discFlg = 1;
                        end
                    end
                    if discFlg == 0
                        cfDist = ContFrechet(P,Q)-0.0000001; % compute continuous Frechet distance
                        cfDist = round(cfDist,10)+0.00000000009;
                        cfDist = fix(cfDist * 10^10)/10^10;
                        cntCFD = cntCFD + 1;
                        trajTbl(i,3) = max(cfDist - subTrajStr(i).errLB, 0); % update LB/UB
                        trajTbl(i,4) = cfDist + subTrajStr(i).errUB ;
                        if trajTbl(i,4) < smallestUB
                            smallestUB = trajTbl(i,4);
                            smallestUBidx = i;
                        end
                        if trajTbl(i,4) < bestDistUB
                            bestDistUB = trajTbl(i,4);
                        end
                        if trajTbl(i,3) > smallestUB || trajTbl(i,3) > bestDistUB % discard traj
                            trajTbl(i,5) = 1;
                        end
                    end
                end
            end
        end
    end
    
    % loop 3: update discFlg, only look at non-discarded traj
    for i = 1:size(trajTbl,1)
        if trajTbl(i,5) == 0
            if trajTbl(i,3) > smallestUB || trajTbl(i,3) > bestDistUB % discard traj
                trajTbl(i,5) = 1; 
            elseif trajTbl(i,3) == trajTbl(i,4) && trajTbl(i,3) == smallestUB && smallestUBidx > 0
                if i ~= smallestUBidx
                    if trajTbl(i,1) <= trajTbl(smallestUBidx,1) && trajTbl(i,2) >= trajTbl(smallestUBidx,2) % sub-traj i vertices are superset
                        trajTbl(i,5) = 1; % mark superset as deleted
                    end
                    if trajTbl(i,1) >= trajTbl(smallestUBidx,1) && trajTbl(i,2) <= trajTbl(smallestUBidx,2) % sub-traj i vertices are subset
                        trajTbl(smallestUBidx,5) = 1; % mark superset as deleted
                        smallestUBidx = i; % make this one the new smallest UB index
                    end
                end
            end
        end
    end   
    
    % set smallest LB, only check non-discarded rows
    smallestLB = min(trajTbl(trajTbl(:,5)==0,3));

end