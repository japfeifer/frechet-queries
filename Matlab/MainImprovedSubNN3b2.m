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

function MainImprovedSubNN3b2(Qid,level,C,la,typeQ,eVal,stopVal)

    switch nargin
    case 3
        la = 0;
        typeQ = 1;
        eVal = 0;
        stopVal = 10000000;
    case 6
        stopVal = 10000000;
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
    foundApproxRes = 0;
    
    % initial level setup of sub-traj info
    subStr = [];
    for j = 1:size(C,1) % for each sub-traj
        subStr(j,1) = C(j,1);                              % start idx
        subStr(j,2) = C(j,2);                              % end idx
        subStr(j,3) = subStr(j,2) - subStr(j,1) + 1;       % num vertices
        subStr(j,4) = 0;                                   % lower bound dist
        subStr(j,5) = Inf;                                 % upper bound dist
        subStr(j,6) = 0;                                   % too far flag
        subStr(j,7) = 0;                                   % within range flag
        subStr(j,8) = 0;                                   % start vertex id
        subStr(j,9) = 0;                                   % end vertex id
        subStr(j,10) = level;                              % level
        subStr(j,11) = 0;                                  % error
        subStr(j,12) = 0;                                  % LB
        subStr(j,13) = Inf;                                % UB
    end
 
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    lb = size(inpTrajSz,2); % the leaf level for the simplification tree
    lenQ = queryStrData(Qid).len;
    alpha = Inf;
    alphaErr = Inf;
    numCheck = 0;
    subStr3 = []; 
    
    time1 = 0;
    time2 = 0;
    time3 = 0;
    time4 = 0;
    time5 = 0;
    time6 = 0;
    t1 = tic;
    
    while 1 == 1
        subStr = sortrows(subStr,12,'ascend'); % smallest LB first
%         subStr = sortrows(subStr,13,'ascend'); % smallest UB first
%         subStr = subStr(randperm(size(subStr, 1)), :);  % random candidate first
%         for j = 1:size(subStr,1) 
%             subStr(j,14) = (subStr(j,12) + subStr(j,13)) / 2;
%         end
%         subStr = sortrows(subStr,14,'ascend'); % smallest average fo LB & UB
%         subStr = subStr(:,1:13);

        i = 1;
%         if subStr(i,10) + 1 < lb % not expanding to leaf level
        if subStr(i,10) < lb % can expand to leaf level
        
            % get next level candidates for smallest LB candidate
            t2 = tic;
            subStr2 = []; 
            subStr2 = GetCandidatesHST3(subStr(i,:),subStr(i,10),lb); 
            totCell = totCell + size(subStr2,1);
            time2 = time2 + toc(t2);

            thisLevel = subStr(i,10) + 1; 
            
