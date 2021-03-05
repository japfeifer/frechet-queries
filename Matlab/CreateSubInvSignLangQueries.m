% function CreateSubInvSignLangQueries
%
% Creates queries that contain more than one sign language word, represented
% as trajectories.

function CreateSubInvSignLangQueries(minWords,maxWords)

    global queryStrData querySet

    switch nargin
    case 0
        minWords = 5;
        maxWords = 20;
    end

    queryStrData2 = queryStrData;
    queryStrData = [];
    querySet2 = querySet;
    cnt = 0;
    
    % continue to create queries (with multiple word trajectories) until queryStrData2 is empty
    while 1==1
        sz = size(queryStrData2,2);
        numWords = randi([minWords,maxWords]); % random number of words for this traj
        if sz <= numWords || sz <= maxWords % this is last traj to create
            numWords = sz;
        end
        k = randperm(sz,numWords); % randomly choose traj
        P = [];
        queryset = [];
        for i = 1:size(k,2) % for each randomly chosen traj
            P = [P; queryStrData2(k(i)).traj];
            queryset(end+1,1:4) = [cell2mat(querySet2(k(i),1:2)) size(P,1) - size(queryStrData2(k(i)).traj,1) + 1 size(P,1)];
        end
        cnt = cnt + 1;
        queryStrData(cnt).traj = P;
        queryStrData(cnt).se = [P(1,:); P(end,:)];
        queryStrData(cnt).queryset = queryset;
        PreprocessQuery(cnt); % generate other query info
        
        queryStrData2(k) = []; % delete randomly chosen traj
        querySet2(k,:) = [];
        
        if size(queryStrData2,2) == 0 % we are done
            break
        end
    end

end