% Insert traj Q into CCT

function [numCFD, numDP, newntID] = SubTrajInsCCT(PSimp,P,insType,ntID,err)

    global trajStrData queryStrData
    global numInsCFD numInsDP

    % create query record
    szQ = size(queryStrData,2); % size inital query traj
    Qid = szQ + 1;
    queryStrData(Qid).traj = PSimp;
    queryStrData(Qid).ustraj = P;
    PreprocessQuery(Qid);

    % append the inserted traj to trajStrData
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
    queryStrData(Qid) = [];

end