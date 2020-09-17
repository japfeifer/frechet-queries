function [trajOverlapMean, trajOverlapStd] = GetCCTTrajOverlap()

    global clusterNode trajData allNodesCnt clusterTrajNode trajOverlapNodesCnt trajOverlapList trajOverlapNodesCnt2
    
    PSize = size(trajData,1);
    trajOverlapList = [];
    trajOverlapNodesCnt = [];
    
    rng('default'); % reset the random seed so that experiments are reproducable
    randOrder = randperm(numel(trajData(:,1)));
    if PSize > 1000
        randOrder = randOrder(1:1000);
        PSize = 1000;
    end
    
    h = waitbar(0, 'GetCCTTrajOverlap');
    
    for i=1:PSize

        Qid = randOrder(i);
        Q = cell2mat(trajData(Qid,1));
        cNodeID = clusterTrajNode(Qid); % leaf node
        parentCnt = 0;
        
        % count number of parents to root for this leaf
        while clusterNode(cNodeID,1) ~= 0
            cNodeID = clusterNode(cNodeID,1);
            parentCnt = parentCnt + 1;
        end
        
        % get all nodes within LB range
        allNodesCnt = 0;
        GetTrajOverlap2(1,Qid,Q);
        
        if allNodesCnt < parentCnt
            error('allNodesCnt < parentCnt');
        end
        
        trajOverlapList(end+1) = (allNodesCnt - parentCnt) / allNodesCnt;
        
        trajOverlapNodesCnt(end+1) = allNodesCnt;
       
        if mod(i,100) == 0
            X = ['GetCCTTrajOverlap: ',num2str(i),'/',num2str(PSize)];
            waitbar(i/PSize, h, X);
        end
        
    end
    close(h);
    trajOverlapMean = mean(trajOverlapList);
    trajOverlapStd = std(trajOverlapList);
end