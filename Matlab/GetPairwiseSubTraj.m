% Function: GetPairwiseSubTraj
%
% Gets all pairwise sub-traj combinations for a given set of contiguous vertex Idx.
% If there is a chain, then the chain must be in each pairwise combo, and hence the number of
% pairwise sub-traj combinations will be smaller.
%
% Inputs:
% allSet - array of vertex Idx (contiguous), all potential vertices in this candidate sub-traj set
% sChain - start vertex Idx for chain
% eChain - end vertex Idx for chain
%
% Outputs:
% trajTbl - table to store pair-wise sub-traj, cols: start vertex Idx, end vertex Idx, LB dist, UB dist, discarded Flg

function trajTbl = GetPairwiseSubTraj(allSet,sChain,eChain)

    trajTbl = [];
    allSetSz = size(allSet,2);
    
    if sChain == 0
        iEnd = allSetSz - 1;
    else
        iEnd = find(allSet==sChain);
        jStart = find(allSet==eChain);
    end
    
    % prepopulate with zeros - faster
    sz = sum(1:iEnd);
    trajTbl(sz,1:5) = 0;
 
    idx = 0;
    for i = 1:iEnd
        if sChain == 0
            jStart = i+1;
        end
        for j = jStart:allSetSz
            idx = idx + 1;
            trajTbl(idx,1:5) = [allSet(i) allSet(j) 0 0 0];
        end
    end
    
    if idx < sz % truncate part of trajTbl
        trajTbl(idx+1:sz,:) = [];
    end

end