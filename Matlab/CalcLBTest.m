% This function calcs a series of fast (constant, linear, or nlogn) lower 
% bounds between two trajectories.
% if cType = 0, then don't use ids
% if cType = 1, then id1 = traj id and id2 = query id
% if cType = 2, then id1 = traj id and id2 = traj id

function CalcLBTest(k,P,Q,cType,id1,id2)

    global trajData queryTraj

    if ~exist('cType','var')
        cType = 0;
        id1 = 0;
        id2 = 0;
    end
    
    lowBound = 0;
    
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
    BB2Bnd = BoundBoxDist(P,Q,22.5,cType,id1,id2);
  
    % Bounding box shift curve counterclockwise 45 degrees from origin axis.
    BB3Bnd = BoundBoxDist(P,Q,45,cType,id1,id2);
    
    % choose best (max) bounding box lower bound
    BBrotBnd = max(BBnorotBnd,max(BB2Bnd,BB3Bnd));

    % simplified single edge lower bound
    % get distances to single edge
    if cType == 0
        simpP = [P(1,:); P(end,:)]; % P'
        simpQ = [Q(1,:); Q(end,:)]; % Q'
        distP = ContFrechet(P,simpP,1,0);
        distQ = ContFrechet(Q,simpQ,1,0);
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
    
    % Approximate discrete Frechet upper bound
    if cType == 0
        padP = PadTraj(P,2);
        padQ = PadTraj(Q,2);
    elseif cType == 1
        padP = cell2mat(trajData(id1,7));
        padQ = cell2mat(queryTraj(id2,24));
    elseif cType == 2
        padP = cell2mat(trajData(id1,7));
        padQ = cell2mat(trajData(id2,7));
    end
    
    ADFnopadBnd = ApproxDiscFrechet(P,Q);    
    ADFpadBnd = ApproxDiscFrechet(padP,padQ);
    ADFBestBnd = min(ADFnopadBnd,ADFpadBnd);

    % get the exact continuous Fréchet distance
    currFrechetDist = ContFrechet(P,Q);
    
    % calc best LB (SE, BB no rot, BB with rot, SSE)
    bestLB = max(SEBnd,max(BBnorotBnd,max(BBrotBnd,SSEBnd)));
    
    % negative filter method lower bound
    if cType == 0
        padP = PadTraj(P,2);
        padQ = PadTraj(Q,2);
    elseif cType == 1
        padP = cell2mat(trajData(id1,7));
        padQ = cell2mat(queryTraj(id2,24));
    elseif cType == 2
        padP = cell2mat(trajData(id1,7));
        padQ = cell2mat(trajData(id2,7));
    end
    % get neg filter result with padding - compare to best LB
    negFiltPadRes = NegFilterDP(padP,padQ,bestLB);
    if negFiltPadRes == false
        negFiltPadRes = NegFilterDP(padQ,padP,bestLB); % swap P & Q
    end
    % get neg filter result with no padding - compare to best LB
    negFiltNoPadRes = NegFilterDP(P,Q,bestLB);
    if negFiltNoPadRes == false
        negFiltNoPadRes = NegFilterDP(Q,P,bestLB); % swap P & Q
    end
    
    % get number of pruned traj using best LB
    prunedTrajIdList = cell2mat(queryTraj(k,7));
    NumBestLBPrunedTraj = size(prunedTrajIdList,1);

    % save results
    queryTraj(k,29) = num2cell(currFrechetDist);
    queryTraj(k,30) = num2cell(SEBnd);
    queryTraj(k,31) = num2cell(BBnorotBnd);
    queryTraj(k,32) = num2cell(BBrotBnd);
    queryTraj(k,33) = num2cell(SSEBnd);
    queryTraj(k,34) = num2cell(SEBnd == bestLB);
    queryTraj(k,35) = num2cell(BBnorotBnd == bestLB);
    queryTraj(k,36) = num2cell(BBrotBnd == bestLB);
    queryTraj(k,37) = num2cell(SSEBnd == bestLB);
    queryTraj(k,38) = num2cell(ADFnopadBnd);
    queryTraj(k,39) = num2cell(ADFBestBnd);
    queryTraj(k,40) = num2cell(ADFBestBnd ~= ADFnopadBnd);
    queryTraj(k,41) = num2cell(negFiltNoPadRes);
    queryTraj(k,42) = num2cell(negFiltPadRes);
    queryTraj(k,43) = num2cell(negFiltNoPadRes ~= negFiltPadRes);

end