% Function: SubNNSimpTree
%
% Perform a sub-trajectory NN on query Qid using the simplification tree.
% Can be used in conjunction with the CCT, i.e. the CCT search is run first and 
% the approximate result is returned (has tree level and start/end vertex Idx).
% Can also be used stand-alone, i.e. just call it from the root (level=1,sIdx=1,eIdx=2).
% 
% Inputs:
% Qid - query ID
% level - simplification tree level to start at
% sIdx - start vertex Idx in simplification tree
% eIdx - end vertex Idx in simplification tree
%
% Outputs:
% queryStrData - various results stored here

function SubNNSimpTree(Qid,level,sIdx,eIdx,graphFlg)

    switch nargin
    case 4
        graphFlg = 0;
    end

    global queryStrData inpTrajSz timeSub

    timeSub = 0;
    cntLBtot = 0; cntUBtot = 0; cntFDPtot = 0; cntCFDtot = 0;
    
    subStr = [];                          % structure to store candidate sub-traj set
    subStr(1).trajTbl = [];               % table to store pair-wise sub-traj, cols: start vertex Idx, end vertex Idx, LB dist, UB dist, discarded Flg
    subStr(1).allSet = [sIdx:eIdx];       % array of vertex Idx (contiguous), all potential vertices in this candidate sub-traj set
    subStr(1).notDiscSet = [sIdx:eIdx];   % array of vertex Idx, vertices not discarded
    subStr(1).discSet = [];               % array of vertex Idx, vertices discarded
    subStr(1).smallestLB = 0;             % smallest LB from trajTbl
    subStr(1).smallestUB = Inf;           % smallest UB from trajTbl
    subStr(1).sChain = 0;                 % start vertex Idx for chain
    subStr(1).eChain = 0;                 % end vertex Idx for chain
    
    % initial level setup
    allSetSz = size(subStr(1).allSet,2);
    if allSetSz > 3 % there is a chain
        subStr(1).sChain = subStr(1).allSet(2);
        subStr(1).eChain = subStr(1).allSet(allSetSz-1);
    end
    
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    maxLevel = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    if graphFlg == 1
        GraphSubNN(Qid,level,1,subStr);
    end
    
    for i = level+1:maxLevel % traverse the simplification tree one level at a time, start at level + 1
        subStrSz = size(subStr,2);
        for j = 1:subStrSz  % process each candidate sub-traj set
            % get this level's allSet, sChain, eChain
            [subStr(j).allSet,subStr(j).sChain,subStr(j).eChain] = ...
                GetNextLevelVertices(i-1,subStr(j).notDiscSet,subStr(j).sChain,subStr(j).eChain);
            
            % get pairwise sub-traj
            [subStr(j).trajTbl] = GetPairwiseSubTraj(subStr(j).allSet,subStr(j).sChain,subStr(j).eChain);
            
            tSub = tic;
            % populate trajTbl with Prune/Reduce/Decide results
            [subStr(j).trajTbl,subStr(j).smallestLB,subStr(j).smallestUB,cntLB,cntUB,cntFDP,cntCFD] = ...
                SubNNPruneReduceDecide(Qid,Q,i,subStr(j).trajTbl,subStr(j).smallestUB);
            
            timeSub = timeSub + toc(tSub);
            cntLBtot = cntLBtot + cntLB;
            cntUBtot = cntUBtot + cntUB;
            cntFDPtot = cntFDPtot + cntFDP;
            cntCFDtot = cntCFDtot + cntCFD;

            % compute notDiscSet
            notDiscSet = [];
            trajTbl = subStr(j).trajTbl;
            trajTbl(trajTbl(:,5)==1,:) = []; % remove discarded traj
            for k = 1:size(trajTbl,1)
                notDiscSet = unique([notDiscSet trajTbl(k,1):trajTbl(k,2)]); % build set of start/end vertice indexes, remove duplicates
            end
            subStr(j).notDiscSet = notDiscSet;
            
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
                    subStr(subStrIdx).smallestLB = 0;    % Set bounds to extremes because we do not want to discard, the
                    subStr(subStrIdx).smallestUB = Inf;  % next level iteration will process the new candidate sub-traj set and compute bounds.
                    subStr(subStrIdx).sChain = 0;        % Next level iteration will compute start/end chains, so just set to no chains.
                    subStr(subStrIdx).eChain = 0;
                end
            else % no splitting, get the intersection of the non-discarded traj vertex Idx in trajTbl, this is the "chain"
                if size(subStr(j).notDiscSet,2) > 3 && size(trajTbl,2) > 1 % only check for chains if there are 3 or more segments in trajTbl that are not discarded
                    intersectSet = [];
                    for m = 1:size(trajTbl,1)
                        if isempty(intersectSet) == true
                            intersectSet = [trajTbl(m,1) : trajTbl(m,2)];
                        else
                            intersectSet = intersect(intersectSet, [trajTbl(m,1) : trajTbl(m,2)]);
                            if isempty(intersectSet) == true
                                break
                            end
                        end
                    end
                    if isempty(intersectSet) == false
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
        
        % if 2 or more candidate sub-traj sets, see if any can be discarded
        if size(subStr,2) > 1
            smallestUB = min([subStr.smallestUB]);
            currStrIdx = 1;
            while 1 == 1
                if subStr(currStrIdx).smallestLB > smallestUB
                    subStr(currStrIdx) = [];
                else
                    currStrIdx = currStrIdx + 1;
                end
                if currStrIdx > size(subStr,2)
                    break
                end
            end
        end
        
        if graphFlg == 1
            GraphSubNN(Qid,i,2,subStr);
        end
    end

    % smallest NN traj result is subStr(1).sChain to subStr(1).eChain (the intersection of traj results)
    queryStrData(Qid).subschain = subStr(1).notDiscSet(1);
    queryStrData(Qid).subechain = subStr(1).notDiscSet(end);
    queryStrData(Qid).subcntlb = cntLBtot;
    queryStrData(Qid).subcntub = cntUBtot;
    queryStrData(Qid).subcntfdp = cntFDPtot;
    queryStrData(Qid).subcntcfd = cntCFDtot;
    
    if graphFlg == 1
        GraphSubNN(Qid,i,3,subStr);
    end

end