% The goal of this function is to determine the furthest traj in the cluster.
% Rather than a brute force Frechet dist check of all traj we will use some
% lower and upper bounds to whittle down the list of candidates and only
% call the Frechet dist for those candidate traj.

function [furthestTrajID,largestRSize] = GetFurthestTraj(cTrajId,tList)

    global numCFD numDP trajData doDFD
    
    bndList = []; cTraj = []; tTraj = []; candList = []; currDist = 0;

    % first get upper and lower bounds for each traj
    cTraj = cell2mat(trajData(cTrajId,1));
    for i = 1:size(tList,1)
        tTraj = cell2mat(trajData(tList(i),1));
        currUpBnd = GetBestUpperBound(cTraj,tTraj,2,cTrajId,tList(i));
        currLowBnd = GetBestLowerBound(cTraj,tTraj,Inf,2,cTrajId,tList(i));
        bndList = [bndList; tList(i,1) currLowBnd currUpBnd];
    end

    % determine which traj has the highest lower bound
    bndList = sortrows(bndList,2,'descend'); % sort by lower bound desc
    hlbTrajID = bndList(1,1); % this is the highest lower bound traj id
    hlbValue = bndList(1,2);

    % if curr traj upper bound < highest lower bound traj value, delete
    TF1 = bndList(:, 3) < hlbValue; 
    bndList(TF1,:) = [];
    
    % only keep traj further than hlbValue, use frechet decision proc
    if size(bndList,1) > 1
        bndList = sortrows(bndList,2,'ascend'); % sort by lower bound asc
        for i = 1:size(bndList,1) - 1
            tTraj = cell2mat(trajData(bndList(i,1),1));
            decResult = FrechetDecide(cTraj, tTraj, hlbValue,0);
            if decResult == 0 % traj is further
                candList = [candList; bndList(i,:)];
            end
        end
    end
    candList = [candList; bndList(size(bndList,1),:)];

    % For this reduced candidate list, calc frechet dist and keep track of the
    % furthest one.
    for i = 1:size(candList,1)
        if i == 1 % calc CFD for first traj in candidate list
            
            tTraj = cell2mat(trajData(candList(i,1),1));
            if doDFD == true
                currDist = DiscreteFrechetDist(cTraj,tTraj);
            else
                currDist = ContFrechet(cTraj, tTraj);
            end
            
            if candList(i,2) ~= candList(i,3) % UB not equal LB
                numCFD = numCFD + 1;
            end

            largestRSize = currDist;
            furthestTrajID = candList(i,1);
        else
            % check Frechet DP
            tTraj = cell2mat(trajData(candList(i,1),1));
            if candList(i,2) ~= candList(i,3) % UB not equal LB
                decResult = FrechetDecide(cTraj, tTraj, largestRSize,0);
                numDP = numDP + 1;
            else
                if candList(i,2) > largestRSize
                    decResult = 0;
                else
                    decResult = 1;
                end
            end
            if decResult == 0 % tTraj is further
                if doDFD == true
                    currDist = DiscreteFrechetDist(cTraj,tTraj);
                else
                    currDist = ContFrechet(cTraj, tTraj);
                end
                if candList(i,2) ~= candList(i,3) % UB not equal LB
                    numCFD = numCFD + 1;
                end
                largestRSize = currDist;
                furthestTrajID = candList(i,1);
            end
        end
    end

end