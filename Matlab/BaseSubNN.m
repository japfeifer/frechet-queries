% Function: BaseSubNN
%
% Perform a Vertex-Aligned NN sub-trajectory on query Qid using a
% modification of Alt and Godau's original algorithm.
% 
% Inputs:
% Qid: query ID
%
% Outputs:
% queryStrData - various query results stored here

function BaseSubNN(Qid)

    global queryStrData inP decimalPrecision

    tSearch = tic;
    timeSearch = 0; 
    Q = queryStrData(Qid).traj; % query trajectory vertices and coordinates
    [dist,cnt] = SubContFrechetAltVA(inP,Q,decimalPrecision);
    
    timeSearch = toc(tSearch);

    % store results

    queryStrData(Qid).sublb = dist;
    queryStrData(Qid).subub = dist;
    queryStrData(Qid).subsearchtime = timeSearch;
    queryStrData(Qid).submemorysz = size(inP,1) * size(Q,1);
    queryStrData(Qid).subnumoperations = round(size(Q,1) * cnt,2);
    
end