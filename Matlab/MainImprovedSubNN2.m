% Function: MainImprovedSubNN2
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

function MainImprovedSubNN2(Qid,level,C,la,typeQ,eVal)

    switch nargin
    case 3
        la = 0;
        typeQ = 1;
        eVal = 0;
    end

    global queryStrData inpTrajSz inpTrajErr decimalPrecision

    tSearch = tic;

    timeSearch = 0; 
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
    
    for i = level:lb-1 % traverse the simplification tree one level at a time, start at level + 1
        
        thisLevel = i + 1;
        err = (2 * inpTrajErr(thisLevel)) + 0.0000001;  % metric ball error
        err2 = inpTrajErr(thisLevel) + 0.0000001;
        alpha = Inf;
        
        % get candidates for this level
        subStr2 = []; subTrajStr2 = [];
        [subStr2,subTrajStr2] = GetCandidatesHST(subStr,thisLevel-1,lb,la,Q); 
        subStr = subStr2;
        subTrajStr = subTrajStr2;

%         if thisLevel == lb
%             alpha = Inf;
%         else
%             [alpha,numCellCheck] = GetAlphaHST(subStr,thisLevel,Q);
%             totCell = totCell + numCellCheck;
%         end
        
        % for each candidate, compute CF and set alpha to smallest
        for j = 1:size(subStr,1) 
            c = subTrajStr(j).traj;
            if size(c,1) > maxc
                maxc = size(c,1);
            end
            
