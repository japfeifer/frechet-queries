% Function: SubNNSimpTreeVAUB
%
% Greedily get an UB

function [bestDistUB,cntUB,cntCFD] = SubNNSimpTreeVAUB(Qid,level,sIdx,eIdx)

    global queryStrData inpTrajSz inpTrajPtr inpTrajVert inpTrajErr inP

    cntUB = 0; cntCFD = 0;
    numSubTraj = [];
    
    subStr = [];  % structure to store candidate sub-traj set
    
    % initial level setup of sub-traj info
    for i = 1:size(sIdx,1) % for each sub-traj
        subStr(i,1) = sIdx(i);                             % start idx
        subStr(i,2) = eIdx(i);                             % end idx
        subStr(i,3) = subStr(i,2) - subStr(i,1) + 1;       % num vertices
        subStr(i,4) = 0;                                   % lower bound
        subStr(i,5) = Inf;                                 % upper bound
        subStr(i,6) = 0;                                   % too far flag
        subStr(i,7) = 0;                                   % within range flag
        subStr(i,8) = 0;                                   % start vertex id
        subStr(i,9) = 0;                                   % end vertex id
    end
 
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree

    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        
        prevSubStr = subStr;
        subStr = [];
        bestDistUB = Inf;

        % determine number of pairwise traj so that memory can be pre-allocated (faster)
        numTraj = 0;
        for j = 1:size(prevSubStr,1)
            sidx = prevSubStr(j,1);
            eidx = prevSubStr(j,2);
            sidx = inpTrajPtr(sidx,i-1);
            eidx = inpTrajPtr(eidx,i-1);
            if prevSubStr(j,3) >= 3 % there are chain vertices
                schainidx = prevSubStr(j,1) + 1;
                echainidx = prevSubStr(j,2) - 1;
                schainidx = inpTrajPtr(schainidx,i-1);
                echainidx = inpTrajPtr(echainidx,i-1);
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
            sidx = inpTrajPtr(sidx,i-1);
            eidx = inpTrajPtr(eidx,i-1);
            if prevSubStr(j,3) >= 3 % there are chain vertices
                schainidx = prevSubStr(j,1) + 1;
                echainidx = prevSubStr(j,2) - 1;
                schainidx = inpTrajPtr(schainidx,i-1);
                echainidx = inpTrajPtr(echainidx,i-1);
                for ii = sidx:schainidx
                    for jj = echainidx:eidx
                        if ii ~= jj
                            schainvert = inpTrajVert(ii,i);
                            echainvert = inpTrajVert(jj,i);
                            subStr(cnt,1:9) = [ii jj jj-ii+1 0 Inf 0 0 schainvert echainvert];
                            cnt = cnt + 1;
                        end
                    end
                end
            else % no chain vertices
                for ii = sidx:eidx-1
                    for jj = ii+1:eidx
                        svert = inpTrajVert(ii,i);
                        evert = inpTrajVert(jj,i);
                        subStr(cnt,1:9) = [ii jj jj-ii+1 0 Inf 0 0 svert evert];
                        cnt = cnt + 1;
                    end
                end
            end
        end
        subStr = subStr(1:cnt-1,:); % we may have pre-allocated too much space so trim it
        subStr = unique(subStr,'rows'); % remove any duplicate sub-trajectories
        numSubTraj = [numSubTraj; size(subStr,1) 0];

        % get each sub-traj (vertices and coordinates) and error
        subTrajStr = [];
        for j = 1:size(subStr,1)
            stIdx = subStr(j,1);
            enIdx = subStr(j,2);
            if i < maxLevel
                enIdx = enIdx - 1; % *** the enIdx - 1 is for the Driemel simplification search logic
            end
            % get simplified P sub-traj
            idxP = [inpTrajVert(stIdx:enIdx,i)]';
            if size(idxP,2) == 1 % if a single vertex, just duplicate it
                idxP = [idxP idxP];
            end
            subTrajStr(j).traj = inP(idxP,:); % contiguous list of vertex indices in simplified P (a sub-traj of P)
            % compute error bounds
            if i == maxLevel % at leaf level
                subTrajStr(j).err = 0;
            else % use ball radius error
                subTrajStr(j).err = inpTrajErr(i) * 2 + 0.0000001;
            end
        end

        % compute UB
        for j = 1:size(subStr,1)
            P = subTrajStr(j).traj;
%             subStr(j,5) = GetBestUpperBound(P,Q,3,Qid,0,subStr(j,4),0); % get the UB
%             cntUB = cntUB + 1;
            
            subStr(j,5) = ContFrechet(P,Q); % compute continuous Frechet distance
            cntCFD = cntCFD + 1;
            
            if subStr(j,5) + subTrajStr(j).err + 0.000001 < bestDistUB
                bestDistUB = subStr(j,5) + subTrajStr(j).err + 0.000001;
                bestDistUBidx = j;
            end
        end

%         % compute the Frechet dist for the sub-traj with the best UB
%         if bestDistUBidx > 0
%             P = subTrajStr(bestDistUBidx).traj;
%             cfDist = ContFrechet(P,Q); % compute continuous Frechet distance
%             cntCFD = cntCFD + 1;
%             subStr(bestDistUBidx,5) = cfDist;
%             if subStr(bestDistUBidx,5) + subTrajStr(bestDistUBidx).err + 0.000001 < bestDistUB
%                 bestDistUB = subStr(bestDistUBidx,5) + subTrajStr(bestDistUBidx).err + 0.000001;
%             end
%         end

        subStr = subStr(bestDistUBidx,:);  % only keep the sub-traj that has the lowest UB

    end

end