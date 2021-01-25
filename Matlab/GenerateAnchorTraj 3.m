% Create a small number of anchor trajectories. 
% Then compare each anchor traj to all traj in trajStrData
% and save the distances in sorted lists.

tic;
anchorTraj = {[]};

for i = 1:numAnchorTraj

    if genAnchorType == 1
        % randomly grab an existing traj
        currAnchor = trajStrData(randi(totalTraj)).traj;        
        % randomize the vertices a bit
        currAnchor = currAnchor + ((-2 + (2+2).*rand(2,size(currAnchor,1)))');       
        % randomize the location a bit (translate it to a slightly different location
        currAnchor = currAnchor + (-2 + (2+2).*rand(1));
    elseif genAnchorType == 2
        % create a random traj
        currNumVertices = randi([floor(avgNumVertices/2) floor(avgNumVertices*1.5)] ,1);
        sampleTraj = [];
        for x = 1:currNumVertices
            if x==1
                xPos = 100*rand;
                yPos = 100*rand;
            elseif x==2
                xPos = (-3 + (3+3) *rand) + sampleTraj(x-1,1);
                yPos = (-3 + (3+3) *rand) + sampleTraj(x-1,2);
            else
                xPos = (-3 + (3+3) *rand) + (sampleTraj(x-1,1)) + 0.8.*(sampleTraj(x-1,1) - sampleTraj(x-2,1));
                yPos = (-3 + (3+3) *rand) + (sampleTraj(x-1,2)) + 0.8.*(sampleTraj(x-1,2) - sampleTraj(x-2,2));
            end  
            sampleTraj(x,:) = [xPos yPos];
        end
        currAnchor = sampleTraj;
    elseif genAnchorType == 3        
        % create tiny traj around the "edges" of the space
        if i == 1
            currAnchor = [50,-30;51,-30];
        elseif i == 2
            currAnchor = [50, 150; 51, 150];
        elseif i == 3
            currAnchor = [-30, 20; -30, 21];
        elseif i == 4
            currAnchor = [-30, 80; -30, 81];
        elseif i == 5
            currAnchor = [150, 20; 150, 21];
        else
            currAnchor = [150, 80; 150, 81];
        end
    elseif genAnchorType == 4 % copy an existing traj in trajStrData and translate it a bit
        % randomly grab an existing traj
        currAnchor = trajStrData(randi(totalTraj)).traj;  
        currAnchor = currAnchor + (-4 + (4+4).*rand(1));
    elseif genAnchorType == 5 % copy an existing traj and keep same location
        % randomly grab an existing traj
        currAnchor = trajStrData(randi(totalTraj)).traj;  
    elseif genAnchorType == 6        
        % create tiny traj around the "edges" of the space
        if i == 1
            currAnchor = [20,-20; 20,-20];
        elseif i == 2
            currAnchor = [80,-20; 80,-20];
        elseif i == 3
            currAnchor = [20,120; 20,120];
        elseif i == 4
            currAnchor = [80,120; 80,120];
        elseif i == 5
            currAnchor = [-20,80; -20,80];
        elseif i == 6
            currAnchor = [120,80; 120,80];
        elseif i == 7
            currAnchor = [-20,20; -20,20];
        elseif i == 8
            currAnchor = [120,20; 120,20];
        else
            currAnchor = trajStrData(randi(totalTraj)).traj;  
            currAnchor = currAnchor + (-4 + (4+4).*rand(1));
        end
    end
    % store it as an anchor traj
    anchorTraj(i,1) = mat2cell(currAnchor,size(currAnchor,1),size(currAnchor,2));
    
    % compare the distance from anchor traj to all of the traj in trajStrData
    currAnchorList = zeros(totalTraj,2);
    for j = 1:totalTraj
        currTraj = trajStrData(j).traj;
        currDist = DiscreteFrechetDist(currAnchor,currTraj);
        currAnchorList(j,1) = j;
        currAnchorList(j,2) = currDist;       
    end  
    
    % update the anchor traj with sorted distance list
    currAnchorList = sortrows(currAnchorList,2);
    anchorTraj(i,2) = mat2cell(currAnchorList,[totalTraj],[2]);
end
timeElapsed = toc;