%             % method 1. uses LB and optionally FDP, then calls CFD at each level
%             if alpha == Inf
%                 ans = 1;
%             else
%                 subStr(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
%                 cntLB = cntLB + 1;
%                 if subStr(j,4) > alpha + err
%                     ans = 0;
%                 else
%                     ans = 1;
% %                     ans = FrechetDecide(c,Q,alpha + err,0,0,1,0,0);   % do boundary cut code, not Bringmann code
% %                     cntFDP = cntFDP + 1;
%                 end
%             end
%             if ans == 1 % compute cont Frechet dist
% %                 cfDist = ContFrechet(c,Q); % compute continuous Frechet distance
%                 cfDist = ContFrechetPrecision(c,Q,decimalPrecision,0); % do boundary cut code, not run Bringmann code
%                 cntCFD = cntCFD + 1;
%                 subStr(j,4) = cfDist;
%                 subStr(j,5) = cfDist;
%                 if cfDist < alpha
%                     alpha = cfDist;
%                 end
%             end
%             if ans == 0 % mark candidate to discard
%                 subStr(j,4) = Inf; 
%                 subStr(j,5) = Inf;
%             end
            
%             % method 2. uses LB/UB on all levels, and then FDP and CFD at leaf level
%             subStr(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
%             totCell = totCell + (size(c,1) + size(Q,1))*2;
%             cntLB = cntLB + 1;
%             if subStr(j,4) > alpha + err
%                 ans = 0;
%             else
%                 ans = 1;
%             end
%             if ans == 1 && thisLevel < lb
%                 subStr(j,5) = GetBestUpperBound(c,Q,3,Qid,0,subStr(j,4),0);
%                 totCell = totCell + (size(c,1) + size(Q,1))*4;
%                 cntUB = cntUB + 1;
%                 if subStr(j,5) < alpha
%                     alpha = subStr(j,5);
%                 end
%             end
%             if ans == 1 && thisLevel == lb
%                 [ans,numCell] = FrechetDecide(c,Q,alpha,0,0,1,0,0);   % do boundary cut code, not Bringmann code
%                 totCell = totCell + numCell;
%                 cntFDP = cntFDP + 1;
%             end
%             if ans == 1 && thisLevel == lb % leaf level, compute cont Frechet dist
%                 [cfDist,numCell] = ContFrechetPrecision(c,Q,decimalPrecision,0); % do boundary cut code, not run Bringmann code
%                 totCell = totCell + numCell;
%                 cntCFD = cntCFD + 1;
%                 subStr(j,4) = cfDist;
%                 subStr(j,5) = cfDist;
%                 if cfDist < alpha
%                     alpha = cfDist;
%                 end
%             end
%             if ans == 0 % mark candidate to discard
%                 subStr(j,4) = Inf; 
%                 subStr(j,5) = Inf;
%             end
            
            % method 3. uses CFD' distance and LB on parent levels, CFD'
            % distance and result reporting on leaf level
            ans = 1;
            if thisLevel < lb
                subStr(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
                totCell = totCell + (size(c,1) + size(Q,1))*2;
                cntLB = cntLB + 1;
                if subStr(j,4) > alpha + err
                    ans = 0;
                else
                    ans = 1;
                end
            end
            if ans == 1 && thisLevel < lb
                subStr(j,5) = GetBestUpperBound(c,Q,3,Qid,0,subStr(j,4),0);
                totCell = totCell + (size(c,1) + size(Q,1))*4;
                cntUB = cntUB + 1;
                if subStr(j,5) < alpha
                    alpha = subStr(j,5);
                end
            end
            if ans == 0 % mark candidate to discard
                subStr(j,4) = Inf; 
                subStr(j,5) = Inf;
            end
            
        end
        
        if thisLevel < lb
            % for each candidate, discard if alpha + 2*r(l) < CF(c,Q)
            numSubTraj = [numSubTraj; size(subStr,1) 0 0];
            for j = 1:size(subStr,1)
                if alpha + err < subStr(j,4)
                    subStr(j,6) = 1;  % mark to discard this sub-traj
                end
            end
            numSubTraj(end,2) = sum(subStr(:,6)); % count number of candidates to discard
            subStr = subStr(subStr(:,6)==0,:);  % discard candidates sub-traj that are too far
            subStr = sortrows(subStr,[4 3],{'ascend' 'descend'}); % sort by smallest LB dist then by largest sub-traj size

            % error checking
            if size(subStr,1) == 0 
                error('NN Result set is empty');
            end

            % additive/multiplicative query error logic
            smallestLB = max(subStr(1,4) - err, 0);  % use the LB
            if typeQ == 1 % additive error
                eAdd = eVal;
            else
                eAdd = eVal * smallestLB;
            end
            if subStr(1,5) <= smallestLB + eAdd % we found a candidate within query error
                break
            end
            
        end
        
        if thisLevel == lb % at leaf, do a final sub-traj cont frechet dist call to get final result
            [alpha,numCellCheck,z,zRev] = GetAlphaHST(subStr,thisLevel,Q);
            totCell = totCell + numCellCheck;
            subStr = [0 0 0 0 0 0 0 0 0];
            subStr(1,8) = zRev(1,2); % start vertex
            subStr(1,9) = z(1,2); % end vertex
            subStr(1,4) = alpha; % LB dist
            subStr(1,5) = alpha; % UB dist
        end
        
%         % greedily try and get a smaller alpha - but only if at least one
%         % candidate has the property: err < subStr(j,4)
%         numProp = sum(subStr(:,4) > err);
%         if thisLevel < lb && numProp > 0
%             [newAlpha,cntCFDg,cntFDPg,cntLBg,cntUBg] = GreedySubNN(Qid,thisLevel,[subStr(1,1) subStr(1,2)],la);  % use sub-traj with smallest UB
%             cntCFD = cntCFD + cntCFDg;
%             cntFDP = cntFDP + cntFDPg;
%             cntLB = cntLB + cntLBg;
%             cntUB = cntUB + cntUBg;
%             if newAlpha < alpha
%                 for j = 1:size(subStr,1)
%                     if newAlpha + err < subStr(j,4)
%                         subStr(j,6) = 1;  % mark to discard this sub-traj
%                     end
%                 end
%                 numSubTraj(end,3) = sum(subStr(:,6)); % count number of candidates to discard
%                 subStr = subStr(subStr(:,6)==0,:);  % discard candidates sub-traj that are too far
%             end
%         end



    end

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
    queryStrData(Qid).subnumoperations = round(totCell / size(inP,1),2);
    
end