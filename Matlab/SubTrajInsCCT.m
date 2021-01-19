% Insert traj Q into CCT

function [numCFD, numDP, newntID] = SubTrajInsCCT(PSimp,P,insType,ntID,err)

%     global trajData queryTraj
    global trajStrData queryStrData
    global numInsCFD numInsDP

    % create query record
%     szQ = size(queryTraj,1); % size inital query traj
    szQ = size(queryStrData,2); % size inital query traj
    Qid = szQ + 1;
%     queryTraj(Qid,1) = mat2cell(PSimp,size(PSimp,1),size(PSimp,2));
    queryStrData(Qid).traj = PSimp;
    queryStrData(Qid).ustraj = P;
    PreprocessQuery(Qid);

    % append the inserted traj to trajData
%     szT = size(trajData,1);
%     if size(trajData,2) == 1 % it is empty
%         szT = 0;
%     end
%     trajData(szT+1,1:2) = queryTraj(Qid,1:2);
%     trajData(szT+1,3:7) = queryTraj(Qid,20:24);
%     trajData(szT+1,7) = mat2cell(P,size(P,1),size(P,2));
    
    trajStrData(ntID).traj = queryStrData(Qid).traj;
    trajStrData(ntID).se = queryStrData(Qid).se;
    trajStrData(ntID).bb1 = queryStrData(Qid).bb1;
    trajStrData(ntID).bb2 = queryStrData(Qid).bb2;
    trajStrData(ntID).bb3 = queryStrData(Qid).bb3;
    trajStrData(ntID).st = queryStrData(Qid).st;
    trajStrData(ntID).ustraj = P;
    
    % insert into the CCT
    numInsCFD = 0;
    numInsDP = 0;
    newntID = InsertCCT(Qid,ntID,insType,0,1,err);

    % set return values
    numCFD = numInsCFD;
    numDP = numInsDP;
    
    % remove query record
%     queryTraj(Qid,:) = [];
    queryStrData(Qid) = [];

end