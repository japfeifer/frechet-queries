% This function calcs a series of fast (constant, linear, or nlogn) lower 
% bounds between two trajectories.
% if cType = 0, then don't use ids
% if cType = 1, then id1 = traj id and id2 = query id
% if cType = 2, then id1 = traj id and id2 = traj id
% if cType = 3, then id1 = query id

function lowBound = GetBestConstLB(P,Q,epsilon,cType,id1,id2,excludeSSE)

    global trajStrData queryStrData

    switch nargin
    case 2
        epsilon = Inf;
        cType = 0;
        id1 = 0;
        id2 = 0;
        excludeSSE = 0;
    case 3
        cType = 0;
        id1 = 0;
        id2 = 0;
        excludeSSE = 0;
    case 6
        excludeSSE = 0;
    end

    sPDim = size(P,2);
    done = false;
    lowBound = 0;
    
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

    % bounding box lower bound, don't shift curve
    if done == false
        currBnd = BoundBoxDist(P,Q,0,cType,id1,id2);
        if currBnd > lowBound
            lowBound = currBnd;
            if lowBound >= epsilon
                done = true;
            end
        end    
    end
   
    if sPDim <= 3  % only check BB rotations for 2-d and 3-d traj
        % Bounding box shift curve counterclockwise 22.5 degrees from origin axis.
        if done == false
            currBnd = BoundBoxDist(P,Q,22.5,cType,id1,id2);
            if currBnd > lowBound
                lowBound = currBnd;
                if lowBound >= epsilon
                    done = true;
                end
            end    
        end
        
        % Bounding box shift curve counterclockwise 45 degrees from origin axis.
        if done == false
            currBnd = BoundBoxDist(P,Q,45,cType,id1,id2);
            if currBnd > lowBound
                lowBound = currBnd;
                if lowBound >= epsilon
                    done = true;
                end
            end    
        end
    end

    % simplified single edge lower bound
    if excludeSSE == 0
        if done == false
            % get distances to single edge
            if cType == 0
                simpP = [P(1,:); P(end,:)]; % P'
                simpQ = [Q(1,:); Q(end,:)]; % Q'
                distP = ContFrechet(P,simpP,2,0);
                distQ = ContFrechet(Q,simpQ,2,0);
            elseif cType == 1
                distP = trajStrData(id1).st;
                distQ = queryStrData(id2).st;
            elseif cType == 2
                distP = trajStrData(id1).st;
                distQ = trajStrData(id2).st;
            elseif cType == 3
                simpP = [P(1,:); P(end,:)]; % P'
                distP = ContFrechet(P,simpP,2,0);
                distQ = trajStrData(id1).st;
            end
            currBnd = abs(distP - distQ)/2;
            if currBnd > lowBound
                lowBound = currBnd;
                if lowBound >= epsilon
                    done = true;
                end
            end
        end
    end

    % keep only 10 decimal places
    lowBound = round(lowBound,10)+0.00000000009;
    lowBound = fix(lowBound * 10^10)/10^10;

end