
% insType:
% 1 = exact NN
% 2 = implicit NN
% 3 = standard (method from BS-Tree and M-Tree)

function RandomSampleInsert(numInsertTraj,insType)

    global numInsCFD numInsDP queryTraj insertTrajData trajData
    global clusterNode clusterTrajNode szNode 

    tic;
    numInsCFD = 0;
    numInsDP = 0;

    % create the "query" trajectories, which will be the list of traj in insertTrajData
    szQ = size(queryTraj,1); % size inital query traj
    queryTraj(szQ+1:szQ+numInsertTraj,1:2) = insertTrajData(:,1:2);
    queryTraj(szQ+1:szQ+numInsertTraj,20:24) = insertTrajData(:,3:7);

    % append the inserted traj to trajData
    szT = size(trajData,1);
    trajData = [trajData; insertTrajData];
    
    % pre-allocate memory (faster)
    szNode = size(clusterNode,1);
    szNodeInsert = (2 * numInsertTraj) - 1;
    clusterNode(szNode+1:szNode+szNodeInsert,7) = 0;
    
    szClusterTrajNode = size(clusterTrajNode,1);
    clusterTrajNode(szClusterTrajNode+1:szClusterTrajNode+numInsertTraj,1) = 0;

    % Insert each traj in queryTraj
    h = waitbar(0, 'Insert');
    
    for i = szQ+1:szQ+numInsertTraj  % do NN search for each query traj

        newTrajID = szT + i - szQ;

        InsertCCT(i,newTrajID,insType);

        if mod(i,100) == 0
            X = ['Insert: ',num2str(i-szQ),'/',num2str(numInsertTraj)];
            waitbar((i-szQ)/numInsertTraj, h, X);
        end
    end

    close(h);

    % clear the insert traj list
    insertTrajData = [];

    % clear the insert "query" trajectories
    queryTraj(szQ+1:szQ+numInsertTraj,:) = [];
    
    timeElapsed = toc;

    disp(['------------------']);
    disp(['numInsCFD: ',num2str(numInsCFD)]);
    disp(['numInsDP: ',num2str(numInsDP)]);
    disp(['Runtime per trajectory (ms): ',num2str(timeElapsed/numInsertTraj*1000)]);
end