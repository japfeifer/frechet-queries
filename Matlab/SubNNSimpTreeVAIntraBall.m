% Function: SubNNSimpTreeVAIntraBall
%
% Perform a Vertex-Aligned sub-trajectory NN on query Qid using the simplification tree.
% Can be used in conjunction with the CCT, i.e. the CCT search is run first and 
% the approximate result is returned (has tree level and start/end vertex Idx).
% Can also be used stand-alone, i.e. just call it from the root (level=1,sIdx=1,eIdx=2).
% 
% Inputs:
% Qid: query ID
% level: simplification tree level to start at
% sIdx: start vertex Idx in simplification tree
% eIdx: end vertex Idx in simplification tree
% typeQ: 1 = additive query, 2 = multiplicative query
% eVal: additive or multiplicating value
% graphFlg: 0 = no graph, 1 = graph curves
%
% Outputs:
% queryStrData - various query results stored here

function SubNNSimpTreeVAIntraBall(Qid,level,sIdx,eIdx,typeQ,eVal,graphFlg)

    switch nargin
    case 4
        typeQ = 1;
        eVal = 0;
        graphFlg = 0;
        useF = 0;
    case 7
        graphFlg = 0;
    end

    global queryStrData inpTrajSz inpTrajPtr inpTrajVert inpTrajErr inP

    tSearch = tic;

    timeSearch = 0; timePrune = 0;
    cntLB = 0; cntUB = 0; cntFDP = 0; cntCFD = 0;
    foundResFlg = 0; smallestLB = 0;
    bestDistUB = Inf;
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
    end
 
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    if graphFlg == 1
        GraphSubNN(Qid,level,1,subStr);
    end
    
    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        
        prevSubStr = subStr;
        subStr = [];
        
        % get the worst-case number of sub-traj checks
        if i == level+1
            numWorst = 0;
            for j = 1:size(prevSubStr,1)
                sidx = prevSubStr(j,1);
                eidx = prevSubStr(j,2);
                svert = inpTrajVert(sidx,i-1);
                evert = inpTrajVert(eidx,i-1);
                if prevSubStr(j,3) >= 3 % there are chain vertices
                    schainidx = prevSubStr(j,1) + 1;
                    echainidx = prevSubStr(j,2) - 1;
                    schainvert = inpTrajVert(schainidx,i-1);
                    echainvert = inpTrajVert(echainidx,i-1);
                    numWorst = numWorst + ((schainvert-svert+1) * (evert-echainidx+1));
                else
                    numWorst = numWorst + sum(1:evert-svert+1);
                end
            end
        end
        
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
                            subStr(cnt,1:7) = [ii jj jj-ii+1 0 Inf 0 0];
                            cnt = cnt + 1;
                        end
                    end
                end
            else % no chain vertices
                for ii = sidx:eidx-1
                    for jj = ii+1:eidx
                        subStr(cnt,1:7) = [ii jj jj-ii+1 0 Inf 0 0];
                        cnt = cnt + 1;
                    end
                end
            end
        end
        subStr = subStr(1:cnt-1,:); % we may have pre-allocated too much space so trim it
        subStr = unique(subStr,'rows'); % remove any duplicate sub-trajectories
        numSubTraj = [numSubTraj; size(subStr,1) 0];

        tPrune = tic;
         
        % get each sub-traj (vertices and coordinates) and error
        err = inpTrajErr(i); % current level error
        subTrajStr = [];
        for j = 1:size(subStr,1)
            % get simplified P sub-traj
            idxP = [inpTrajVert(subStr(j,1):subStr(j,2),i)]';
            subTrajStr(j).traj = inP(idxP,:); % contiguous list of vertex indices in simplified P (a sub-traj of P)
            % compute error bounds
            if i == maxLevel % at leaf level
                subTrajStr(j).err = 0;
            else % use ball radius error
                subTrajStr(j).err = (2 * err) + 0.0000001;
            end
        end

        % compute LB/UB and "too far flag"
        bestDistUBidx = 0;
%         bestDistUB = Inf;
        if i ~= maxLevel
            for j = 1:size(subStr,1)
                P = subTrajStr(j).traj;
                subStr(j,4) = GetBestConstLB(P,Q,Inf,3,Qid,0,1);  % get the LB
%                 subStr(j,4) = round(subStr(j,4),10)+0.00000000009;
%                 subStr(j,4) = fix(subStr(j,4) * 10^10)/10^10;
                cntLB = cntLB + 1;
                if bestDistUB + subTrajStr(j).err < subStr(j,4) % discard traj
                    subStr(j,6) = 1; % too far flg = 1
                    subStr(j,5) = subStr(j,4); % just set UB to LB
                else
                    cntFDP = cntFDP + 1;
                    if FrechetDecide(P,Q,bestDistUB + subTrajStr(j).err) == false % compute Frechet decision procedure, discard traj if = false
                        subStr(j,6) = 1; % too far flg = 1
                        subStr(j,5) = bestDistUB + subTrajStr(j).err; 
                    else
                        subStr(j,5) = GetBestUpperBound(P,Q,3,Qid,0,subStr(j,4),0); % get the UB
