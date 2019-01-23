% this function calcs a series of fast (linear) upper bounds between two
% trajectories

function upBound = GetBestUpperBound(P,Q,cType,id1,id2)

    global trajData queryTraj
    
    if ~exist('cType','var')
        cType = 0;
        id1 = 0;
        id2 = 0;
    end
    
    % For now just do Approx Discrete Frechet.  We can add more later.
    % Run ADF with and without padding and choose the best (lowest)

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
    
    noPadBound = ApproxDiscFrechet(P,Q);
    PadBound = ApproxDiscFrechet(padP,padQ);
    
    upBound = min(noPadBound,PadBound); % choose the best pad, vs. no pad
    
end