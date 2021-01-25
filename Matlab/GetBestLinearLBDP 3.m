
function lowBound = GetBestLinearLBDP(P,Q,epsilon,cType,id1,id2)

    switch nargin
    case 3
        cType = 0;
        id1 = 0;
        id2 = 0;
    end

    lowBound = false;
    
%     vertSize = max(size(P,1),size(Q,1));
% 
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
    
    % negative filter method lower bound
    negFiltRes = TraversalRace(P,Q,epsilon);
    if negFiltRes == true
        lowBound = true;
    else
        negFiltRes = TraversalRace(Q,P,epsilon); % swap P & Q
        if negFiltRes == true
            lowBound = true;
        end
    end

end