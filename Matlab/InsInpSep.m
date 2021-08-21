
function InsInpSep(c)

    global inpSep inpTrajVert
    
    foundCluster = 0;
    lb = size(inpTrajVert,2); % leaf level
    cTraj = GetSimpP(c(1),c(2),c(10)-1,lb); % get candidate traj
    if c(10) < lb % if candidate is not at leaf level then check if it can be placed in cluster
        for i = 1:size(inpSep,2) % see if c can be placed in existing cluster
            if c(10) >= inpSep(i).level % only check if candidate level error is same or smaller than cluster level error
                currTraj = GetSimpP(inpSep(i).stidx,inpSep(i).enidx,inpSep(i).level-1,lb); % get cluster center traj
                ans = FrechetDecide(cTraj,currTraj,inpSep(i).err,0,0,1,0,0); % frechet DP, check if <= err distance
                if ans == 1 % the candidate can be placed in this cluster
                    inpSep(i).leafs(end+1,:) = c;
                    foundCluster = 1;
                    break
                end
            end
        end
    end
    
    if foundCluster == 0 % place c in a new cluster
        idx = size(inpSep,2) + 1;
        inpSep(idx).level = c(10);
        inpSep(idx).err = c(11);
        inpSep(idx).stidx = c(1);
        inpSep(idx).enidx = c(2);
        inpSep(idx).leafs = c;
    end

end