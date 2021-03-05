% function  SubInvSignLang
%
% Predicts sign language words in large query traj
% 
% Inputs
% tau: RNN range length
% queryset(in queryStrData): compMoveID, wordID, startVert, endVert
%
% Outputs (in queryStrData)
% ansset: trajID, wordID, startVert, endVert, dist
% ans: list of predicted word IDs


function SubInvSignLang(tau)

    global queryStrData trainSet

    switch nargin
    case 0
        tau = 0.25;
    end
    
    for i = 1:1
        SubInvRNN(i,tau); % perform range query
        sz = size(queryStrData(i).decidetrajids,1);
        wordIDs(sz,1) = 0;
        for j = 1:sz
            wordIDs(j,1) = cell2mat(trainSet(queryStrData(i).decidetrajids(j,1),2));
        end
        ansset = [];
        ansset = [queryStrData(i).decidetrajids wordIDs queryStrData(i).sub3svert queryStrData(i).sub3evert queryStrData(i).sub3ub];
        ansset = sortrows(ansset,[5]); % sort by dist
        
        ans = [];
        queryStrData(i).ansset = ansset;
        queryStrData(i).ans = ans;
    end

end