% This function calcs a series of fast (constant, linear, or nlogn) lower 
% bounds between two trajectories.
% if cType = 0, then don't use ids
% if cType = 1, then id1 = traj id and id2 = query id
% if cType = 2, then id1 = traj id and id2 = traj id

function lowBound = GetBestLowerBound(P,Q,epsilon,cType,id1,id2)

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
    
    % start/end pos lower bound
    if done == false
        pStartEnd = [P(1,:) ; P(end,:)];
        qStartEnd = [Q(1,:) ; Q(end,:)];
        currBnd = max(CalcPointDist(pStartEnd(1,:),qStartEnd(1,:)) , ...
                      CalcPointDist(pStartEnd(2,:),qStartEnd(2,:)));
        currBnd = round(currBnd,10)+0.00000000009;
        currBnd = fix(currBnd * 10^10)/10^10;
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

    % negative filter method lower bound
    if done == false && epsilon < Inf
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
        negFiltRes = NegFilterDP(padP,padQ,epsilon);
        if negFiltRes == true
            done = true;
            lowBound = epsilon + 0.0000001; % need to think of a better method than this
        else
            negFiltRes = NegFilterDP(padQ,padP,epsilon); % swap P & Q
            if negFiltRes == true
                done = true;
                lowBound = epsilon + 0.0000001; % need to think of a better method than this
            end
        end
    end
    
    % simplified single edge lower bound
    if done == false
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
        currBnd = abs(distP - distQ)/2;
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