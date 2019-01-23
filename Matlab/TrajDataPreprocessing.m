% Trajectory data preprocessing
% 1) calc traj start/end info
% 2) calc bounding boxes
% 3) calc simplification prune
% 4) padding

% 0) if the trajectory is a single vertex, add another duplicate vertex 
% as the code assumes at least two vertices per trajectory.

for i=1:size(trajData,1)
    currTraj = cell2mat(trajData(i,1));
    if size(currTraj,1) == 1 % simplified traj is only a single vertex
        currTraj = [currTraj; currTraj]; % so add one more vertex 
        trajData(i,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
    end
end

% 1) generate  traj start/end info - the synthetic generator creates this
% automatically but this is needed when loading in real-world data

for i=1:size(trajData,1)
    currTraj = cell2mat(trajData(i,1));
    currTrajSize = size(currTraj,1);
	currTrajStartEnd = [currTraj(1,:); currTraj(currTrajSize,:)];
    trajData(i,2) = mat2cell(currTrajStartEnd,size(currTrajStartEnd,1),size(currTrajStartEnd,2));
end

% 2) calculate traj data boundng box

tic;
    
for i = 1:size(trajData,1) % calc bounding box for each traj
    P = cell2mat(trajData(i,1));
    sPDim = size(P,2);

    BB = ComputeBB(P,0);
    trajData(i,3) = mat2cell(BB,size(BB,1),size(BB,2));
    
    if (sPDim == 2 || sPDim == 3)  % only compute BB for 2-d and 3-d traj
        BB = ComputeBB(P,22.5);
        trajData(i,4) = mat2cell(BB,size(BB,1),size(BB,2));
        BB = ComputeBB(P,45);
        trajData(i,5) = mat2cell(BB,size(BB,1),size(BB,2));
    end
end

timeElapsed = toc;

% 3) Simplification Prune Pre-compute Step
% Precompute frechet dist from P to P' for each curve in trajData.
% p' is an edge that is comprised of the first and last vertex of P.

tic;
h = waitbar(0, 'Simplification Prune Pre-compute Step');
sP = size(trajData,1);

for k = 1:sP % for each trajectory in dataset do
    % get P and P'
    sampleTraj = cell2mat(trajData(k,1)); % P
    currTraj = cell2mat(trajData(k,2));   % P'
    
    % calc cont frechet dist between P and P'
    Eq = ContFrechet(sampleTraj,currTraj);

    % store result
    trajData(k,6) = mat2cell(Eq,size(Eq,1),size(Eq,2));

    if mod(k,100) == 0
        X = ['Simplification Prune Pre-compute Step ',num2str(k),'/',num2str(sP)];
        waitbar(k/sP, h, X);
    end
    
end

% padding
for k = 1:sP % for each trajectory in dataset do
    
    P = cell2mat(trajData(k,1));
    padP = PadTraj(P,2);
    trajData(k,7) = mat2cell(padP,size(padP,1),size(padP,2));
    
end

close(h);
timeElapsed = toc;