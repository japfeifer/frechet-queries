% this function calcs a series of fast (linear) upper bounds between two
% trajectories

function upBound = GetBestUpperBound(P,Q,cType,id1,id2,threshBound,doCnt)

    global trajStrData queryStrData
    global cntBBUB cntADF cntADFR cntADFD cntBBUBConst cntBBUBLin

    switch nargin
    case 2
        cType = 0;
        id1 = 0;
        id2 = 0;
        threshBound = 0;
        doCnt = 0;
    case 5
        threshBound = 0;
        doCnt = 0;
    case 6
        doCnt = 0;
    end
    
    vertSize = max(size(P,1),size(Q,1));
    dimSize = size(P,2);
    upBound = Inf;
    
    % first get bounding box distance since it is a constant time
    % computation
   
    % get BB for P & Q, 0 degree, 22.5 degree, and 45 degree rotation
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
        PBB = trajStrData(id1).bb1;
        if dimSize <=3
            PBB225 = trajStrData(id1).bb2;
            PBB45 = trajStrData(id1).bb3;
        end
        if cType == 1
            QBB = queryStrData(id2).bb1;
            if dimSize <=3
                QBB225 = queryStrData(id2).bb2;
                QBB45 = queryStrData(id2).bb3;
            end
        else
            QBB = trajStrData(id2).bb1;
            if dimSize <=3
                QBB225 = trajStrData(id2).bb2;
                QBB45 = trajStrData(id2).bb3;
            end
        end
    elseif cType == 3
        PBB = ComputeBB(P,0);
        QBB = queryStrData(id1).bb1;
        if dimSize <=3
            PBB225 = ComputeBB(P,22.5);
            PBB45 = ComputeBB(P,45);
            QBB225 = queryStrData(id1).bb2;
            QBB45 = queryStrData(id1).bb3;
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
        
        upBound = min(upBound0,min(upBound225,upBound45));
        
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
        
        upBound = min(upBound0,min(upBound225,upBound45));
        
    end
    
    if doCnt == 1
        cntBBUBConst = cntBBUBConst + 1;
    end
    
    if upBound < threshBound % we are done and do not have to do the linear check below
        if doCnt == 1
            cntBBUB = cntBBUB + 1;
        end
        upBound = round(upBound,10)+0.00000000009;
        upBound = fix(upBound * 10^10)/10^10;

        return
    end

%     % do not do padding as it usually only filters a small number of
%     % candidates and the runtime increases substantially
%     if vertSize <= 0 
%         if cType == 0
%             padP = PadTraj(P,2);
%             padQ = PadTraj(Q,2);
%         elseif cType == 1
%             padP = trajStrData(id1).padtraj;
%             padQ = queryStrData(id2).padtraj;
%         elseif cType == 2
%             padP = trajStrData(id1).padtraj;
%             padQ = trajStrData(id2).padtraj;
%         end
%     end

    if doCnt == 1
        cntBBUBLin = cntBBUBLin + 1;
    end

% % code below runs in parallel. Seems to be faster for very large curves P & Q, e.g. 1 million vertices
% tic
% spmd(3)
%     if labindex == 1
%         a1 = ApproxDiscFrechet(P,Q);
%     elseif labindex == 2
%         a1 = ApproxDiscFrechetRev(P,Q);
%     else
%         a1 = ApproxDiscFrechetDiag(P,Q);
%     end
% end
% toc
% disp(['ans1: ',num2str(a1{1}),' ans2: ',num2str(a1{2}),' ans3: ',num2str(a1{3})]);
    
    % do Approx Discrete Frechet (ADF)
    ADFBound = ApproxDiscFrechet(P,Q);
    upBound = min(upBound,ADFBound);
    if upBound < threshBound % we are done and do not have to do the linear check below
        if doCnt == 1
            cntADF = cntADF + 1;
        end
        return
    end

    % do ADF in reverse
    ADFRBound = ApproxDiscFrechetRev(P,Q);
    upBound = min(upBound,ADFRBound);
    if upBound < threshBound % we are done and do not have to do the linear check below
        if doCnt == 1
            cntADFR = cntADFR + 1;
        end
        return
    end
    
    ADFDBound = ApproxDiscFrechetDiag(P,Q);
    upBound = min(upBound,ADFDBound);
    if upBound < threshBound % we are done and do not have to do the linear check below
        if doCnt == 1
            cntADFD = cntADFD + 1;
        end
        return
    end

    upBound = round(upBound,10)+0.00000000009;
    upBound = fix(upBound * 10^10)/10^10;

end