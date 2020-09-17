% create a bunch of randomly generated 2D trajectories
tic;
trajCounter = size(trajData,1);

for k = 1:numNoiseTraj
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

    % store the new traj
    trajCounter = trajCounter + 1;
    trajData(trajCounter,1) = mat2cell(sampleTraj,size(sampleTraj,1),size(sampleTraj,2));
    tmpTrajStartEnd = [sampleTraj(1,:); sampleTraj(currNumVertices,:)];
    trajData(trajCounter,2) = mat2cell(tmpTrajStartEnd,size(tmpTrajStartEnd,1),size(tmpTrajStartEnd,2));

end
timeElapsed = toc;