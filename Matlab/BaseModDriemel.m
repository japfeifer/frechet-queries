% Function: BaseSubNN
%
% Perform an approximate Vertex-Aligned NN sub-trajectory on query Qid using a
% modification of Driemel et al's original algorithm.
% 
% Inputs:
% Qid: query ID
%
% Outputs:
% queryStrData - various query results stored here

function BaseModDriemel(Qid,typeQ,eVal)

    global queryStrData inP decimalPrecision

    tSearch = tic;
    timeSearch = 0;
    totCnt = 0;
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    
    reachP = TrajReach(inP);
    reachQ = TrajReach(Q);
    err = max(reachP,reachQ); % set error to max reach of P & Q
    
    while 1 == 1
        simpP = LinearSimp(inP,err); % Driemel simplification
        simpQ = LinearSimp(Q,err); % Driemel simplification
        [alpha,cnt] = SubContFrechetAltVA(simpP,simpQ,decimalPrecision);         % get sub-traj distance, using Baseline 1 Algo
%         [alpha,cnt] = SubContFrechetFastVA(simpP,simpQ,decimalPrecision);  % get sub-traj distance, using Algo 1 - heuristic Baseline 1
        totCnt = totCnt + cnt;
        if eVal > 0 && alpha - err > 0 % we have additive or multiplicative error. Check if we can stop
            ls = alpha + err; 
            rs = alpha - err;
            if typeQ == 2 && ls/rs <= eVal  % multiplicative error
                break
            elseif typeQ == 1 && ls-rs <= eVal % additive error
                break
            end 
        end
        % we cannot stop yet, halven error
        err = err/2;
    end

    timeSearch = toc(tSearch);

    % store results

    queryStrData(Qid).sublb = alpha - err;
    queryStrData(Qid).subub = alpha + err;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = size(inP,1) * size(Q,1);
    queryStrData(Qid).subnumoperations = round(totCnt / size(inP,1),2);
    
end