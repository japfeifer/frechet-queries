
function lowBound = GetBestConstLBLessBnd(P,Q,epsilon,cType,id1,id2)

    global trajStrData queryStrData

    switch nargin
    case 2
        epsilon = Inf;
        cType = 0;
        id1 = 0;
        id2 = 0;
    case 3
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
        
        % get BB for P & Q
        if cType == 0 % compute P & Q bounding boxes
            PBB = ComputeBB(P,deg);
            QBB = ComputeBB(Q,deg);
        elseif cType == 1 || cType == 2 % the bounding box was pre-computed
            if deg == 0
                PBB = trajStrData(id1).bb1;
                if cType == 1
                    QBB = queryStrData(id2).bb1;
                else
                    QBB = trajStrData(id2).bb1;
                end
            elseif deg == 22.5
                PBB = trajStrData(id1).bb2;
                if cType == 1
                    QBB = queryStrData(id2).bb2;
                else
                    QBB = trajStrData(id2).bb2;
                end
            elseif deg == 45
                PBB = trajStrData(id1).bb3;
                if cType == 1
                    QBB = queryStrData(id2).bb3;
                else
                    QBB = trajStrData(id2).bb3;
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