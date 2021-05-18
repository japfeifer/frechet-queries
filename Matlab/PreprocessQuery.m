% Query data preprocessing
% calc bounding boxes
% calc simplification prune
% calc padding

function PreprocessQuery(Qid)

    global queryStrData
    
    Q = queryStrData(Qid).traj;
    
    % query start/end vertices
    SE = [Q(1,:); Q(end,:)];
    queryStrData(Qid).se = SE;
    
    % calc bounding boxes
    sPDim = size(Q,2);
    BB = ComputeBB(Q,0);
    queryStrData(Qid).bb1 = BB;
    if (sPDim == 2 || sPDim == 3)  % only compute BB for 2-d and 3-d traj
        BB = ComputeBB(Q,22.5);
        queryStrData(Qid).bb2 = BB;
        BB = ComputeBB(Q,45);
        queryStrData(Qid).bb3 = BB;
    end

    % calc simplification prune
    QPrime = [Q(1,:); Q(end,:)]; % Q'
    Eq = ContFrechet(Q,QPrime,2,0);
    queryStrData(Qid).st = Eq;
    
    % calc segment lengths
    queryStrData(Qid).len = GetSegLen(Q);

%     % calc padding
%     padQ = PadTraj(Q,2);
%     queryTraj(Qid,24) = mat2cell(padQ,size(padQ,1),size(padQ,2));
    
end
