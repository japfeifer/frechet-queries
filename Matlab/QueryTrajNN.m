% Find the NN for all query traj
% Much of the code here is written to test the concept and is not meant to 
% be fast or efficient.  The actual solution will use a different
% method and data structures.

tic;
tmpAnchorTraj = anchorTraj;
dfcn = @(u,v) sqrt(sum( (u-v).^2 ));

for k = 1:numQueryTraj  % do for each query traj
    
    currQueryTraj = cell2mat(queryTraj(k,1));
    fullDistList = [];
    smallTrajIdList = [];

    % Make each of the anchor traj distance lists smaller by
    % comparing the start/end points with query start/end points.
    % The actual solution will do this most likely with a range tree
    tmpStartEnd2 = cell2mat(queryTraj(k,2));
    tmpStartEnd1 = cell2mat(trajData(:,2));
    for i = 1:totalTraj
        if (dfcn(tmpStartEnd1(i,1:2),tmpStartEnd2(1,:)) <= Emax) && ...
           (dfcn(tmpStartEnd1(i,3:4),tmpStartEnd2(2,:)) <= Emax)
            smallTrajIdList = [smallTrajIdList; i];                
        end            
    end
    
    for j = 1:numAnchorTraj  % do for each anchor traj
        
        % calc distance from query traj to anchor traj
        currAnchorTraj = cell2mat(tmpAnchorTraj(j,1));
        currDist = DiscreteFrechetDist(currAnchorTraj,currQueryTraj);
        
        tmpAnchorTraj(j,3) = num2cell(currDist);
        
        % create smaller list of curr traj distances
        newDistList = [];
        currDistList = cell2mat(tmpAnchorTraj(j,2));
        [newDistList,ia,ib] = intersect(smallTrajIdList, currDistList(:,1));
        newDistList = [newDistList currDistList(ib,2)];
          
        if isempty(newDistList) == false  % if there are traj close enough
            % save smaller list of traj distances 
            newDistList = sortrows(newDistList,2);
            tmpAnchorTraj(j,4) = mat2cell(newDistList,size(newDistList,1),size(newDistList,2));
            
            % calc and save smaller list of traj distances, adjusted for current distance
            adjDistList = [newDistList(:,1), abs(currDist - newDistList(:,2))];
            adjDistList = sortrows(adjDistList,2);
            fullDistList = cat(1,fullDistList,adjDistList);
            tmpAnchorTraj(j,5) = mat2cell(adjDistList,size(adjDistList,1),size(adjDistList,2));
        end
    end
    
    % save the reduced traj ID list size
    queryTraj(k,6) = num2cell(size(smallTrajIdList,1));
    
    if isempty(fullDistList) == false  
        % store results of close trajectories
        fullDistList = sortrows(fullDistList,2);
        queryTraj(k,7) = mat2cell(fullDistList,size(fullDistList,1),size(fullDistList,2));
        
        % now find the traj that is potentially the closest
        foundTraj = false;
        foundList = zeros(totalTraj,1);
        counter = 1;
        while foundTraj == false
            currTrajId = fullDistList(counter,1);
            foundList(currTrajId,1) = foundList(currTrajId,1) + 1;
            if foundList(currTrajId,1) == numAnchorTrajCompare
                foundTraj = true;
            end
            counter = counter + 1;      
        end
        
        % save ID of traj 
        queryTraj(k,8) = num2cell(currTrajId);
        
    else
        queryTraj(k,6:9) = num2cell(0);
    end

end

timeElapsed = toc;

%calc distance from query to traj id that the NN algo found
for k = 1:numQueryTraj  % do for each query traj
    if cell2mat(queryTraj(k,8)) > 0
        currQueryTraj = cell2mat(queryTraj(k,1));
        currFoundTraj = cell2mat(trajData(cell2mat(queryTraj(k,8)),1));    
        currDist = DiscreteFrechetDist(currFoundTraj,currQueryTraj);
        queryTraj(k,9) = num2cell(currDist);
    end
end

% calc position queryNN was in vs actual NN
for k = 1:numQueryTraj
    a = cell2mat(queryTraj(k,3));
    b = cell2mat(queryTraj(k,8));
    if b ~= 0
        c = find(a(:,1)==b,1);
        queryTraj(k,10) = num2cell(c);
    else
        queryTraj(k,10) = num2cell(0);
    end
end
    
% calc percent correct for query NN algo
a = cell2mat(queryTraj(:,4));
b = cell2mat(queryTraj(:,8));
c = sum(a == b);
d = numQueryTraj - sum(ismember(b,[0]));
queryTraj(1,14) = num2cell(c/d*100);

% calc percent correct for random selection
a = cell2mat(queryTraj(:,6));
a = a(a ~= 0);
a = 1./a;
b = sum(a) / size(a,1) * 100;
queryTraj(1,15) = num2cell(b);



% choose NN just based on closest orig/dest distance
for k = 1:numQueryTraj
    tmpStartEnd2 = cell2mat(queryTraj(k,2));
    tmpStartEnd1 = cell2mat(trajData(:,2));
    currMinDist = 9999;
    currTrajId = 0;
    for i = 1:totalTraj
        a = dfcn(tmpStartEnd1(i,1:2),tmpStartEnd2(1,:));
        b = dfcn(tmpStartEnd1(i,3:4),tmpStartEnd2(2,:));
        if max(a,b) < currMinDist
            currMinDist = max(a,b);   
            currTrajId = i;
        end            
    end
    queryTraj(k,11) = num2cell(currTrajId);
    currDist = DiscreteFrechetDist(cell2mat(trajData(currTrajId,1)),cell2mat(queryTraj(k,1)));
    queryTraj(k,12) = num2cell(currDist);
end  

% calc position orig/dest NN was in vs actual NN
for k = 1:numQueryTraj
    a = cell2mat(queryTraj(k,3));
    b = cell2mat(queryTraj(k,11));
    if a ~= 0
        c = find(a(:,1)==b,1);
        queryTraj(k,13) = num2cell(c);
    else
        queryTraj(k,13) = num2cell(0);
    end
end

% calc percent correct for orig/dest NN algo
a = cell2mat(queryTraj(:,4));
b = cell2mat(queryTraj(:,11));
c = sum(a == b);
d = numQueryTraj - sum(ismember(b,[0]));
queryTraj(1,16) = num2cell(c/d*100);

