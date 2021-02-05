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

function [trajTbl,smallestLB,smallestUB,cntLB,cntUB,cntFDP,cntCFD] = SubNNPruneReduceDecide(Qid,Q,level,trajTbl,smallestUB)

    global inpTrajVert inpTrajErr inP
    
    err = 2 * inpTrajErr(level); % current level error
    cntLB = 0; cntUB = 0; cntFDP = 0; cntCFD = 0;
    
    % get each sub-traj (vertices and coordinates) in trajTbl and store in subTrajStr
    subTrajStr = [];
    for i = 1:size(trajTbl,1)
        idxP = [inpTrajVert(trajTbl(i,1):trajTbl(i,2),level)]';
        subTrajStr(i).traj = inP(idxP,:); % contiguous list of vertex indices in P (a sub-traj of P)
    end
    
    % Prune/Reduce/Decide - three loops on trajTbl
    
%     smallestUB = Inf;
    
    trajTbl(:,3) = 0;
    trajTbl(:,4) = Inf;
    smallestUBidx = 0;
    
    % loop 1: compute using constant or linear LB/UB bounds
    for i = 1:size(trajTbl,1)
        P = subTrajStr(i).traj;
        trajTbl(i,3) = max(GetBestConstLB(P,Q,Inf,3,Qid,0,1) - err, 0);  % get the LB
        cntLB = cntLB + 1;
        if trajTbl(i,3) > smallestUB % discard traj
            trajTbl(i,5) = 1;
            trajTbl(i,4) = trajTbl(i,3); % just set UB to LB
        else
            trajTbl(i,4) = GetBestUpperBound(P,Q,3,Qid,0,trajTbl(i,3),0) + err; % get the UB
            cntUB = cntUB + 1;
            if trajTbl(i,4) < smallestUB
                smallestUB = trajTbl(i,4);
                smallestUBidx = i;
            end
%             if GetBestLinearLBDP(P,Q,smallestUB,0,0,0) == true % discard traj (this code slows down the query, so it is commented out)
%                 trajTbl(i,5) = 1;
%             end
        end
    end
    
    % loop 2: compute using Frechet DP and cont Frechet dist, only look at non-discarded traj
    for i = 1:size(trajTbl,1)
        if trajTbl(i,5) == 0
            if trajTbl(i,3) > smallestUB % discard traj
                trajTbl(i,5) = 1;
            else
                P = subTrajStr(i).traj;
                cntFDP = cntFDP + 1;
                if FrechetDecide(P,Q,smallestUB+0.00000001) == false % compute Frechet decision procedure, discard traj if = false
                    trajTbl(i,5) = 1;
                else     
                    cntFDP = cntFDP + 1;
                    if FrechetDecide(P,Q,smallestUB-0.00000001) == false % smallestUB is the cont frechet dist
                        cfDist = smallestUB;
                    else
                        cfDist = ContFrechet(P,Q); % compute continuous Frechet distance
                        cntCFD = cntCFD + 1;
                    end
                    trajTbl(i,3) = max(cfDist - err, 0); % update LB/UB
                    trajTbl(i,4) = cfDist + err;
                    if trajTbl(i,4) < smallestUB
                        smallestUB = trajTbl(i,4);
                        smallestUBidx = i;
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