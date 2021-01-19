
function lowBound = GetBestLinearLBDP(P,Q,epsilon,cType,id1,id2)

%     global trajData queryTraj

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
%             padP = cell2mat(trajData(id1,7));
%             padQ = cell2mat(queryTraj(id2,24));
%         elseif cType == 2
%             padP = cell2mat(trajData(id1,7));
%             padQ = cell2mat(trajData(id2,7));
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