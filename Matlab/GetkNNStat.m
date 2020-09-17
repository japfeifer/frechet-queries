% Get kNN stats for graphing
% 
function GetkNNStat(Qid,kNum)

    global searchStat s1Stat s2Stat resStat tmpCCT queryTraj clusterNode

    searchStat = []; s1Stat = []; s2Stat = []; resStat = [];

    kNN(Qid,1,kNum,0); % exact kNN query

    % create tmpCCT, append column, if value = 1 then leaf was searched
    tmpCCT = clusterNode;
    tmpCCT = [tmpCCT zeros(size(tmpCCT,1),1)]; % append a column of zeros at the end
    for i=1:size(searchStat,2) % update node id's that were searched
        tmpCCT(searchStat(i),8) = 1;
    end

    % create s1Stat
    s1Stat = cell2mat(queryTraj(Qid,8));
    s1Stat = s1Stat(:,1);
    s1Stat = s1Stat';
    for i=1:size(s1Stat,2) % convert node id to traj id
        trajID = tmpCCT(s1Stat(i),6);
        s1Stat(i) = trajID; 
    end

    % create s2Stat
    s2Stat = cell2mat(queryTraj(Qid,7));
    s2Stat = s2Stat(:,1);
    s2Stat = s2Stat';

    % create resStat
    resStat = cell2mat(queryTraj(Qid,12));
    resStat = resStat(:,1);
    resStat = resStat';
end
