% Query data preprocessing
% 1) calc bounding boxes
% 2) calc simplification prune
% 3) calc padding

tic;
    
% 1) calc bounding boxes
for i = 1:size(queryTraj,1)
    P = cell2mat(queryTraj(i,1));
    sPDim = size(P,2);

    BB = ComputeBB(P,0);
    queryTraj(i,20) = mat2cell(BB,size(BB,1),size(BB,2));
    
    if (sPDim == 2 || sPDim == 3)  % only compute BB for 2-d and 3-d traj
        BB = ComputeBB(P,22.5);
        queryTraj(i,21) = mat2cell(BB,size(BB,1),size(BB,2));
        BB = ComputeBB(P,45);
        queryTraj(i,22) = mat2cell(BB,size(BB,1),size(BB,2));
    end
end

timeElapsed = toc;

% 2) calc simplification prune

tic;
h = waitbar(0, 'Simplification Prune Pre-compute Step');
sP = size(queryTraj,1);

for k = 1:sP % for each trajectory in dataset do
    % get P and P'
    sampleTraj = cell2mat(queryTraj(k,1)); % P
    currTraj = [sampleTraj(1,:); sampleTraj(end,:)]; % P'
    
    % calc cont frechet dist between P and P'
    Eq = ContFrechet(sampleTraj,currTraj);

    % store result
    queryTraj(k,23) = mat2cell(Eq,size(Eq,1),size(Eq,2));

    if mod(k,100) == 0
        X = ['Simplification Prune Pre-compute Step ',num2str(k),'/',num2str(sP)];
        waitbar(k/sP, h, X);
    end
    
end

% 3) calc padding
for k = 1:sP % for each trajectory in dataset do
    
    P = cell2mat(queryTraj(k,1));
    padP = PadTraj(P,2);
    queryTraj(k,24) = mat2cell(padP,size(padP,1),size(padP,2));
    
end

close(h);
timeElapsed = toc;