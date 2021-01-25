% This is the original code for building the Cluster Centre Stamp data
% structure.  It uses a quadratic brute-force menthod to build the data
% structure, and because it was so slow, used the discrete frechet distance
% rather than the more accurate (but slower) continuous frechet.

% A better sub-quadratic version exists, so this code is NOT used in the 
% experiment.

% build cluster - buid clusters with successively larger k-values
% (powers of 2), up to k = n where n is the number of traj
% This is a completely brute-force algo, and the number of dist calls is
% equal to the number of trajectories squared. E.g. for 1,000 traj there
% will be 1,000,000 dist calls

tic;

nextKsize = 2;
kRowCounter = 1;
clusterTmpList = {[]};
clusterGroup = {[]};
clusterCurveGroup = {[]};
currRSize = 0;
currFurthestTrajID = 0;
currTrajList = [];
numDistCalls = 0;

totalTraj = size(trajStrData,2);

% build cluster for each k value and occasionaly "stamp" out the results
for currKsize = 1:totalTraj
    
    if (currKsize == 1)  % first cluster
        % randomly choose a traj as the first center
        centerTrajId = randi(totalTraj,1);
        sampleTraj = trajStrData(centerTrajId).traj;
        
        % compare distance to all other traj
        for j = 1:totalTraj
            currTraj = trajStrData(j).traj;                
            currDist = DiscreteFrechetDist(sampleTraj,currTraj);
            numDistCalls = numDistCalls + 1;
            currTrajList = [currTrajList; j currDist];
            if currDist > currRSize
                currRSize = currDist;
                currFurthestTrajID = j;
            end         
        end
        
        % save the first cluster
        clusterTmpList(currKsize,1) = num2cell(centerTrajId);
        clusterTmpList(currKsize,2) = mat2cell(currTrajList,size(currTrajList,1),size(currTrajList,2));
        clusterTmpList(currKsize,3) = num2cell(currRSize);
        clusterTmpList(currKsize,4) = num2cell(currFurthestTrajID);

    else % it's not the first cluster
        % find the furthest curve from it's center and make that a new
        % center, then loop thru each traj list in the clusterTmpList and
        % see if each traj is closer to the new center (if it is move it).
        
        for j = 1:size(clusterTmpList,1) % first get furthest curve from it's center
            if (j == 1) || (currRSize < cell2mat(clusterTmpList(j,3)))
                currRSize = cell2mat(clusterTmpList(j,3));
                currFurthestTrajID = cell2mat(clusterTmpList(j,4));
            end           
        end     
        
        sampleTraj = trajStrData(currFurthestTrajID).traj; % new center
        
        newCenterTrajList = [];
        newCenterTrajID = currFurthestTrajID;
        currRSize = 0;
        currFurthestTrajID = 0;
        
        for j = 1:size(clusterTmpList,1) % now see if each traj is closer to the new center
            currTrajDistList = cell2mat(clusterTmpList(j,2));
            oldCenterTrajList = [];
            oldRSize = 0;
            oldFurthestTrajID = 0;
            for k = 1:size(currTrajDistList,1)                
                currTrajID = currTrajDistList(k,1);
                currTrajDist = currTrajDistList(k,2);
                currTraj = trajStrData(currTrajID).traj;                
                currDist = DiscreteFrechetDist(sampleTraj,currTraj);
                numDistCalls = numDistCalls + 1;
                if currDist < currTrajDist  % attach traj to new center
                    newCenterTrajList = [newCenterTrajList; currTrajID currDist];
                    if (currFurthestTrajID == 0) || (currRSize < currDist)
                        currRSize = currDist;
                        currFurthestTrajID = currTrajID;
                    end
                else  % keep traj with old center
                    oldCenterTrajList = [oldCenterTrajList; currTrajID currTrajDist];
                    if (oldFurthestTrajID == 0) || (oldRSize < currTrajDist)
                        oldRSize = currTrajDist;
                        oldFurthestTrajID = currTrajID;
                    end                        
                end
            end
            clusterTmpList(j,2) = mat2cell(oldCenterTrajList,size(oldCenterTrajList,1),size(oldCenterTrajList,2)); 
            clusterTmpList(j,3) = num2cell(oldRSize);
            clusterTmpList(j,4) = num2cell(oldFurthestTrajID);
        end
        
        % now save the new center info
        j = size(clusterTmpList,1) + 1;
        clusterTmpList(j,1) = num2cell(newCenterTrajID);
        clusterTmpList(j,2) = mat2cell(newCenterTrajList,size(newCenterTrajList,1),size(newCenterTrajList,2));
        clusterTmpList(j,3) = num2cell(currRSize);
        clusterTmpList(j,4) = num2cell(currFurthestTrajID);
        
    end
    
    % "stamp" out the result if k is a power of 2, or if we're at the last traj
    if (currKsize == nextKsize) || (currKsize == totalTraj)
        currClusterGroup = [];
        maxRsize = 0;
        
        for i = 1:size(clusterTmpList,1) % process for each cluster
            currClusterCurveList = cell2mat(clusterTmpList(i,2));
            currRsize = cell2mat(clusterTmpList(i,3));
            currClusterGroup = [currClusterGroup; ...
                                currRsize , ...
                                size(currClusterCurveList,1) , ...
                                cell2mat(clusterTmpList(i,1)) , ...
                                cell2mat(clusterTmpList(i,4))];
    
            if maxRsize < currRsize  
                maxRsize = currRsize;  
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
end

timeElapsed = toc;