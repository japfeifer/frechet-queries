% Function: SubRNNSimpTree
%
% Perform a sub-trajectory RNN on query Qid using the simplification tree.
% Can be used in conjunction with the CCT, i.e. the CCT search is run first and 
% the approximate result is returned (has tree level and start/end vertex Idx).
% Can also be used stand-alone, i.e. just call it from the root (level=1,sIdx=1,eIdx=2).
% 
% Inputs:
% Qid: query ID
% tau: Frechet distance range
% level: simplification tree level to start at
% sIdx: start vertex Idx in simplification tree
% eIdx: end vertex Idx in simplification tree
% typeQ: 1 = additive query, 2 = multiplicative query
% eVal: additive or multiplicating value
% bestDistUB: upper bound distance to result
% graphFlg: 0 = no graph, 1 = graph curves
%
% Outputs:
% queryStrData - various results stored here

function SubRNNSimpTree(Qid,tau,level,sIdx,eIdx,typeQ,eVal,graphFlg)

    switch nargin
    case 5
        typeQ = 1;
        eVal = 0;
        graphFlg = 0;
    case 7
        graphFlg = 0;
    end

    global queryStrData inpTrajSz 

    tSearch = tic;

    timeSearch = 0; timePrune = 0;
    cntLBtot = 0; cntUBtot = 0; cntFDPtot = 0;

    subStr = [];  % structure to store candidate sub-traj set
    
    % initial level setup
    for i = 1:size(sIdx,1) 
        s = max(sIdx(i) - 1,1);
        e = min(eIdx(i) + 1,inpTrajSz(level));
        subStr(i).trajTbl = [];               % table to store pair-wise sub-traj, cols: start vertex Idx, end vertex Idx, LB dist, UB dist, discarded Flg
        subStr(i).allSet = [s:e];             % array of vertex Idx (contiguous), all potential vertices in this candidate sub-traj set
        subStr(i).notDiscSet = [s:e];         % array of vertex Idx, vertices not discarded
        subStr(i).discSet = [];               % array of vertex Idx, vertices discarded
        subStr(i).sChain = 0;                 % start vertex Idx for chain
        subStr(i).eChain = 0;                 % end vertex Idx for chain
        allSetSz = size(subStr(i).allSet,2);
        if allSetSz >= 5 % there is a chain
            subStr(i).sChain = subStr(i).allSet(3);
            subStr(i).eChain = subStr(i).allSet(allSetSz-2);
        end
    end
    
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    if graphFlg == 1
        GraphSubRNN(Qid,level,1,subStr,tau);
    end
    
    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        subStrSz = size(subStr,2);
        for j = 1:subStrSz  % process each candidate sub-traj set
            % get this level's allSet, sChain, eChain
            [subStr(j).allSet,subStr(j).sChain,subStr(j).eChain] = ...
                GetNextLevelVertices(i-1,subStr(j).notDiscSet,subStr(j).sChain,subStr(j).eChain);
            
            % get pairwise sub-traj
            [subStr(j).trajTbl] = GetPairwiseSubTrajRNN(subStr(j).allSet,subStr(j).sChain,subStr(j).eChain);
            
            tPrune = tic;
            % populate trajTbl with Prune/Reduce/Decide results
            [subStr(j).trajTbl,cntLB,cntUB,cntFDP] = ...
                SubRNNPruneReduceDecide(Qid,Q,tau,typeQ,eVal,i,subStr(j).trajTbl,maxLevel);
            
            timePrune = timePrune + toc(tPrune);
            cntLBtot = cntLBtot + cntLB;
            cntUBtot = cntUBtot + cntUB;
            cntFDPtot = cntFDPtot + cntFDP;

            % compute notDiscSet
            notDiscSet = [];
            trajTbl = subStr(j).trajTbl;
            trajTbl(trajTbl(:,5)==1,:) = []; % remove discarded traj
            for k = 1:size(trajTbl,1)
                notDiscSet = unique([notDiscSet trajTbl(k,1):trajTbl(k,2)]); % build set of start/end vertice indexes, remove duplicates
            end
            subStr(j).notDiscSet = notDiscSet;
            
            if size(notDiscSet,2) == 0 % if this set is empty (i.e. all are too far from tau range) then do not have to process it anymore
                break
            end
            
            % compute discSet, i.e. the set difference allSet - notDiscSet
            subStr(j).discSet = setdiff(subStr(j).allSet,subStr(j).notDiscSet);
            
            % see if there are "splits" in the notDiscSet, i.e. if it is non-contiguous
            splitStr = [];
            currSet = [];
            splitNum = 1;
            for k = 1:size(notDiscSet,2)
                if k == 1
                    currSet(end+1) = notDiscSet(k);
                elseif notDiscSet(k) > notDiscSet(k-1) + 1  % non-contiguous chunk
                    splitStr(splitNum).set = currSet; % save prev set
                    splitNum = splitNum + 1;
                    currSet = notDiscSet(k); % start new set
                else % contiguous chunk
                    currSet(end+1) = notDiscSet(k);
                end
            end
            splitStr(splitNum).set = currSet; % save last set
            
            splitStrSz = size(splitStr,2);
            if splitStrSz > 1 % we have to split, so update/insert some subStr info
                subStrSz2 = size(subStr,2);
                for k = 1:splitStrSz
                    if k == 1
                        subStrIdx = j;
                    else
                        subStrSz2 = subStrSz2 + 1;
                        subStrIdx = subStrSz2;
                    end
                    currSet = splitStr(k).set;
                    subStr(subStrIdx).trajTbl = [];
                    subStr(subStrIdx).allSet = currSet;  
                    subStr(subStrIdx).notDiscSet = currSet; % Next level iteration will process this split set.
                    subStr(subStrIdx).discSet = [];
                    subStr(subStrIdx).sChain = 0;        % Next level iteration will compute start/end chains, so just set to no chains.
                    subStr(subStrIdx).eChain = 0;
                end
            else % no splitting, get the intersection of the non-discarded traj vertex Idx in trajTbl, this is the "chain"
                trajTbl = subStr(j).trajTbl;
                trajTbl(trajTbl(:,6)==0,:) = []; % only keep sub-traj that are <= tau distance
                if size(trajTbl,1) > 0 % only check for chains if there are 3 or more segments in trajTbl that are not discarded
                    intersectSet = [];
                    for m = 1:size(trajTbl,1)
                        if isempty(intersectSet) == true
                            intersectSet = [trajTbl(m,1) : trajTbl(m,2)];
                        else
