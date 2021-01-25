% Test cont frechet runtime

tic;

numDistComp = 100;  % number of distance computations
dSize = size(trajStrData,2);

for i = 1:numDistComp % number of different queries

    P = trajStrData(randi(dSize,1)).traj; % randomly choose P
    Q = trajStrData(randi(dSize,1)).traj; % randomly choose Q
    dist1 = ContFrechet(P,Q); % perform cont frechet computation

end

timeElapsed = toc;

disp(['Total time elapsed: ',num2str(timeElapsed)]);
disp(['Average time per cont frechet computation (in seconds): ',num2str(timeElapsed/numDistComp)]);