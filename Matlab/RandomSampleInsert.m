
% insType:
% 1 = exact NN
% 2 = implicit NN
% 3 = standard (method from BS-Tree and M-Tree)

function RandomSampleInsert(numInsertTraj,insType)

    global numInsCFD numInsDP insertTrajData trajStrData queryStrData
    global clusterNode clusterTrajNode szNode 

    if numInsertTraj > 0
        tic;
        numInsCFD = 0;
        numInsDP = 0;

        % create the "query" trajectories, which will be the list of traj in insertTrajData
        szQ = size(queryStrData,2); % size inital query traj
        for i = 1:numInsertTraj
            queryStrData(szQ+i).traj = insertTrajData(i).traj;
            queryStrData(szQ+i).se = insertTrajData(i).se;
            queryStrData(szQ+i).bb1 = insertTrajData(i).bb1;
            queryStrData(szQ+i).bb2 = insertTrajData(i).bb2;
            queryStrData(szQ+i).bb3 = insertTrajData(i).bb3;
            queryStrData(szQ+i).st = insertTrajData(i).st;
        end

        % append the inserted traj to trajStrData
        szT = size(trajStrData,2);
        for i = 1:numInsertTraj
            trajStrData(szT+i).traj = insertTrajData(i).traj;
            trajStrData(szT+i).se = insertTrajData(i).se;
            trajStrData(szT+i).bb1 = insertTrajData(i).bb1;
            trajStrData(szT+i).bb2 = insertTrajData(i).bb2;
            trajStrData(szT+i).bb3 = insertTrajData(i).bb3;
            trajStrData(szT+i).st = insertTrajData(i).st;
        end

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
        queryStrData(szQ+1:szQ+numInsertTraj) = [];

        timeElapsed = toc;

        disp(['------------------']);
        disp(['numInsCFD: ',num2str(numInsCFD)]);
        disp(['numInsDP: ',num2str(numInsDP)]);
        disp(['Runtime per trajectory (ms): ',num2str(timeElapsed/numInsertTraj*1000)]);
    end
end