%                             intersectSet = intersect(intersectSet, [trajTbl(m,1) : trajTbl(m,2)]);
                            intersectSet = unique([intersectSet trajTbl(m,1):trajTbl(m,2)]);
                            if isempty(intersectSet) == true
                                break
                            end
                        end
                    end
                    if size(intersectSet,2) > 0
                        subStr(j).sChain = intersectSet(1);
                        subStr(j).eChain = intersectSet(end);
                    else
                        subStr(j).sChain = 0;
                        subStr(j).eChain = 0;
                    end
                else
                    subStr(j).sChain = 0;
                    subStr(j).eChain = 0;
                end
            end
        end

        % see if any candidate sub-traj sets can be discarded
        cIdx = 1;
        while 1 == 1
            if size(subStr(cIdx).notDiscSet,2) == 0
                subStr(cIdx) = [];
            else
                cIdx = cIdx + 1;
            end
            if cIdx > size(subStr,2)
                break
            end
        end
 
        if size(subStr,2) == 0 % there are no reults - return a null result
            break
        end

        if graphFlg == 1
            GraphSubRNN(Qid,i,2,subStr,tau);
        end
    end
    
    timeSearch = toc(tSearch);

    if size(subStr,2) == 0
        queryStrData(Qid).subschain = [];
        queryStrData(Qid).subechain = [];
    else
        for j = 1:size(subStr,2)
            queryStrData(Qid).subschain(j) = subStr(j).notDiscSet(1); % start vertex
            queryStrData(Qid).subechain(j) = subStr(j).notDiscSet(end); % end vertex
        end
    end
    queryStrData(Qid).subcntlb = cntLBtot;
    queryStrData(Qid).subcntub = cntUBtot;
    queryStrData(Qid).subcntfdp = cntFDPtot;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).subprunetime = timePrune;
    
    if graphFlg == 1
        GraphSubRNN(Qid,i,3,subStr,tau);
    end

end