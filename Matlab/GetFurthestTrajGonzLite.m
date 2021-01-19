
function [furthestTrajID,largestRSize,tList] = GetFurthestTrajGonzLite(cTrajId,tList)

    global numCFD trajStrData numFurthestCFD
    
    bndList = []; cTraj = []; tTraj = []; currDist = 0;

    % first get upper and lower bounds for each traj
    cTraj = trajStrData(cTrajId).traj;
    for i = 1:size(tList,1)
        if tList(i,3) == -1
            tTraj = trajStrData(tList(i,1)).traj;
            currUpBnd = GetBestUpperBound(cTraj,tTraj,2,cTrajId,tList(i,1));
            currLowBnd = GetBestConstLB(cTraj,tTraj,Inf,2,cTrajId,tList(i,1));
            if currLowBnd > currUpBnd % this fixes a precision error with the football data
                currLowBnd = round(currLowBnd * 10^9) / 10^9;
                currUpBnd = round(currUpBnd * 10^9) / 10^9;
            end
            tList(i,3) = currLowBnd;
            tList(i,4) = currUpBnd;
            if currLowBnd == currUpBnd
                tList(i,2) = currLowBnd; % set exact dist to LB
            end
        end
    end

    % determine which traj has the highest lower bound
    [hlbValue,idx] = max(tList(:,3)); % get the maximum lower bound
    hlbTrajID = tList(idx,1); % this is the highest lower bound traj id

    % get where curr traj upper bound >= highest lower bound traj value
    bndList = tList(tList(:,4) >= hlbValue, :);
    bndListIdx = find(tList(:,4) >= hlbValue);
    
    % For this reduced candidate list, calc frechet dist and keep track of the
    % furthest one.
    % ***** this could be imrpved by doing some sort of random pivoting algorithm ****
    % *** see initial code in GetFurthestTrajQuickSelect ****
    largestRSize = 0;
    for i = 1:size(bndList,1)
        if bndList(i,2) == -1
            tTraj = trajStrData(bndList(i,1)).traj;
            currDist = ContFrechet(cTraj, tTraj);
            numCFD = numCFD + 1;
            numFurthestCFD = numFurthestCFD + 1;
            tList(bndListIdx(i,1),2) = currDist;
            tList(bndListIdx(i,1),3) = currDist; % set LB to exact dist
            tList(bndListIdx(i,1),4) = currDist; % set UB to exact dist
        else
            currDist = bndList(i,2);
        end
        if i==1 || currDist >= largestRSize
            largestRSize = currDist;
            furthestTrajID = bndList(i,1);
        end
    end
  
end