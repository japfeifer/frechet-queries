% Function: MainImprovedSubNN
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

function MainImprovedSubNN(Qid,level,C,la)

    switch nargin
    case 3
        la = 0;
        typeQ = 1;
        eVal = 0;
    end

    global queryStrData inpTrajSz inpTrajErr

    tSearch = tic;

    timeSearch = 0; 
    maxCsz = 10000;
    cntCFD = 0;
    cntFDP = 0;
    cntLB = 0;
    cntUB = 0;
    numSubTraj = [];
    alpha = Inf;
    totCell = 0;
    maxc = 0;
    
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
    
    % traverse the simplification tree one level at a time
    % start at level + 1, end at parent level above leafs
    for i = level:lb-1 
        
        thisLevel = i + 1;
        err = (2 * inpTrajErr(thisLevel)) + 0.0000001;  % metric ball error
        alpha = Inf;
        
        % get candidates for this level
        subStr2 = []; subTrajStr2 = [];
        [subStr2,subTrajStr2] = GetCandidatesHST(subStr,thisLevel-1,lb,la,Q); 
        subStr = subStr2;
        subTrajStr = subTrajStr2;
        
        if size(subStr,1) > maxCsz || thisLevel == lb % stop checking HST levels if |C| is large, or at leaf level
            break
        end

        % get this levels sub-traj distance
        [alpha,numCellCheck] = GetAlphaHST(subStr,thisLevel,Q); 
        totCell = totCell + numCellCheck;
        
        % for each candidate, compute LB and see if we can discard it
        for j = 1:size(subStr,1) 
            c = subTrajStr(j).traj;
            if size(c,1) > maxc
                maxc = size(c,1);
            end
            subStr(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
            totCell = totCell + (size(c,1) + size(Q,1))*2;
            cntLB = cntLB + 1;
            if subStr(j,4) > alpha + err
                subStr(j,6) = 1;  % mark to discard this sub-traj
            end
        end
        
        % for each candidate, discard if alpha + 2*r(l) < CF(c,Q)
        numSubTraj = [numSubTraj; size(subStr,1) 0 0];
        numSubTraj(end,2) = sum(subStr(:,6)); % count number of candidates to discard
        subStr = subStr(subStr(:,6)==0,:);  % discard candidate sub-traj that are too far

        % error checking
        if size(subStr,1) == 0 
            error('NN Result set is empty');
        end
        
    end
    
    % do sub-traj cont frechet dist call to get final result
    [alpha,numCellCheck,z,zRev] = GetAlphaHST(subStr,thisLevel,Q);
    totCell = totCell + numCellCheck;
    subStr = [0 0 0 0 0 0 0 0 0];
    subStr(1,8) = zRev(1,2); % start vertex
    subStr(1,9) = z(1,2); % end vertex
    subStr(1,4) = alpha; % LB dist
    subStr(1,5) = alpha; % UB dist

    % get the inclusion maximal candidate
    if size(subStr,1) > 1 
        subStr = sortrows(subStr,[5 3],{'ascend' 'descend'}); % sort by smallest UB dist then by largest sub-traj size
    end

    timeSearch = toc(tSearch);

    % store results
    queryStrData(Qid).subsvert = subStr(1,8); % start vertex
    queryStrData(Qid).subevert = subStr(1,9); % end vertex
    queryStrData(Qid).sublb = subStr(1,4); % LB dist
    queryStrData(Qid).subub = subStr(1,5); % UB dist
    queryStrData(Qid).subcntsubtraj = numSubTraj;
    queryStrData(Qid).subcntlb = cntLB;
    queryStrData(Qid).subcntub = cntUB;
    queryStrData(Qid).subcntfdp = cntFDP;
    queryStrData(Qid).subcntcfd = cntCFD;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = maxc + size(Q,1);
    queryStrData(Qid).subnumoperations = totCell;
    
end