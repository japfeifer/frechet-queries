% create a bunch of randomly generated 2D trajectories
tic;
trajCounter = 0;
trajData = {[]};

trajData(numDiffTraj*numSimilarTraj,1:7) = {0}; % pre-populate trajData with nulls - performance improvement

h = waitbar(0, 'Generate Trajectory');

for k = 1:numDiffTraj
    % generate a random sample traj
    currNumVertices = randi([floor(avgNumVertices/2) floor(avgNumVertices*1.5)] ,1);
    sampleTraj = [];
    for i = 1:currNumVertices
        dimPos = [];
        if i==1
            for j = 1:numDim
                dimPos = [dimPos dimUnits*rand];
            end
        elseif i==2
            for j = 1:numDim
                dimPos = [dimPos (-maxVertDist + (maxVertDist+maxVertDist) *rand) + sampleTraj(i-1,j)];
            end
        else
            for j = 1:numDim
                dimPos = [dimPos (-maxVertDist + (maxVertDist+maxVertDist) *rand) + (sampleTraj(i-1,j)) + straightFactor.*(sampleTraj(i-1,j) - sampleTraj(i-2,j))];
            end
        end  
        sampleTraj(i,:) = dimPos;
    end
        
    for i = 1:numSimilarTraj
        prevTraj = sampleTraj;

        curr_Traj = prevTraj;

        % randomize the vertices a bit
        curr_Traj = prevTraj + ((-maxVertDist + (maxVertDist+maxVertDist).*rand(numDim,currNumVertices))');
        % randomize the location a bit (translate it to a slightly different location
        for j = 1:numDim
            curr_Traj(:,j) = curr_Traj(:,j) + (-maxVertDist+1 + (maxVertDist+1+maxVertDist+1).*rand(1));
        end
        
        % store the new traj
        trajCounter = trajCounter + 1;
        trajData(trajCounter,1) = mat2cell(curr_Traj,size(curr_Traj,1),size(curr_Traj,2));
        tmpTrajStartEnd = [curr_Traj(1,:); curr_Traj(currNumVertices,:)];
        trajData(trajCounter,2) = mat2cell(tmpTrajStartEnd,size(tmpTrajStartEnd,1),size(tmpTrajStartEnd,2));
        
    end
    
    if mod(k,1000) == 0
        X = ['Generate Trajectory ',num2str(k),'/',num2str(numDiffTraj)];
        waitbar(k/numDiffTraj, h, X);
    end
    
end

close(h);
timeElapsed = toc;