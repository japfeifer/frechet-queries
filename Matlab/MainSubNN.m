% Function: MainSubNN
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

function MainSubNN(Qid,level,C,graphFlg)

    switch nargin
    case 3
        graphFlg = 0;
    end

    global queryStrData inpTrajSz inpTrajErr decimalPrecision inP

    tSearch = tic;

    timeSearch = 0; 
    cntCFD = 0;
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
    
    if graphFlg == 1
        GraphSubNN(Qid,level,1,subStr);
    end
    
    for i = level:lb-1 % traverse the simplification tree one level at a time, start at level + 1
        
        thisLevel = i + 1;
        err = (2 * inpTrajErr(thisLevel)) + 0.0000001;  % metric ball error
        
        % get candidates for this level
        [subStr,subTrajStr] = GetCandidatesHST(subStr,thisLevel-1,lb); 
        
        % for each candidate, compute CF and set alpha to smallest
        alpha = Inf;
        for j = 1:size(subStr,1) 
            c = subTrajStr(j).traj;
            if size(c,1) > maxc
                maxc = size(c,1);
            end
            % run boundary cut code (results are vertex-aligned since just a regular frechet dist computation), do not run Bringmann code
            [cfDist,numCell] = ContFrechetPrecision(c,Q,decimalPrecision,0); 
            totCell = totCell + numCell;
            cntCFD = cntCFD + 1;
            subStr(j,4) = cfDist;
            subStr(j,5) = cfDist;
            if cfDist < alpha
                alpha = cfDist;
            end
        end
        
        % for each candidate, discard if alpha + 2*r(l) < CF(c,Q)
        numSubTraj = [numSubTraj; size(subStr,1) 0];
        for j = 1:size(subStr,1)
            if alpha + err < subStr(j,4)
                subStr(j,6) = 1;  % mark to discard this sub-traj
            end
        end
        
        if graphFlg == 1
            GraphSubNN(Qid,thisLevel,2,subStr);
        end
        
        numSubTraj(end,2) = sum(subStr(:,6)); % count number of candidates to discard
        subStr = subStr(subStr(:,6)==0,:);  % discard candidates sub-traj that are too far
        
        % error checking
        if size(subStr,1) == 0 
            error('Result set is empty');
        end

    end

    % get the inclusion maximal candidate
    if size(subStr,1) > 1 
        subStr = sortrows(subStr,[4 3],{'ascend' 'descend'}); % sort by smallest LB dist then by largest sub-traj size
    end
    candTrajSet = 1;
    
    timeSearch = toc(tSearch);

    % store results
    queryStrData(Qid).subsvert = subStr(candTrajSet,8); % start vertex
    queryStrData(Qid).subevert = subStr(candTrajSet,9); % end vertex
    queryStrData(Qid).sublb = subStr(candTrajSet,4); % LB dist
    queryStrData(Qid).subub = subStr(candTrajSet,5); % UB dist
    queryStrData(Qid).subcntsubtraj = numSubTraj;
    queryStrData(Qid).subcntlb = 0;
    queryStrData(Qid).subcntub = 0;
    queryStrData(Qid).subcntfdp = 0;
    queryStrData(Qid).subcntcfd = cntCFD;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = maxc + size(Q,1);
    queryStrData(Qid).subnumoperations = round(totCell / size(inP,1),2);
    
    if graphFlg == 1
        GraphSubNN(Qid,lb,3,subStr);
    end
    
end