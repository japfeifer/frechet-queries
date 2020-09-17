
function [furthestTrajID,largestRSize,tList] = GetFurthestTrajQuickSelect(cTrajId,tList)

    global numCFD numDP trajData numFurthestCFD
    
    bndList = []; cTraj = []; tTraj = []; currDist = 0;
    rng('default'); % reset the random seed so that experiments are reproducable

    % first get upper and lower bounds for each traj
    cTraj = cell2mat(trajData(cTrajId,1));
    for i = 1:size(tList,1)
        if tList(i,3) == -1
            tTraj = cell2mat(trajData(tList(i),1));
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
        bndList(end+1,:) = [tList(i,:) i];
    end

    % determine which traj has the highest lower bound
    bndList = sortrows(bndList,3,'descend'); % sort by lower bound desc
    hlbTrajID = bndList(1,1); % this is the highest lower bound traj id
    hlbValue = bndList(1,3);

    % if curr traj upper bound < highest lower bound traj value, delete
    TF1 = bndList(:, 4) < hlbValue; 
    bndList(TF1,:) = [];
    
    % For this reduced candidate list, use quickselect to find the furthest one.
    if size(bndList,1) > 0
        largestRSize = -1; furthestTrajID = -1;
        while size(bndList,1) > 0
            pivot = randi([1 size(bndList,1)]); % randomly choose the pivot
            pivotRecord = bndList(pivot,:);
            bndList(pivot,:) = []; % remove pivot from list
            % get exact dist to pivot
            if pivotRecord(1,2) == -1
                tTraj = cell2mat(trajData(pivotRecord(1,1),1)); 
                pivotDist = ContFrechet(cTraj, tTraj);
                numCFD = numCFD + 1;
                numFurthestCFD = numFurthestCFD + 1;
                tList(pivotRecord(1,5),2) = pivotDist;
                tList(pivotRecord(1,5),3) = pivotDist; % set LB to exact dist
                tList(pivotRecord(1,5),4) = pivotDist; % set UB to exact dist
            else
                pivotDist = pivotRecord(1,2);
            end         
            if pivotDist > largestRSize
                largestRSize = pivotDist;
                furthestTrajID = pivotRecord(1,1);
            end
            markWithinDist = [];
            for i=1:size(bndList,1) % loop thru other traj in list
                tTraj = cell2mat(trajData(bndList(i,1),1));
                linearLB = GetBestLinearLBDP(tTraj,cTraj,pivotDist,2,bndList(i,1),cTrajId);
                if linearLB == false
                    decProRes = FrechetDecide(tTraj,cTraj,pivotDist,1);
                    numDP = numDP + 1;
                    if decProRes == 1 % traj is closer
                        markWithinDist(end+1) = i;
                    end
                end
            end
            bndList(markWithinDist,:) = [];           
        end
    else
       error('furthest trajectory list is empty.'); 
    end
end