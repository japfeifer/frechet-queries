function sameTrajMeasure = GetCCTFindTraj()

    global clusterNode trajStrData
    
    PSize = size(trajStrData,2);
    sameTrajList = [];
    
    rng('default'); % reset the random seed so that experiments are reproducable
    randOrder = randperm(numel(trajStrData(:,2)));
    if PSize > 1000
        randOrder = randOrder(1:1000);
        PSize = 1000;
    end
    
    h = waitbar(0, 'GetCCTFindTraj');
    
    for i=1:PSize
        
        Qid = randOrder(i);
        Q = trajStrData(Qid).traj;
        cNodeID = 1;
        
        while clusterNode(cNodeID,5) ~= 1
            child1NodeID = clusterNode(cNodeID,2);
            C1id = clusterNode(child1NodeID,6);
            cTraj = trajStrData(C1id).traj; % get center traj 
            child1Crad = clusterNode(child1NodeID,4);
            lowBnd1 = GetBestConstLB(cTraj,Q,Inf,2,C1id,Qid);

            child2NodeID = clusterNode(cNodeID,3);
            C2id = clusterNode(child2NodeID,6);
            cTraj = trajStrData(C2id).traj; % get center traj 
            child2Crad = clusterNode(child2NodeID,4);
            lowBnd2 = GetBestConstLB(cTraj,Q,Inf,2,C2id,Qid);

            if lowBnd1 < lowBnd2
                cNodeID = child1NodeID;
                leafTrajID = C1id;
            else
                cNodeID = child2NodeID;
                leafTrajID = C2id;
            end
        end
        
        if Qid == leafTrajID
            sameTrajList(end+1) = 0;
        else
            sameTrajList(end+1) = 1;
        end
        
        if mod(i,100) == 0
            X = ['GetCCTFindTraj: ',num2str(i),'/',num2str(PSize)];
            waitbar(i/PSize, h, X);
        end
        
    end
    close(h);
    sameTrajMeasure = mean(sameTrajList);
end