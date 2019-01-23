% Range Search Prune Step

dfcn = @(u,v) sqrt(sum( (u-v).^2 ));
tic;

for k = 1:numQueryTraj
   
    % Range Search query start and end vertices - compare the traj data 
    % start/end vertices with query start/end vertices and only keep those 
    % within Emax distance.
    % For experimentation just do a linear scan of all trajectories.
    % The actual solution will do this with a range tree which will improve
    % upon the run time.
    qStartEnd = cell2mat(queryTraj(k,2)); % query start/end vertices
    smallTrajIdList = [];
    for i = 1:totalTraj
        tStartEnd = cell2mat(trajData(i,2)); % traj start/end vertices
        if (dfcn(tStartEnd(1,:),qStartEnd(1,:)) <= Emax) && ...
           (dfcn(tStartEnd(2,:),qStartEnd(2,:)) <= Emax)
            smallTrajIdList = [smallTrajIdList; i];                
        end            
    end
    
    if isempty(smallTrajIdList) == false 
        queryTraj(k,3) = mat2cell(smallTrajIdList,size(smallTrajIdList,1),size(smallTrajIdList,2));
    else
        queryTraj(k,3) = mat2cell([],size([],1),size([],2));
    end
    queryTraj(k,4) = num2cell(0);
    queryTraj(k,5) = num2cell(0);
end
timeElapsed = toc;