
function [subStr,subTrajStr] = GetCandidatesHST(subStr,i,lb,la,Q)

    switch nargin
    case 3
        la = 0; % look-ahead variable
        Q = [];
    end
    
    global inpTrajPtr inpTrajVert inP inpTrajSz
    
    prevSubStr = subStr;
    subStr = [];

    % determine number of pairwise traj so that memory can be pre-allocated (faster)
    numTraj = 0;
    for j = 1:size(prevSubStr,1)
        sidx = prevSubStr(j,1);
        eidx = prevSubStr(j,2);
        sidx = inpTrajPtr(sidx,i);
        eidx = inpTrajPtr(eidx,i);
        if prevSubStr(j,3) >= 3 % there are chain vertices
            schainidx = prevSubStr(j,1) + 1;
            echainidx = prevSubStr(j,2) - 1;
            schainidx = inpTrajPtr(schainidx,i);
            echainidx = inpTrajPtr(echainidx,i);
            numTraj = numTraj + ((schainidx-sidx+1) * (eidx-echainidx+1));
        else
            numTraj = numTraj + sum(1:eidx-sidx+1);
        end
    end
    subStr(1:numTraj,1:7) = 0;

    % generate this level pairwise subStr set
    cnt = 1;
    for j = 1:size(prevSubStr,1)
        sidx = prevSubStr(j,1);
        eidx = prevSubStr(j,2);
        sidx = inpTrajPtr(sidx,i);
        eidx = inpTrajPtr(eidx,i);
        if prevSubStr(j,3) >= 3 % there are chain vertices
            schainidx = prevSubStr(j,1) + 1;
            echainidx = prevSubStr(j,2) - 1;
            schainidx = inpTrajPtr(schainidx,i);
            echainidx = inpTrajPtr(echainidx,i);
            for ii = sidx:schainidx
                for jj = echainidx:eidx
                    if ii ~= jj
                        schainvert = inpTrajVert(ii,i+1);
                        echainvert = inpTrajVert(jj,i+1);
                        subStr(cnt,1:9) = [ii jj jj-ii+1 0 Inf 0 0 schainvert echainvert];
                        cnt = cnt + 1;
                    end
                end
            end
        else % no chain vertices
            for ii = sidx:eidx-1
                for jj = ii+1:eidx
                    svert = inpTrajVert(ii,i+1);
                    evert = inpTrajVert(jj,i+1);
                    subStr(cnt,1:9) = [ii jj jj-ii+1 0 Inf 0 0 svert evert];
                    cnt = cnt + 1;
                end
            end
        end
    end
    subStr = subStr(1:cnt-1,:); % we may have pre-allocated too much space so trim it
    subStr = unique(subStr,'rows'); % remove any duplicate sub-trajectories
    
    % get each sub-traj (vertices and coordinates) and error
    la = min(size(inpTrajSz,2)-(i+1), la); % update look-ahead, can't look past the leaf level
    subTrajStr = [];
    for j = 1:size(subStr,1)
        stIdx = subStr(j,1);
        enIdx = subStr(j,2);
        if i+1 < lb
            enIdx = enIdx - 1; % *** the enIdx - 1 is for the Driemel simplification search logic
        end
        if la > 0 && stIdx < enIdx % we want to look ahead some number of HST levels, sub-traj must be at least one segment
            [sSeg,eSeg] = GetSubTrajLookAhead(stIdx,stIdx+1,i+1,i+1+la);
            minPtDist = Inf;
            for k = sSeg:eSeg-1 % find closest point in P simplified sub-traj to the first vertex in Q
                ptDist = CalcPointDist(Q(1,:), inP(inpTrajVert(k,i+1+la),:) );
                if ptDist < minPtDist
                    minPtDist = ptDist;
                    newStIdx = inpTrajVert(k,i+1+la);
                    bestk = k;
                end
            end
            if stIdx == enIdx - 1 % there is a single segment in sub-traj
                minPtDist = Inf;
                for k = bestk:eSeg-1 % find closest point in P simplified sub-traj to the last vertex in Q
                    ptDist = CalcPointDist(Q(end,:), inP(inpTrajVert(k,i+1+la),:) );
                    if ptDist < minPtDist
                        minPtDist = ptDist;
                        newEnIdx = inpTrajVert(k,i+1+la);
                    end
                end
                if newStIdx == newEnIdx
                    idxP = [newStIdx];
                else
                    idxP = [newStIdx newEnIdx];
                end
            else % there is > 1 segment in sub-traj
                idxP = [newStIdx inpTrajVert(stIdx+1:enIdx,i+1)'];
            end
        else
            idxP = [inpTrajVert(stIdx:enIdx,i+1)]';  % get simplified P sub-traj
        end
        if size(idxP,2) == 1 % if a single vertex, just duplicate it
            idxP = [idxP idxP];
        end
        subTrajStr(j).traj = inP(idxP,:); % contiguous list of vertex indices in simplified P (a sub-traj of P)
    end

end