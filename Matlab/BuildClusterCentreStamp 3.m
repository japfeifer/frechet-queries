% Cluster Centre Stamp build algorithm
%
% Build clusters via the Gonzalez algo and stamp out results when the
% kth iteration is a power of two or equal to the number of traj in the
% dataset.  Works for d-dimensional trajectories where d>=2.

tic;

h = waitbar(0, 'Build Cluster');

clusterTmpList = {[]};
clusterGroup = {[]};
clusterCurveGroup = {[]};
clusterRSize = {[]};
clusterCenterIteration = {[]};
currCenterNewDistList = [];
tmpDistList = [];
clusterHistCenterMap = [];
histPrevCenterRSize = [];
nextKsize = 2;
kRowCounter = 1;
tmpRSize = 0;
tmpFurthestTrajID = 0;
numCFD = 0;
numDP = 0;
trajFactor = 0;
maxMatrixInsert = 0;
currMatrixInsert = 0;
moveToNewCenter = false;
processHistIter = false;
currEqualPrev = false;

% get number of trajectories to process
totalTraj = size(trajStrData,2);

% initialize Distance hash table
distMap = containers.Map;
trajDistMatrix = {[]};

for i=1:totalTraj
    trajDistMatrix(i,1) = {[]};
end

% make the traj factor logn, and matrix insert logn
trajFactor = ceil(log2(totalTraj));
maxMatrixInsert = trajFactor * totalTraj;

numtrajProcess = pow2(floor(log2(totalTraj)));

% build cluster for each k value and occasionaly "stamp" out the results
for currKsize = 1:totalTraj

    if (currKsize == 1)  % first cluster
        % randomly choose a traj as the first center
