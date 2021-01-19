% Trajectory data preprocessing:
% 1) handle traj that are a single vertex
% 2) calc traj start/end info
% 3) calc bounding boxes
% 4) calc simplification prune

numTraj = size(trajStrData,2);

% 1) if the trajectory is a single vertex, add another duplicate vertex 
% as the code assumes at least two vertices per trajectory.
for i=1:numTraj
    currTraj = trajStrData(i).traj;
    if size(currTraj,1) == 1 % simplified traj is only a single vertex
        currTraj = [currTraj; currTraj]; % so add one more vertex 
        trajStrData(i).traj = currTraj;
    end
end

% 2) generate  traj start/end info - the synthetic generator creates this
% automatically but this is needed when loading in real-world data
for i=1:numTraj
    currTraj = trajStrData(i).traj;
    currTrajSize = size(currTraj,1);
	currTrajStartEnd = [currTraj(1,:); currTraj(currTrajSize,:)];
    trajStrData(i).se = currTrajStartEnd;
end

% 3) calculate traj data boundng box
tic;
h = waitbar(0, 'Compute Bounding Box');
for i = 1:numTraj % calc bounding box for each traj
    P = trajStrData(i).traj;
    sPDim = size(P,2);
    BB = ComputeBB(P,0);
    trajStrData(i).bb1 = BB;
    if (sPDim == 2 || sPDim == 3)  % only compute BB for 2-d and 3-d traj
        BB = ComputeBB(P,22.5);
        trajStrData(i).bb2 = BB;
        BB = ComputeBB(P,45);
        trajStrData(i).bb3 = BB;
    end
    if mod(i,10000) == 0
        X = ['Compute Bounding Box ',num2str(i),'/',num2str(numTraj)];
        waitbar(i/numTraj, h, X);
    end
end
close(h);
timeElapsed = toc;

% 4) Simplification Prune Pre-compute Step
% Precompute frechet dist from P to P' for each curve in trajData.
% p' is an edge that is comprised of the first and last vertex of P.

tic;
h = waitbar(0, 'Simplification Prune Pre-compute Step');
for i = 1:numTraj % for each trajectory in dataset do
    % get P and P'
    sampleTraj = trajStrData(i).traj; % P
    currTraj = trajStrData(i).se;   % P'
    Eq = ContFrechet(sampleTraj,currTraj,2,0); % calc cont frechet dist between P and P'
    trajStrData(i).st = Eq; % store result
    if mod(i,10000) == 0
        X = ['Simplification Prune Pre-compute Step ',num2str(i),'/',num2str(numTraj)];
        waitbar(i/numTraj, h, X);
    end
end
close(h);
timeElapsed = toc;

% % padding
% for k = 1:sP % for each trajectory in dataset do
%     
%     P = cell2mat(trajData(k,1));
%     padP = PadTraj(P,2);
%     trajData(k,7) = mat2cell(padP,size(padP,1),size(padP,2));
%     
% end

