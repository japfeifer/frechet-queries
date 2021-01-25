% Function: GetNextLevelVertices
%
% Gets the next level sub-traj vertices and start/end chain (in the simplification tree).
% If start/end chain is 2 segments or less, set next level start/end chain to 0, i.e. no chain, 
% otherwise reduce size of current level start/end chain by one vertex on each end and then get next
% level start/end chain.
%
% Inputs:
% level - current level of simplification tree (info in inpTrajPtr for this level points to the next level in the tree)
% allSet - current level, array of vertex Idx (contiguous), all potential vertices in this candidate sub-traj set
% sChain - current level, start vertex Idx for chain
% eChain - current level, end vertex Idx for chain
%
% Outputs:
% allSetOut - next level, array of vertex Idx (contiguous), all potential vertices in this candidate sub-traj set
% sChainOut - next level, start vertex Idx for chain
% eChainOut - next level, end vertex Idx for chain

function [allSetOut,sChainOut,eChainOut] = GetNextLevelVertices(level,allSet,sChain,eChain)
            
    global inpTrajPtr
    
    allSetOut = [inpTrajPtr(allSet(1),level) : inpTrajPtr(allSet(end),level)]; % next level sub-traj vertex indices
    
    if  eChain - sChain <= 2 % if start/end chain is 2 segments or less, set next level start/end chain to 0, i.e. no chain
        sChainOut = 0;
        eChainOut = 0;
    else % we can retain part of the chain
        sChainOut = inpTrajPtr(sChain+1,level); % inc current level start chain +1 vertex, and get corresponding next level start chain vertex index
        eChainOut = inpTrajPtr(eChain-1,level); % dec current level end chain -1 vertex, and get corresponding next level end chain vertex index
    end

end