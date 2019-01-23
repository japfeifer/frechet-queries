% Traj data variables
numDiffTraj = 40;    % Traj that are different from each other
numSimilarTraj = 10;  % For each Diff traj, create trajectories that are similar to it
totalTraj = numDiffTraj * numSimilarTraj;
avgNumVertices = 15;  % average vertices per traj

% Anchor Traj Variables
numAnchorTraj = 8;
genAnchorType = 6; % 1 = slightly random & close, 2 = random
                   % 3 = outline, 4 = same & close, 5 = same, 6 = test

% Query Traj Variables
numQueryTraj = 20;
genQueryType = 3; % 1 = random, 2 = similar, 3 = same
Emax = 15;
Emin = 8;
numAnchorTrajCompare = numAnchorTraj;

% Type of frechet distance to calc
doDiscreteFrechetDist = true;