%                         subStr(j,5) = round(subStr(j,5),10)+0.00000000009;
%                         subStr(j,5) = fix(subStr(j,5) * 10^10)/10^10;
                        cntUB = cntUB + 1;
                        if subStr(j,5) < bestDistUB
                            bestDistUB = subStr(j,5) + 0.000001;
                            bestDistUBidx = j;
                        end
                        if eVal > 0 % there is a query additive or multiplicative error
                            if typeQ == 1 % additive error
                                eAdd = eVal;
                            else
                                eAdd = eVal * smallestLB;
                            end
                            if subStr(j,5) <= eAdd % we found a candidate within the error bound
                                foundResFlg = 1;
                                candTrajSet = j;
                                break
                            end
                        end
                    end           
                end
            end
        end
        
        if eVal > 0 && foundResFlg == 1
            break
        end
        
        % compute the Frechet dist for the sub-traj with the best UB
        if bestDistUBidx > 0
            P = subTrajStr(bestDistUBidx).traj;
            cfDist = ContFrechet(P,Q); % compute continuous Frechet distance
%             cfDist = round(cfDist,10)+0.00000000009;
%             cfDist = fix(cfDist * 10^10)/10^10;
            cntCFD = cntCFD + 1;
            subStr(bestDistUBidx,4) = cfDist; % update LB/UB
            subStr(bestDistUBidx,5) = cfDist;
            if subStr(bestDistUBidx,5) < bestDistUB
                bestDistUB = subStr(bestDistUBidx,5) + 0.000001;
            end
        end

        % compute dist using cont Frechet dist and DP
        if i == maxLevel  % only compute these at leaf level
            for j = 1:size(subStr,1)
                if subStr(j,6) == 0 % only look at sub-traj that are not too far
                    if bestDistUB + subTrajStr(j).err < subStr(j,4) % discard traj
                        subStr(j,6) = 1; % too far flg = 1
                    else
                        P = subTrajStr(j).traj;
                        cntFDP = cntFDP + 1;
                        if FrechetDecide(P,Q,bestDistUB + subTrajStr(j).err) == false % compute Frechet decision procedure, discard traj if = false
                            subStr(j,6) = 1; % too far flg = 1
                            subStr(j,5) = bestDistUB + subTrajStr(j).err; 
                        else
                            cfDist = ContFrechet(P,Q); % compute continuous Frechet distance
%                             cfDist = round(cfDist,10)+0.00000000009;
%                             cfDist = fix(cfDist * 10^10)/10^10;
                            cntCFD = cntCFD + 1;
                            subStr(j,4) = cfDist; % update LB/UB
                            subStr(j,5) = cfDist;
                            if subStr(j,5) < bestDistUB
                                bestDistUB = subStr(j,5) + 0.000001;
                                bestDistUBidx = j;
                            end
                            if bestDistUB + subTrajStr(j).err < subStr(j,4)  % discard traj
                                subStr(j,6) = 1; % too far flg = 1
                            end
                            if eVal > 0 % there is a query additive or multiplicative error
                                if typeQ == 1 % additive error
                                    eAdd = eVal;
                                else
                                    eAdd = eVal * smallestLB;
                                end
                                if subStr(j,5) <= eAdd % we found a candidate within the error bound
                                    foundResFlg = 1;
                                    candTrajSet = j;
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
        
        if eVal > 0 && foundResFlg == 1
            break
        end
        
        % there still may be some sub-traj that can be marked as too far
        for j = 1:size(subStr,1)
            if subStr(j,6) == 0 % only look at sub-traj that are not too far
                if bestDistUB + subTrajStr(j).err < subStr(j,4) % discard traj
                    subStr(j,6) = 1; % too far flg = 1
                end
            end
        end
        
        timePrune = timePrune + toc(tPrune);

        if graphFlg == 1
            GraphSubNN(Qid,i,2,subStr);
        end
        
        numSubTraj(end,2) = sum(subStr(:,6)); % count number of candidates to discard
        subStr = subStr(subStr(:,6)==0,:);  % discard candidates sub-traj that are too far

        % compute smallest LB (needed for queries with additive/multiplicative errors)
        if eVal > 0
            smallestLB = min(subStr(:,4));
        end

        % more than one final result with same smallest distance
        if i == maxLevel && size(subStr,1) > 1 
            subStr = sortrows(subStr,[4 3],'ascend'); % sort by smallest LB dist then sub-traj size
        end

    end
    
    timeSearch = toc(tSearch);

    if foundResFlg == 0
        candTrajSet = 1;
    end
    
    if size(subStr,1) == 0
        error('Result set is empty');
    end

    queryStrData(Qid).subsvert = subStr(candTrajSet,1); % start vertex
    queryStrData(Qid).subevert = subStr(candTrajSet,2); % end vertex
    queryStrData(Qid).sublb = subStr(candTrajSet,4); % LB dist
    queryStrData(Qid).subub = subStr(candTrajSet,5); % UB dist
    queryStrData(Qid).subcntworst = numWorst;
    queryStrData(Qid).subcntsubtraj = numSubTraj;
    queryStrData(Qid).subcntlb = cntLB;
    queryStrData(Qid).subcntub = cntUB;
    queryStrData(Qid).subcntfdp = cntFDP;
    queryStrData(Qid).subcntcfd = cntCFD;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).subprunetime = timePrune;
    
    if graphFlg == 1
        GraphSubNN(Qid,i,3,subStr);
    end

end