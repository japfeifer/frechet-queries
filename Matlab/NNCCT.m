% returns traj id of nearest-neighbor to Q

function [trajId, numCFD, numDP] = NNCCT(Q,typeQ,eVal)

    global queryTraj linLBcnt linUBcnt conLBcnt timeConstLB timeLinLB timeLinUB
    
    % create query record
    szQ = size(queryTraj,1); % size inital query traj
    Qid = szQ + 1;
    queryTraj(Qid,1) = mat2cell(Q,size(Q,1),size(Q,2));
    PreprocessQuery(Qid);
    
    % call NN funtion
    linLBcnt = 0; linUBcnt = 0; conLBcnt = 0; timeConstLB = 0; timeLinLB = 0; timeLinUB = 0;
    NN(Qid,typeQ,eVal);
    
    % set return values
    trajId = cell2mat(queryTraj(Qid,12));
    numCFD = cell2mat(queryTraj(Qid,10));
    numDP = cell2mat(queryTraj(Qid,11));
    
    % remove query record
    queryTraj(Qid,:) = [];

end