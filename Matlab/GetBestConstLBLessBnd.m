
function lowBound = GetBestConstLBLessBnd(P,Q,epsilon,cType,id1,id2)

    global trajData queryTraj

    if ~exist('epsilon','var')
        epsilon = Inf;
    end
    
    if ~exist('cType','var')
        cType = 0;
        id1 = 0;
        id2 = 0;
    end
    
    sPDim = size(P,2);
    done = false;
    lowBound = 0;
    deg = 0;
    
    % start/end pos lower bound
    if done == false
        pStartEnd = [P(1,:) ; P(end,:)];
        qStartEnd = [Q(1,:) ; Q(end,:)];
        currBnd = max(CalcPointDist(pStartEnd(1,:),qStartEnd(1,:)) , ...
                      CalcPointDist(pStartEnd(2,:),qStartEnd(2,:)));
        if currBnd > lowBound
            lowBound = currBnd;
            if lowBound >= epsilon
                done = true;
            end
        end
    end

    % bounding box lower bound, use Dutsch and Vahrenhold algo
    if done == false
        if cType == 0 % compute P & Q bounding boxes
            PBB = ComputeBB(P,deg);
            QBB = ComputeBB(Q,deg);
        elseif cType == 1 || cType == 2 % the bounding box was pre-computed
            if deg == 0
                PBB = cell2mat(trajData(id1,3));
                if cType == 1
                    QBB = cell2mat(queryTraj(id2,20));
                else
                    QBB = cell2mat(trajData(id2,3));
                end
            elseif deg == 22.5
                PBB = cell2mat(trajData(id1,4));
                if cType == 1
                    QBB = cell2mat(queryTraj(id2,21));
                else
                    QBB = cell2mat(trajData(id2,4));
                end
            elseif deg == 45
                PBB = cell2mat(trajData(id1,5));
                if cType == 1
                    QBB = cell2mat(queryTraj(id2,22));
                else
                    QBB = cell2mat(trajData(id2,5));
                end
            end
        end

        dist = max(max(abs(PBB - QBB)));
        dist = round(dist,10)+0.00000000009;
        dist = fix(dist * 10^10)/10^10;

        currBnd = dist;
        if currBnd > lowBound
            lowBound = currBnd;
            if lowBound >= epsilon
                done = true;
            end
        end    
    end

    % keep only 10 decimal places
    lowBound = round(lowBound,10)+0.00000000009;
    lowBound = fix(lowBound * 10^10)/10^10;

end