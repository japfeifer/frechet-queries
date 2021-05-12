% Function: GreedySubNN
%


function [alpha,cntCFD,cntFDP,cntLB,cntUB] = GreedySubNN(Qid,level,C,la)

    switch nargin
    case 3
        la = 0;
    end

    global queryStrData inpTrajSz inpTrajErr

    cntCFD = 0;
    cntFDP = 0;
    cntLB = 0;
    cntUB = 0;
    alpha = Inf;
    
    % initial level setup of sub-traj info
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
 
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    lb = size(inpTrajSz,2); % the leaf level for the simplification tree
    
    for i = level:lb-1 % traverse the simplification tree one level at a time, start at level + 1
        
        i = i + 1;
        err = (2 * inpTrajErr(i)) + 0.0000001;  % metric ball error
        
        % get candidates for this level
        subStr2 = []; subTrajStr2 = [];
        [subStr2,subTrajStr2] = GetCandidatesHST(subStr,i-1,lb,la,Q); 
        subStr = subStr2;
        subTrajStr = subTrajStr2;
        
        % for each candidate, compute CF and set alpha to smallest
        alpha = Inf;
        for j = 1:size(subStr,1) 
            c = subTrajStr(j).traj;
            if alpha == Inf
                ans = 1;
            else
                subStr(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
                cntLB = cntLB + 1;
                if subStr(j,4) > alpha + err
                    ans = 0;
                else
                    ans = 1;
%                     ans = FrechetDecide(c,Q,alpha + err);
%                     cntFDP = cntFDP + 1;
                end
            end
            if ans == 1 % compute cont Frechet dist
                cfDist = ContFrechet(c,Q); % compute continuous Frechet distance
                cntCFD = cntCFD + 1;
                subStr(j,4) = cfDist;
                subStr(j,5) = cfDist;
                if cfDist < alpha
                    alpha = cfDist;
                end
            end
            if ans == 0 % mark candidate to discard
                subStr(j,4) = Inf; 
                subStr(j,5) = Inf;
            end
        end
        
        % for each candidate, discard if alpha + 2*r(l) < CF(c,Q)
        for j = 1:size(subStr,1)
            if alpha + err < subStr(j,4)
                subStr(j,6) = 1;  % mark to discard this sub-traj
            end
        end
        subStr = subStr(subStr(:,6)==0,:);  % discard candidates sub-traj that are too far
        
        % Now do the greedy part. Only keep the candidate with the smallest UB.
        subStr = sortrows(subStr,[5],{'ascend'}); % sort by UB
        subStr = subStr(1,:); % just keep the 1st candidate
        
        % error checking
        if size(subStr,1) == 0 
            error('NN Result set is empty');
        end
    end
    
end