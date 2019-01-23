% bounding box prune
% prune traj where bounding box edges are further than Emax apart from 
% query bounding box edges

tic;

for k = 1:numQueryTraj % for each query do
    
    Q = cell2mat(queryTraj(k,1)); % get the current query traj

    % get list of candidate traj from the Simplification Search Prune
    currTrajIDList = cell2mat(queryTraj(k,6));
    
    smallTrajIdList = [];
    
    if isempty(currTrajIDList) == false % only process if list is not null
        for j = 1:size(currTrajIDList,1) % for each traj do
            P = cell2mat(trajData(currTrajIDList(j),1));
            currDist = BoundBoxDist(P,Q,0);
            if currDist <= Emax
                currDist = BoundBoxDist(P,Q,22.5);
                if currDist <= Emax
                    currDist = BoundBoxDist(P,Q,45);
                    if currDist <= Emax
                        smallTrajIdList = [smallTrajIdList; currTrajIDList(j)]; % keep, don't prune
                    end
                end
            end
        end
    end

    if isempty(smallTrajIdList) == false
        queryTraj(k,7) = mat2cell(smallTrajIdList,size(smallTrajIdList,1),size(smallTrajIdList,2));
    else
        queryTraj(k,7) = mat2cell([],size([],1),size([],2));
    end
    
end

timeElapsed = toc;