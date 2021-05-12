% Function: RecSubNN
%
% Perform a Vertex-Aligned NN sub-trajectory on query Qid using the HST.
% 
% Inputs:
% Qid: query ID
% level: simplification tree level to start at
% C: set of start and end vertex Idx in P
%
% Outputs:
% queryStrData - various query results stored here

function RecSubNN(Qid,Q,i,C)

    global inpTrajSz inpTrajErr Bk PNN numCFD

    % initial setup of sub-traj info
    subStr = [];
    for j = 1:size(C,1) % for each sub-traj
        subStr(j,1) = C(j,1);                             % start idx
        subStr(j,2) = C(j,2);                             % end idx
        subStr(j,3) = subStr(j,2) - subStr(j,1) + 1;       % num vertices
        subStr(j,4) = 0;                                   % lower bound
        subStr(j,5) = Inf;                                 % upper bound
        subStr(j,6) = 0;                                   % too far flag
        subStr(j,7) = 0;                                   % within range flag
        subStr(j,8) = 0;                                   % start vertex id
        subStr(j,9) = 0;                                   % end vertex id
    end
 
    lb = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    i = i + 1;
    err = (2 * inpTrajErr(i)) + 0.0000001;  % metric ball error
    
    % get candidates for this level
    subStr2 = []; subTrajStr2 = [];
    [subStr,subTrajStr] = GetCandidatesHST(subStr,i-1,lb); 
    subStr = subStr2;
    subTrajStr = subTrajStr2;
    
    if i == lb % at leaf level
        for j = 1:size(subStr,1) 
            c = subTrajStr(j).traj;
            cfDist = ContFrechet(c,Q); % compute continuous Frechet distance
            numCFD = numCFD + 1;
            subStr(j,4) = cfDist;
            subStr(j,5) = cfDist;
            if cfDist < Bk
                Bk = cfDist;
                PNN = [subStr(j,8) subStr(j,9)];
            end
        end
        
    else % at parent level
        for j = 1:size(subStr,1) 
            c = subTrajStr(j).traj;
            cfDist = ContFrechet(c,Q); % compute continuous Frechet distance
            numCFD = numCFD + 1;
            subStr(j,4) = cfDist;
            subStr(j,5) = cfDist;
            if Bk < subStr(j,4) - err
                subStr(j,6) = 1;  % mark to discard this sub-traj
            end
        end
        subStr = subStr(subStr(:,6)==0,:);  % discard candidate sub-traj that are too far
        subStr = sortrows(subStr,[5 4],{'ascend' 'descend'}); % sort by smallest UB dist then by largest LB dist
        
        for j = 1:size(subStr,1) 
            if Bk >= subStr(j,4) - err
                RecSubNN(Qid,Q,i,[subStr(j,1) subStr(j,2)])
            end
        end
    end
    
end