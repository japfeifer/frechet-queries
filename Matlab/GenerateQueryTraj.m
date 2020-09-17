% Create a bunch of query trajectories

tic;
queryTraj = {[]};
bestTrajId = 0;
bestTrajDist = 0;
currReach = 0;
currNumVertices = 0;
perturbDist = 0;
totalTraj = size(trajData,1);

for k = 1:numQueryTraj
    
    if genQueryType == 1  % generate a random sample traj
        
        currNumVertices = randi([floor(avgNumVertices/2) floor(avgNumVertices*1.5)] ,1);
        sampleTraj = [];
        for i = 1:currNumVertices
            if i==1
                xPos = gridX*rand;
                yPos = gridY*rand;
            elseif i==2
                xPos = (-maxVertDist + (maxVertDist+maxVertDist) *rand) + sampleTraj(i-1,1);
                yPos = (-maxVertDist + (maxVertDist+maxVertDist) *rand) + sampleTraj(i-1,2);
            else
                xPos = (-maxVertDist + (maxVertDist+maxVertDist) *rand) + (sampleTraj(i-1,1)) + straightFactor.*(sampleTraj(i-1,1) - sampleTraj(i-2,1));
                yPos = (-maxVertDist + (maxVertDist+maxVertDist) *rand) + (sampleTraj(i-1,2)) + straightFactor.*(sampleTraj(i-1,2) - sampleTraj(i-2,2));
            end  
            sampleTraj(i,:) = [xPos yPos];
        end
    elseif genQueryType == 2  % generate traj similar to an existing traj
        currTrajDataCell = randi(totalTraj);
        sampleTraj = cell2mat(trajData(currTrajDataCell,1));
        currNumVertices = size(sampleTraj,1);
        currReach = TrajReach(sampleTraj);
        perturbDist = currReach * 0.03;
        % perturb each of the vertices
        sampleTraj = sampleTraj + ((-perturbDist + (perturbDist+perturbDist).*rand(size(sampleTraj,2),currNumVertices))');
        % now move (translate) the trajectory
        perturbDist = currReach * 0.05;
        for i = 1:size(sampleTraj,2)
            transValue = (-perturbDist + (perturbDist+perturbDist).*rand(1,1));
            sampleTraj(:,i) = sampleTraj(:,i) + transValue;
        end
    elseif genQueryType == 3  % generate traj similar to an existing traj but translate fairly far
        currTrajDataCell = randi(totalTraj);
        sampleTraj = cell2mat(trajData(currTrajDataCell,1));
        currNumVertices = size(sampleTraj,1);
        currReach = TrajReach(sampleTraj);
        perturbDist = currReach * 0.03;
        % perturb each of the vertices
        sampleTraj = sampleTraj + ((-perturbDist + (perturbDist+perturbDist).*rand(size(sampleTraj,2),currNumVertices))');
        % now move (translate) the trajectory
        perturbDist = currReach * 0.5;
        for i = 1:size(sampleTraj,2)
            transValue = (-perturbDist + (perturbDist+perturbDist).*rand(1,1));
            sampleTraj(:,i) = sampleTraj(:,i) + transValue;
        end
    elseif genQueryType == 4  % generate traj same as an existing traj
        currTrajDataCell = randi(totalTraj);
        sampleTraj = cell2mat(trajData(currTrajDataCell,1));
        currNumVertices = size(sampleTraj,1);
    end
    
    % update queryTraj with the traj that was generated
    tmpTrajStartEnd = [sampleTraj(1,:); sampleTraj(currNumVertices,:)];
    queryTraj(k,1) = mat2cell(sampleTraj,size(sampleTraj,1),size(sampleTraj,2));
    queryTraj(k,2) = mat2cell(tmpTrajStartEnd,size(tmpTrajStartEnd,1),size(tmpTrajStartEnd,2));

end
timeElapsed = toc;