% ExactNNvsHVTest - compares exact Frechet NN to hyper vector NN results
%

tic;

eAdd = 0; % run an exact NN search

h = waitbar(0, 'Exact NN Vs HV NN Test');

for k = 1:size(queryTraj,1)  % do NN search for each query traj
    bestCenterTraj = 0;
    bestDist = 0;
    numCFD = 0;
    numDP = 0;
    numCandCurve = 0;
    foundTraj = false;
    
    NN(i,1,eAdd); % get exact NN
    
%%%%%%%%%
% have to add code to grab bestCenterTraj and calc exact bestDist
%%%%%%%%

    % now get HV NN
    qv = EncodeTrajToHV(currQueryTraj);
    
    % find input traj with closest cosine distance    
    bestCosDist = -1;
    for i = 1:size(trajHyperVector,1)
        CosDist = VectorCosDist(qv,trajHyperVector(i,:));
        if CosDist > bestCosDist
            bestCosDist = CosDist;
            bestTrajID = i;
        end
    end
    
    % store results
    queryTraj(k,15) = num2cell(bestTrajID);
    queryTraj(k,16) = num2cell(bestCosDist);
    
    if mod(k,10) == 0
        X = ['Exact NN Vs HV NN Test ',num2str(k),'/',num2str(numQueryTraj)];
        waitbar(k/numQueryTraj, h, X);
    end
end

close(h);
timeElapsed = toc;