% Function ConstructPointCCT
%
% 1) Calculate bounding box that surrounds all input trajectories, and then
% create the set of random points within the bounding box. The points 
% represent the centre of a ball (the code can be modified so that this 
% represents a square box as well).
%
% 2) Construct the random point CCT
%
% Input variables:
%
% pointPlaceMethod
% 1 = randomly place discs anywhere in bounding box
% 2 = randomly place discs within a grid cell
% 3 = place disc centre in centre of grid cell
%    
% discType
% 1 = small
% 2 = medium
% 3 = large
% 4 - X-large
% 5 - XX-large
% 6 - XXX-Large
%
% pctReach
% grid square length will be a percent of the reach

function ConstructPointCCT(varList)

    global inputSet randPts clusterPointNode clusterPointNodeToID h currNodeID totNode randPtsBallRad ballSet
    
    rng('default'); % reset the random seed so that experiments are reproducable

    tic;

    % Calculate bounding box that surrounds all input trajectories
    P = cell2mat(inputSet(1,3));
    numDim = size(P,2); % number of dimensions in traj dataset
    BBMin = Inf;
    BBMax = 0;
    for i = 1:size(inputSet,1)
        for j = 3:size(inputSet,2)
            P = cell2mat(inputSet(i,j));
            if isempty(P) == false
                BBMin = min(min(P),BBMin);
                BBMax = max(max(P),BBMax);
            end
        end
    end
    
    % define ball-sets
    ballSet = [];
    ballSet(1,1) = 1;
    ballSet(2,1) = 2;
    ballSet(3,1) = 3;
    ballSet(4,1) = 4;
    ballSet(5,1) = 5;
    ballSet(6,1) = 6;
    ballSet(7,1) = 7;
    ballSet(8,1) = 8;
    ballSet(9,1:2) = [1 2];
    ballSet(10,1:2) = [3 4];
    ballSet(11,1:2) = [5 6];
    ballSet(12,1:2) = [7 8];
    ballSet(13,1:4) = [1 2 3 4];
    ballSet(14,1:4) = [5 6 7 8];
    ballSet(15,1:8) = [1 2 3 4 5 6 7 8];

    % compute average traj reach
    sumReach = 0;
    numTraj = 0;
    for i = 1:size(inputSet,1)
        for j = 3:size(inputSet,2)
            P = cell2mat(inputSet(i,j));
            if isempty(P) == false
                sumReach = sumReach + TrajReach(P);
                numTraj = numTraj + 1;
            end
        end
    end
    avgReach = sumReach / numTraj;
    
    % create the sets of discs - i.e. populate randPts and randPtsBallRad variables
    randPts = [];
    randPtsBallRad = [];
    for j=1:size(varList,1)
        pointPlaceMethod = varList(j,1);
        discType = varList(j,2);
        pctReach = varList(j,3);
    
        gridSqLen = avgReach * pctReach;

        if discType == 1
            discRad = (gridSqLen/2) - (0.25 * gridSqLen/2);
        elseif discType == 2
            discRad = (gridSqLen/2);
        elseif discType == 3
            discRad = (gridSqLen/2) + (0.25 * gridSqLen/2);
        elseif discType == 4
            discRad = gridSqLen;
        elseif discType == 5
            discRad = gridSqLen * 2;
        elseif discType == 6
            discRad = gridSqLen * 4;
        elseif discType == 7
            discRad = gridSqLen * 8;
        end

        % compute number of points per dimension
        numPointPerDim = ceil((BBMax - BBMin) / gridSqLen); 

        if pointPlaceMethod == 1
            % compute number of random points
            numPts = round(prod(numPointPerDim)); % just multiply each of the vectors
            numPts = numPts + (8 - mod(numPts,8)); % make numPts a factor of 8

            % create random points
            BBMaxMin = BBMax - BBMin;
            tmpRandPts = BBMaxMin .* rand(numPts,numDim);
            tmpRandPts = tmpRandPts + BBMin;

        elseif pointPlaceMethod == 2  || pointPlaceMethod == 3
            % compute the point coordinates for each dimension, and store in cell array
            for i = 1:numDim
                inputV{i} = (gridSqLen .* (1:numPointPerDim(i))) + BBMin(i) - (gridSqLen / 2);
            end

            % now generate the points for all possibilites of the coordinates in
            % each dimension
            processV = cell(numel(inputV), 1);[processV{:}] = ndgrid(inputV{:}); % prepare for ndgrid, call ndgrid for arbitrary number of vector dimensions
            processV = cellfun(@(x) x(:), processV, 'UniformOutput', false); % convert vectors
            tmpRandPts = [processV{:}]; % generate output

            if pointPlaceMethod == 2 % randonly perturb each point by up to 1/4 radius
                tmpRandPts = (tmpRandPts - (0.25 * discRad))  +  ((0.5 * discRad) .* rand(size(tmpRandPts,1),numDim));
            end
        end
        szTmp = size(tmpRandPts,1);
        randPts(end+1:end+szTmp,:) = tmpRandPts;

        % set the ball radii
        randPtsBallRad(end+1:end+szTmp) = discRad;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Construct the random point CCT
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    h = waitbar(0, 'Build Point CCT');

    totalPoints = size(randPts,1);  % get number of points to process
    totNode = (totalPoints * 2) - 1;  % calc total nodes
    centerId = 0;
    currDist = 0;
    largestRSize = 0;
    furthestPointID = 0;
    currNodeID = 0;
    pointDistList = [];
    clusterPointNode = [];
    clusterPointNodeToID = [];
    tmpIndex = 0;

    clusterPointNode(totNode,7) = 0;
    clusterPointNodeToID(totalPoints,1) = 0;

    % randomly choose a point as the first center
    centerId = randi(totalPoints,1);
    % centerId = 1;

    % process top node cluster
    % compare distance from center point to all other points
    for j = 1:totalPoints 
        if j == centerId % we are comparing the point to itself
            currDist = randPtsBallRad(j);
        else
            currDist = CalcPointDist(randPts(centerId,:), randPts(j,:)) + randPtsBallRad(j);
        end  
        pointDistList = [pointDistList; j currDist];
    end

    % get max Rsize and associated ID
    [largestRSize,tmpIndex] = max(pointDistList(:,2));
    furthestPointID = pointDistList(tmpIndex,1);

    % save info to clusterPointNode
    currNodeID = 1;
    clusterPointNode(currNodeID,:) = [0 0 0 largestRSize totalPoints centerId furthestPointID];

    X = ['Build Point CCT ',num2str(currNodeID),'/',num2str(totNode)];
    waitbar(currNodeID/totNode, h, X);

    % now call function to recursively split node into 2-k clusters
    SplitPointNode(currNodeID,pointDistList);

    close(h);

    timeElapsed = toc;
    disp(['ConstructPointCCT time elapsed: ',num2str(timeElapsed)]);

end
