% Query data preprocessing
% calc bounding boxes
% calc simplification prune
% calc padding

function PreprocessQuery(Qid)

    global queryTraj
    
    Q = cell2mat(queryTraj(Qid,1));
    
    % query start/end vertices
    SE = [Q(1,:); Q(end,:)];
    queryTraj(Qid,2) = mat2cell(SE,size(SE,1),size(SE,2));
    
    % calc bounding boxes
    sPDim = size(Q,2);
    BB = ComputeBB(Q,0);
    queryTraj(Qid,20) = mat2cell(BB,size(BB,1),size(BB,2));
    if (sPDim == 2 || sPDim == 3)  % only compute BB for 2-d and 3-d traj
        BB = ComputeBB(Q,22.5);
        queryTraj(Qid,21) = mat2cell(BB,size(BB,1),size(BB,2));
        BB = ComputeBB(Q,45);
        queryTraj(Qid,22) = mat2cell(BB,size(BB,1),size(BB,2));
    end

    % calc simplification prune
    QPrime = [Q(1,:); Q(end,:)]; % Q'
    Eq = ContFrechet(Q,QPrime,1,0);
    queryTraj(Qid,23) = mat2cell(Eq,size(Eq,1),size(Eq,2));

    % calc padding
    padQ = PadTraj(Q,2);
    queryTraj(Qid,24) = mat2cell(padQ,size(padQ,1),size(padQ,2));
    
end
