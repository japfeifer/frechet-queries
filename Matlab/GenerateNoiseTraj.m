% create a bunch of randomly generated 2D trajectories
tic;
trajCounter = size(trajStrData,2);

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
    trajStrData(trajCounter).traj = sampleTraj;
    tmpTrajStartEnd = [sampleTraj(1,:); sampleTraj(currNumVertices,:)];
    trajStrData(trajCounter).se = tmpTrajStartEnd;

end
timeElapsed = toc;