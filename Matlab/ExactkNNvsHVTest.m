% ExactkNNvsHVTest - compares exact Frechet kNN to hyper vector NN results
%


tic;

kNum = 5;

h = waitbar(0, 'Exact kNN Vs HV NN Test');

for i = 1:size(queryTraj,1)  % do kNN search for each query traj
    
    searchStat = [];
    
    kNN(i,1,kNum,0); % exact kNN search

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