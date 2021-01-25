% function GetClusterUpperBound gets the tightest upper bound between a new
% trajectory centre and the current trajectory centre 

function upBnd = GetClusterUpperBound(nTrajID,cTrajID)

    global trajStrData
    
    % see if dist is pre-stored
    upBnd = ReadDistMap(nTrajID,cTrajID);
    if isempty(upBnd) == true %if upBnd == -1 % dist is not pre-stored
        nTraj = trajStrData(nTrajID).traj;
        cTraj = trajStrData(cTrajID).traj;
        upBnd = GetBestUpperBound(nTraj,cTraj,2,nTrajID,cTrajID);
    end

end