%         centerTrajId = randi(totalTraj,1);

        % for testing purposes hardcode the first center ID so that it is easy to do
        % comparisons of code changes and recreate the same output 
        centerTrajId = 1;
        
        newCenterTraj = trajStrData(centerTrajId).traj;
        
        % compare distance from center traj to all other traj
        for j = 1:totalTraj 
            if j == centerTrajId % we are comparing the traj to itself
                currDist = 0;
            else
                currTraj = trajStrData(j).traj; 
                
                upBnd = GetBestUpperBound(currTraj,newCenterTraj,2,j,centerTrajId);
                lowBnd = GetBestConstLB(currTraj,newCenterTraj,Inf,2,j,centerTrajId);

                if upBnd == lowBnd % we have the Continuous Frechet dist
                    currDist = upBnd;
                else
                    if doDFD == true
                        currDist = DiscreteFrechetDist(newCenterTraj,currTraj);
                    else
                        currDist = ContFrechet(newCenterTraj,currTraj);
                    end
                    numCFD = numCFD + 1;
                end
                InsertDistMap(centerTrajId,j,currDist);
                InsertDistMap(j,centerTrajId,currDist);
                currMatrixInsert = currMatrixInsert + 1;
            end          
            currCenterNewDistList = [currCenterNewDistList; j currDist];
            if currDist > tmpRSize
                tmpRSize = currDist;
                tmpFurthestTrajID = j;
            end  
        end
        
        % save the first cluster
        clusterTmpList(currKsize,1) = num2cell(centerTrajId);
        clusterTmpList(currKsize,2) = mat2cell(currCenterNewDistList,size(currCenterNewDistList,1),size(currCenterNewDistList,2));
        clusterTmpList(currKsize,3) = num2cell(tmpRSize);
        clusterTmpList(currKsize,4) = num2cell(tmpFurthestTrajID);
        
        % save the max R size for this cluster set
        clusterRSize(currKsize,1) = num2cell(tmpRSize);
        
        % save the cluster center iteration
        clusterCenterIteration(centerTrajId,1) = num2cell(currKsize);

    elseif nextKsize < totalTraj % it's not in the last k grouping for powers of 2
        
        % find the furthest curve from it's center and make that a new
        % center, then loop thru each traj list in the clusterTmpList and
        % see if each traj is closer to the new center (if it is move it).
        tmpRSize = 0;
        sizeclusterTmpList = size(clusterTmpList,1);
        for j = 1:sizeclusterTmpList % first get furthest curve from it's center
            if (j == 1) || (tmpRSize < cell2mat(clusterTmpList(j,3)))
                tmpRSize = cell2mat(clusterTmpList(j,3));
                tmpFurthestTrajID = cell2mat(clusterTmpList(j,4));
                currCenterID = cell2mat(clusterTmpList(j,1));
            end           
        end

        prevCenterRSize = tmpRSize;
        prevCenterTrajID = currCenterID;
        prevCenterTraj = trajStrData(prevCenterTrajID).traj;
        newCenterTraj = trajStrData(tmpFurthestTrajID).traj; % new center
        newCenterTrajID = tmpFurthestTrajID;
        prevClusterIterNum = cell2mat(clusterCenterIteration(prevCenterTrajID,1));

        % put the new center traj into the list
        newCenterDistList = [newCenterTrajID 0];
        newCenterRSize = 0;
        newCenterFurthestTrajID = newCenterTrajID;

        for j = 1:sizeclusterTmpList % search each existing cluster
            currCenterTrajID = cell2mat(clusterTmpList(j,1));
            currCenterTraj = trajStrData(currCenterTrajID).traj;
            currCenterOldDistList = cell2mat(clusterTmpList(j,2));
            currCenterOldRSize = cell2mat(clusterTmpList(j,3));

            if currCenterOldRSize > 0 % only process if some traj in cluster are > 0 from center
                
                if currCenterTrajID == prevCenterTrajID
                    currEqualPrev = true;
                else
                    currEqualPrev = false;
                end
                
                mustProcessCluster = true;
                
                if currEqualPrev == false % only process if curr cluster is diff than prev cluster
                    upBnd = GetClusterUpperBound(newCenterTrajID,currCenterTrajID);
                    if (upBnd/2) - currCenterOldRSize > 0 % if upper bound is far enough away
                        lowBnd = GetClusterLowerBound(newCenterTrajID,currCenterTrajID,prevCenterTrajID, ...
                                    currCenterOldRSize,prevCenterRSize,prevClusterIterNum,processHistIter);
                        if ((lowBnd/2) - currCenterOldRSize) > 0 % if lower bound is far enough away
                            mustProcessCluster = false;
                        end
                    end
                end

                % now we must loop thru all traj's in the cluser and
                % check if each one is closer to the new center or prev
                % center
                if mustProcessCluster == true 
                    % put the curr center into the list
                    currCenterNewDistList = [currCenterTrajID 0];
                    currCenterNewRSize = 0;
                    currCenterNewFurthestTrajID = currCenterTrajID;
                    
                    for k = 1:size(currCenterOldDistList,1) % for each traj in the cluster
                        currTrajID = currCenterOldDistList(k,1);
                        currTraj = trajStrData(currTrajID).traj;
                        % don't process if traj is prev center, new center,
                        % or current cluster center
                        if currCenterTrajID ~= currTrajID && ...
                           newCenterTrajID ~= currTrajID && ...
                           prevCenterTrajID ~= currTrajID

                            lowBnd = GetBestConstLB(currTraj,newCenterTraj,currCenterOldDistList(k,2),2,currTrajID,newCenterTrajID);
                            upBnd = GetBestUpperBound(currTraj,newCenterTraj,2,currTrajID,newCenterTrajID);
                            if currCenterOldDistList(k,2) < lowBnd % prev center is closer
                                moveToNewCenter = false;
                            elseif currCenterOldDistList(k,2) > upBnd % new center is closer, get distance
                                moveToNewCenter = true;
                                currDist = ReadDistMap(currTrajID,newCenterTrajID);
                                if isempty(currDist) == true  %if currDist == -1 
                                    if lowBnd == upBnd
                                        currDist = lowBnd;
                                    else % we have to calc the dist
                                        if doDFD == true
                                            currDist = DiscreteFrechetDist(newCenterTraj,currTraj);
                                        else
                                            currDist = ContFrechet(newCenterTraj,currTraj);
                                        end
                                        numCFD = numCFD + 1;
                                        if currMatrixInsert < maxMatrixInsert 
                                            InsertDistMap(newCenterTrajID,currTrajID,currDist);
                                            InsertDistMap(currTrajID,newCenterTrajID,currDist);
                                            currMatrixInsert = currMatrixInsert + 1;
                                        end
                                    end
                                end
                            else % we don't know which center is closer, do calc
                                % first get dist from curr traj to new center
                                currDist = ReadDistMap(currTrajID,newCenterTrajID);
                                if isempty(currDist) == true %if currDist == -1 
                                    if lowBnd == upBnd
                                        currDist = lowBnd;
                                    else % we have to calc the dist
                                        % use Frechet decision proc to see
                                        % if new centre is closer
                                        decProRes = FrechetDecide(currTraj,newCenterTraj,currCenterOldDistList(k,2),1);
                                        numDP = numDP + 1;
                                        
                                        if decProRes == 1 % new centre is closer
                                            if doDFD == true
                                                currDist = DiscreteFrechetDist(newCenterTraj,currTraj);
                                            else
                                                currDist = ContFrechet(newCenterTraj,currTraj);
                                            end
                                            numCFD = numCFD + 1;
                                            if currMatrixInsert < maxMatrixInsert
                                                InsertDistMap(newCenterTrajID,currTrajID,currDist);
                                                InsertDistMap(currTrajID,newCenterTrajID,currDist);
                                                currMatrixInsert = currMatrixInsert + 1;
                                            end
                                        else % prev centre is closer
                                            currDist = currCenterOldDistList(k,2);
                                        end
                                    end
                                end
                                if currDist < currCenterOldDistList(k,2) % new center is closer
                                    moveToNewCenter = true;
                                else % prev center is closer
                                    moveToNewCenter = false;
                                end
                            end
                            
                            if moveToNewCenter == true  % attach traj to new center
                                newCenterDistList = [newCenterDistList; currTrajID currDist];
                                if (newCenterRSize < currDist)
                                    newCenterRSize = currDist;
                                    newCenterFurthestTrajID = currTrajID;
                                end
                            else  % keep traj with current center
                                currCenterNewDistList = [currCenterNewDistList; currTrajID currCenterOldDistList(k,2)];
                                if (currCenterNewRSize < currCenterOldDistList(k,2))
                                    currCenterNewRSize = currCenterOldDistList(k,2);
                                    currCenterNewFurthestTrajID = currTrajID;
                                end                        
                            end                            
                        end
                    end

                    % update the current center info
                    clusterTmpList(j,2) = mat2cell(currCenterNewDistList,size(currCenterNewDistList,1),size(currCenterNewDistList,2)); 
                    clusterTmpList(j,3) = num2cell(currCenterNewRSize);
                    clusterTmpList(j,4) = num2cell(currCenterNewFurthestTrajID);
                end 
            end
        end
        
        % insert the new center info
        j = size(clusterTmpList,1) + 1;
        clusterTmpList(j,1) = num2cell(newCenterTrajID);
        clusterTmpList(j,2) = mat2cell(newCenterDistList,size(newCenterDistList,1),size(newCenterDistList,2));
        clusterTmpList(j,3) = num2cell(newCenterRSize);
        clusterTmpList(j,4) = num2cell(newCenterFurthestTrajID);
        
        % save the max R size for this cluster set
        tmpRSize = 0;
        sizeclusterTmpList = size(clusterTmpList,1);
        for j = 1:sizeclusterTmpList % first get furthest curve from it's center
            if (j == 1) || (tmpRSize < cell2mat(clusterTmpList(j,3)))
                tmpRSize = cell2mat(clusterTmpList(j,3));
            end           
        end
        
        clusterRSize(currKsize,1) = num2cell(tmpRSize);
  
        % save the cluster center iteration
        clusterCenterIteration(newCenterTrajID,1) = num2cell(currKsize);
        
        % decide if this iteration should be saved as a hist
        if currKsize >= 2 && currKsize <= (2 + (trajFactor - 1))
            
            % store mapping of traj to their centers
            tmpSize = size(clusterHistCenterMap,2);
            for i = 1:size(clusterTmpList,1)
                tmpDistList = cell2mat(clusterTmpList(i,2));
                for j = 1:size(tmpDistList,1)
                    clusterHistCenterMap(tmpDistList(j,1),tmpSize+1) = cell2mat(clusterTmpList(i,1));
                end
            end
            
            % store the hist Prev R Size
            histPrevCenterRSize = [histPrevCenterRSize; prevCenterRSize];
            
            % set process hist flag to true
            processHistIter = true;
            
        end

    elseif (currKsize == totalTraj) % last k cluster
        clusterTmpList = {[]};
        for j=1:totalTraj
            clusterTmpList(j,1) = num2cell(j);
            clusterTmpList(j,2) = mat2cell([j 0],size([j 0],1),size([j 0],2));
            clusterTmpList(j,3) = num2cell(0);
            clusterTmpList(j,4) = num2cell(j);
        end
        
    end

    % "stamp" out the result if k is a power of 2, or if we're at the last traj
    if (currKsize == nextKsize) || (currKsize == totalTraj)
        currClusterGroup = [];
        maxRsize = 0;
        
        for i = 1:size(clusterTmpList,1) % process for each cluster
            currClusterCurveList = cell2mat(clusterTmpList(i,2));
            tmpRSize = cell2mat(clusterTmpList(i,3));
            currClusterGroup = [currClusterGroup; ...
                                tmpRSize , ...
                                size(currClusterCurveList,1) , ...
                                cell2mat(clusterTmpList(i,1)) , ...
                                cell2mat(clusterTmpList(i,4))];
    
            if maxRsize < tmpRSize  
                maxRsize = tmpRSize;  
            end
            
            % for each curve id add info to the clusterCurveGroup
            for j = 1:size(currClusterCurveList,1)
                currCurveId = currClusterCurveList(j,1);
                currCurve = [nextKsize , ...
                             i , ...
                             currClusterCurveList(j,2)];

                if nextKsize == 2  % first one so insert into clusterCurveGroup
                    clusterCurveGroup(currCurveId,1) = mat2cell(currCurve,size(currCurve,1),size(currCurve,2));
                else  % not first one, so update clusterCurveGroup
                    tmpCurrCurve = cell2mat(clusterCurveGroup(currCurveId,1));
                    tmpCurrCurve = [tmpCurrCurve ; currCurve];
                    clusterCurveGroup(currCurveId,1) = mat2cell(tmpCurrCurve,size(tmpCurrCurve,1),size(tmpCurrCurve,2));
                end
            end
            
        end
        % save clusterGroup info
        clusterGroup(kRowCounter,1) = num2cell(nextKsize);
        clusterGroup(kRowCounter,2) = num2cell(maxRsize);
        clusterGroup(kRowCounter,3) = mat2cell(currClusterGroup,size(currClusterGroup,1),size(currClusterGroup,2));
        
        nextKsize = nextKsize * 2; % calc next k value - power of 2 
        kRowCounter = kRowCounter + 1;
    end
    if mod(currKsize,20) == 0
        X = ['Build Cluster - ',num2str(numCFD),' CFD, k = ',num2str(currKsize)];
        waitbar(currKsize/numtrajProcess, h, X);
    end
end
disp(['------------------']);
disp(['numCFD: ',num2str(numCFD)]);
disp(['numDP: ',num2str(numDP)]);

close(h);
timeElapsed = toc;