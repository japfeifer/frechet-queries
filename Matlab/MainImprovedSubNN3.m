% Function: MainImprovedSubNN3
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

function MainImprovedSubNN3(Qid,level,C,la,typeQ,eVal)

    switch nargin
    case 3
        la = 0;
        typeQ = 1;
        eVal = 0;
    end

    global queryStrData inpTrajSz inpTrajErr inP

    tSearch = tic;

    timeSearch = 0; 
    cntCFD = 0;
    cntFDP = 0;
    cntLB = 0;
    cntUB = 0;
    numSubTraj = [];
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
    lenQ = queryStrData(Qid).len;
    stopVal = ceil(log2(size(inP,1))^3);
    
    for i = level:lb-1 % traverse the simplification tree one level at a time, start at level + 1
        
        thisLevel = i + 1;
        err = (2 * inpTrajErr(thisLevel)) + 0.0000001;  % metric ball error
        alpha = Inf;
        
        % get candidates for this level
        subStr2 = []; 
        subStr2 = GetCandidatesHST2(subStr,thisLevel-1,lb); 
        subStr = subStr2;
        totCell = totCell + size(subStr,1);

        if size(subStr,1) > stopVal || thisLevel == lb % stop checking HST levels if |C| > |P|, or at leaf level
            break
        end

        % for each candidate, compute UB/LB
        for j = 1:size(subStr,1) 
            if subStr(j,3) > maxc
                maxc = subStr(j,3);
            end
            subStr(j,4) = GetBringDistHST(subStr(j,1),subStr(j,2),Q,lenQ,thisLevel,0); % get Bringmann LB
            totCell = totCell + 1;
            cntLB = cntLB + 1;
            if subStr(j,4) <= alpha + err % can not discard, so check for and UB dist
                subStr(j,5) = GetBringDistHST(subStr(j,1),subStr(j,2),Q,lenQ,thisLevel,1); % get Bringmann UB
                if subStr(j,5) < alpha
                    alpha = subStr(j,5);
                end
            end
        end
        totCell = totCell + size(subStr,1);
        
        % for each candidate, discard if alpha + 2*r(l) < CF(c,Q)
        numSubTraj = [numSubTraj; size(subStr,1) 0 0];
        for j = 1:size(subStr,1)
            if alpha + err < subStr(j,4)
                subStr(j,6) = 1;  % mark to discard this sub-traj
            else % do the stronger linear runtime LB
                c = GetSimpP(subStr(j,1),subStr(j,2),thisLevel-1,lb);
                subStr(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
                totCell = totCell + (size(c,1) + size(Q,1))*2;
                cntLB = cntLB + 1;
                if alpha + err < subStr(j,4)
                    subStr(j,6) = 1;  % mark to discard this sub-traj
                end
            end
        end
        totCell = totCell + size(subStr,1);
        numSubTraj(end,2) = sum(subStr(:,6)); % count number of candidates to discard
        subStr = subStr(subStr(:,6)==0,:);  % discard candidate sub-traj that are too far

        % error checking
        if size(subStr,1) == 0 
            error('NN Result set is empty');
        end
    end
    
    % do sub-traj cont frechet dist call to get final result
%     [alpha,numCellCheck,subStart,subEnd] = GetSubTrajNNVA2(subStr,thisLevel,Q,lb); % this version just does one sub-traj CFD check
    [alpha,numCellCheck,subStart,subEnd,maxc] = GetSubTrajNNVA(subStr,thisLevel,Q,lb,typeQ,eVal,maxc,lenQ);
    totCell = totCell + numCellCheck;

    timeSearch = toc(tSearch);

    % store results
    queryStrData(Qid).subsvert = subStart; % start vertex
    queryStrData(Qid).subevert = subEnd; % end vertex
    queryStrData(Qid).sublb = alpha; % LB dist
    queryStrData(Qid).subub = alpha; % UB dist
    queryStrData(Qid).subcntsubtraj = numSubTraj;
    queryStrData(Qid).subcntlb = cntLB;
    queryStrData(Qid).subcntub = cntUB;
    queryStrData(Qid).subcntfdp = cntFDP;
    queryStrData(Qid).subcntcfd = cntCFD;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = maxc;
    queryStrData(Qid).subnumoperations = round(totCell / size(inP,1),2);
    
end