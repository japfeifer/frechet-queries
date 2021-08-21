

function simpP = GetSimpP(stIdx,enIdx,level,lb)

    global inpTrajVert inP
    
    if level+1 < lb
        enIdx = enIdx - 1; % *** the enIdx - 1 is for the Driemel simplification search logic
    end
    idxP = [inpTrajVert(stIdx:enIdx,level+1)]';  % get simplified P sub-traj
    if size(idxP,2) == 1 % if a single vertex, just duplicate it
        idxP = [idxP idxP];
    end
    simpP = inP(idxP,:);
        
end