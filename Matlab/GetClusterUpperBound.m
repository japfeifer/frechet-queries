% function GetClusterUpperBound gets the tightest upper bound between a new
% trajectory centre and the current trajectory centre 

function upBnd = GetClusterUpperBound(nTrajID,cTrajID)

    global DistMatrix trajData distMap
    
    % see if dist is pre-stored
    upBnd = ReadDistMap(nTrajID,cTrajID);
    if isempty(upBnd) == true %if upBnd == -1 % dist is not pre-stored
        nTraj = cell2mat(trajData(nTrajID,1));
        cTraj = cell2mat(trajData(cTrajID,1));
        upBnd = GetBestUpperBound(nTraj,cTraj,2,nTrajID,cTrajID);
    end

end