%             for j = 1:size(subStr2,1) % put any leaf level candidates into subStr3
%                 if subStr2(j,10) == lb
%                     subStr3(end+1,:) = subStr2(j,:);
%                     subStr2(j,6) = 1;
%                 end
%             end
%             subStr2 = subStr2(subStr2(:,6)==0,:); 

            % for each candidate, compute UB/LB
            t3 = tic;
            for j = 1:size(subStr2,1) 
                numCheck = numCheck + 1;
                if subStr2(j,3) > maxc
                    maxc = subStr2(j,3);
                end
                subStr2(j,4) = GetBringDistHST(subStr2(j,1),subStr2(j,2),Q,lenQ,subStr2(j,10),0); % get Bringmann LB
                subStr2(j,12) = subStr2(j,4) - subStr2(j,11);
                totCell = totCell + 1;
                cntLB = cntLB + 1;
                if subStr2(j,12) <= alpha % can not discard, so check for an UB dist
                    subStr2(j,5) = GetBringDistHST(subStr2(j,1),subStr2(j,2),Q,lenQ,subStr2(j,10),1); % get Bringmann UB
                    subStr2(j,13) = subStr2(j,5) + subStr2(j,11);
                    if subStr2(j,13) < alpha
                        alpha = subStr2(j,13);
                        alphaErr = subStr2(j,11);
                        
                        if eVal > 0 && alpha - alphaErr > 0 % we have additive or multiplicative error. Check if we can stop
                            ls = alpha + alphaErr; 
                            rs = alpha - alphaErr;
                            if typeQ == 2 && ls/rs <= eVal  % multiplicative error
                                foundApproxRes = 1;
                                approxIdx = j;
                                break
                            elseif typeQ == 1 && ls-rs <= eVal % additive error
                                foundApproxRes = 1;
                                approxIdx = j;
                                break
                            end 
                        end
                    end
                else
                    subStr2(j,13) = Inf;
                end
            end
            totCell = totCell + size(subStr2,1);
            time3 = time3 + toc(t3);

            if foundApproxRes == 1
                break
            end

            t4 = tic;
            for j = 1:size(subStr2,1)
                if alpha < subStr2(j,12)
                    subStr2(j,6) = 1;  % mark to discard this sub-traj
                else % do the stronger linear runtime LB
                    c = GetSimpP(subStr2(j,1),subStr2(j,2),subStr2(j,10)-1,lb);
                    subStr2(j,4) = GetBestConstLB(c,Q,Inf,3,Qid,0,1);  % get the LB
                    subStr2(j,12) = subStr2(j,4) - subStr2(j,11);
                    totCell = totCell + (size(c,1) + size(Q,1))*2;
                    cntLB = cntLB + 1;
                    if alpha < subStr2(j,12)
                        subStr2(j,6) = 1;  % mark to discard this sub-traj
                    end
                end
            end
            totCell = totCell + size(subStr2,1);
            time4 = time4 + toc(t4);

            for j = 1:size(subStr,1)
                if j == i || alpha < subStr(j,12)
                    subStr(j,6) = 1;  % mark to discard this sub-traj
                end
            end

            % discard candidate sub-traj that are too far, then union sets
            t5 = tic;
            subStr = subStr(subStr(:,6)==0,:); 
            subStr2 = subStr2(subStr2(:,6)==0,:); 
            subStr = [subStr2; subStr];
            subStr = unique(subStr,'rows'); % remove any duplicate sub-trajectories
            time5 = time5 + toc(t5);
            
        else  % expanding to leaf level
            t6 = tic;
            subStr3(end+1,:) = subStr(i,:);
            subStr(i,:) = [];
            time6 = time6 + toc(t6);
        end

        if numCheck > stopVal || size(subStr,1) == 0 % stop checking HST levels if |C| > |P|, or no more candidates
            break
        end
        
    end
    
    time1 = time1 + toc(t1);
    
    subStr3 = unique(subStr3,'rows'); % remove any duplicate sub-trajectories
    
    if foundApproxRes == 1 % we found an approx result
        subStart = subStr(approxIdx,1);
        subEnd = subStr(approxIdx,2);
    else
        % do sub-traj cont frechet dist call to get final result
    %     [alpha,numCellCheck,subStart,subEnd] = GetSubTrajNNVA2(subStr,thisLevel,Q,lb); % this version just does one sub-traj CFD check
        [alpha,numCellCheck,subStart,subEnd,maxc] = GetSubTrajNNVA(subStr,thisLevel,Q,lb,typeQ,eVal,maxc,lenQ,Qid);
        totCell = totCell + numCellCheck;
    end

    timeSearch = toc(tSearch);

    % store results
    queryStrData(Qid).subsvert = subStart; % start vertex
    queryStrData(Qid).subevert = subEnd; % end vertex
    queryStrData(Qid).sublb = alpha; % LB dist
    queryStrData(Qid).subub = alpha; % UB dist
    queryStrData(Qid).subcntsubtraj = numCheck;
    queryStrData(Qid).subcntlb = cntLB;
    queryStrData(Qid).subcntub = cntUB;
    queryStrData(Qid).subcntfdp = cntFDP;
    queryStrData(Qid).subcntcfd = cntCFD;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = maxc;
    queryStrData(Qid).subnumoperations = round(totCell / size(inP,1),2);
    
end