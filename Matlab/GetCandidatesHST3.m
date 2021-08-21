
function [subStr] = GetCandidatesHST3(prevSubStr,i,lb)

    switch nargin
    case 3
        la = 0; % look-ahead variable
        Q = [];
    end
    
    global inpTrajPtr inpTrajVert inpTrajRad
    
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
    subStr(1:numTraj,1:13) = 0;

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
            if i+1 < lb % generating parent level candidates
                echainidx = echainidx + 1; % a +1 is inserted since we do not have to check those candidates at parent level
            end
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
    
    for j = 1:size(subStr,1)
        subStr(j,10) = i + 1; 
        subStr(j,12) = 0;
        subStr(j,13) = Inf;
        sz = subStr(j,3);
        idx1 = subStr(j,1);
        idx2 = subStr(j,2);
        for k = subStr(j,10) : lb - 1 % see if we can go to a lower level
            idx1 = inpTrajPtr(idx1,k);
            idx2 = inpTrajPtr(idx2,k);
            sz2 = idx2 - idx1 + 1;
            if sz == sz2
                subStr(j,1) = idx1;
                subStr(j,2) = idx2;
                subStr(j,10) = k + 1;
            else
                break
            end
        end
        if subStr(j,10) < lb
            subStr(j,11) = max(inpTrajRad(subStr(j,1):subStr(j,2) - 1,subStr(j,10)));
        else
            subStr(j,11) = 0; % leaf level, error is 0
        end
    end
    
end