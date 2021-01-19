% This function compares the LB and UB computations

function CalcLBUBTest(k,P,Q,cType,id1,id2)

    global trajData queryTraj
    
    switch nargin
    case 3
        cType = 0;
        id1 = 0;
        id2 = 0;
    end

    lowBound = 0;
    dimSize = size(P,2);
    
    % get the exact continuous Fréchet distance
    currFrechetDist = ContFrechet(P,Q);
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% get Lower bounds
    %%%%%%%%%%%%%%%%%%%%%%%%
    
    % start/end pos lower bound
    pStartEnd = [P(1,:) ; P(end,:)];
    qStartEnd = [Q(1,:) ; Q(end,:)];
    SEBnd = max(CalcPointDist(pStartEnd(1,:),qStartEnd(1,:)) , ...
                  CalcPointDist(pStartEnd(2,:),qStartEnd(2,:)));
    SEBnd = round(SEBnd,10)+0.00000000009;
    SEBnd = fix(SEBnd * 10^10)/10^10;

    % bounding box lower bound, don't shift curve
    BBnorotBnd = BoundBoxDist(P,Q,0,cType,id1,id2);
   
    % Bounding box shift curve counterclockwise 22.5 degrees from origin axis.
    if dimSize <= 3
        BB2Bnd = BoundBoxDist(P,Q,22.5,cType,id1,id2);
    else
        BB2Bnd = 0; 
    end
  
    % Bounding box shift curve counterclockwise 45 degrees from origin axis.
    if dimSize <= 3
        BB3Bnd = BoundBoxDist(P,Q,45,cType,id1,id2);
    else
        BB3Bnd = 0;
    end

    % simplified single edge lower bound
    % get distances to single edge
    if cType == 0
        simpP = [P(1,:); P(end,:)]; % P'
        simpQ = [Q(1,:); Q(end,:)]; % Q'
        distP = ContFrechet(P,simpP,2,0);
        distQ = ContFrechet(Q,simpQ,2,0);
    elseif cType == 1
        distP = cell2mat(trajData(id1,6));
        distQ = cell2mat(queryTraj(id2,23));
    elseif cType == 2
        distP = cell2mat(trajData(id1,6));
        distQ = cell2mat(trajData(id2,6));
    end
    SSEBnd = abs(distP - distQ)/2;
    SSEBnd = round(SSEBnd,10)+0.00000000009;
    SSEBnd = fix(SSEBnd * 10^10)/10^10;
    
    % calc best LB (SE, BB no rot, BB with rot, SSE)
    bestLB = max(SEBnd,max(BBnorotBnd,max(max(BBnorotBnd,max(BB2Bnd,BB3Bnd)),SSEBnd)));
    
    % get neg filter result - compare to best LB
    negFiltRes = TraversalRace(P,Q,bestLB);
    if negFiltRes == false
        negFiltRes = TraversalRace(Q,P,bestLB); % swap P & Q
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% get Upper bounds
    %%%%%%%%%%%%%%%%%%%%%%%%
    
    % get BB UB
    
    if cType == 0 % compute P & Q bounding boxes
        PBB = ComputeBB(P,0);
        QBB = ComputeBB(Q,0);
        if dimSize <=3
            PBB225 = ComputeBB(P,22.5);
            PBB45 = ComputeBB(P,45);
            QBB225 = ComputeBB(Q,22.5);
            QBB45 = ComputeBB(Q,45);
        end
    elseif cType == 1 || cType == 2 % the bounding box was pre-computed
        PBB = cell2mat(trajData(id1,3));
        if dimSize <=3
            PBB225 =cell2mat(trajData(id1,4));
            PBB45 = cell2mat(trajData(id1,5));
        end
        if cType == 1
            QBB = cell2mat(queryTraj(id2,20));
            if dimSize <=3
                QBB225 = cell2mat(queryTraj(id2,21));
                QBB45 = cell2mat(queryTraj(id2,22));
            end
        else
            QBB = cell2mat(trajData(id2,3));
            if dimSize <=3
                QBB225 = cell2mat(trajData(id2,4));
                QBB45 = cell2mat(trajData(id2,5));
            end
        end
    end
    
    if dimSize > 2 % do bounding box opposite corner distance

        % calc BB around both P and Q, and get distance from min coordinates to max coordinates
        bothBB0 = [min([PBB;QBB]) ; max([PBB;QBB])];
        upBound0 = CalcPointDist(bothBB0(1,:), bothBB0(2,:));
        
        if dimSize <=3
            bothBB225 = [min([PBB225;QBB225]) ; max([PBB225;QBB225])];
            upBound225 = CalcPointDist(bothBB225(1,:), bothBB225(2,:));
            bothBB45 = [min([PBB45;QBB45]) ; max([PBB45;QBB45])];
            upBound45 = CalcPointDist(bothBB45(1,:), bothBB45(2,:));
        else
            upBound225 = Inf; upBound45 = Inf;
        end
        
    else % dim size is 2, do pair-wise distance between corners of bounding boxes
        PCornerPoints = [PBB(1,1) PBB(1,2); PBB(1,1) PBB(2,2); PBB(2,1) PBB(1,2); PBB(2,1) PBB(2,2)];
        QCornerPoints = [QBB(1,1) QBB(1,2); QBB(1,1) QBB(2,2); QBB(2,1) QBB(1,2); QBB(2,1) QBB(2,2)];
        upBound0 = Get2DimBBUB(PCornerPoints,QCornerPoints);
        
        PCornerPoints = [PBB225(1,1) PBB225(1,2); PBB225(1,1) PBB225(2,2); PBB225(2,1) PBB225(1,2); PBB225(2,1) PBB225(2,2)];
        QCornerPoints = [QBB225(1,1) QBB225(1,2); QBB225(1,1) QBB225(2,2); QBB225(2,1) QBB225(1,2); QBB225(2,1) QBB225(2,2)];
        upBound225 = Get2DimBBUB(PCornerPoints,QCornerPoints);
        
        PCornerPoints = [PBB45(1,1) PBB45(1,2); PBB45(1,1) PBB45(2,2); PBB45(2,1) PBB45(1,2); PBB45(2,1) PBB45(2,2)];
        QCornerPoints = [QBB45(1,1) QBB45(1,2); QBB45(1,1) QBB45(2,2); QBB45(2,1) QBB45(1,2); QBB45(2,1) QBB45(2,2)];
        upBound45 = Get2DimBBUB(PCornerPoints,QCornerPoints);

    end
    
    ADFBound = ApproxDiscFrechet(P,Q);
    ADFRBound = ApproxDiscFrechetRev(P,Q);
    ADFDBound = ApproxDiscFrechetDiag(P,Q);
    
    bestUB = min(ADFDBound,min(ADFRBound,min(ADFBound,min(upBound45,min(upBound0,upBound225)))));
    
    % save results
    queryTraj(k,29) = num2cell(currFrechetDist);
    queryTraj(k,30) = num2cell(SEBnd);
    queryTraj(k,31) = num2cell(BBnorotBnd);
    queryTraj(k,32) = num2cell(BB2Bnd);
    queryTraj(k,33) = num2cell(BB3Bnd);
    queryTraj(k,34) = num2cell(SSEBnd);
    queryTraj(k,35) = num2cell(negFiltRes);
    queryTraj(k,36) = num2cell(SEBnd == bestLB);
    queryTraj(k,37) = num2cell(BBnorotBnd == bestLB);
    queryTraj(k,38) = num2cell(BB2Bnd == bestLB);
    queryTraj(k,39) = num2cell(BB3Bnd == bestLB);
    queryTraj(k,40) = num2cell(SSEBnd == bestLB);
    queryTraj(k,41) = num2cell(upBound0);
    queryTraj(k,42) = num2cell(upBound225);
    queryTraj(k,43) = num2cell(upBound45);
    queryTraj(k,44) = num2cell(ADFBound);
    queryTraj(k,45) = num2cell(ADFRBound);
    queryTraj(k,46) = num2cell(ADFDBound);
    queryTraj(k,47) = num2cell(upBound0 == bestUB);
    queryTraj(k,48) = num2cell(upBound225 == bestUB);
    queryTraj(k,49) = num2cell(upBound45 == bestUB);
    queryTraj(k,50) = num2cell(ADFBound == bestUB);
    queryTraj(k,51) = num2cell(ADFRBound == bestUB);
    queryTraj(k,52) = num2cell(ADFDBound == bestUB);
    
end