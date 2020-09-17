function RNNGetAllLeafs(cNodeID,Q,Qid,upBnd)

    global clusterNode S1 nodeCheckCnt cntInClus 

    if clusterNode(cNodeID,5) == 1 % at leaf 
        S1(end+1,:) = [cNodeID 0 upBnd];
        cntInClus = cntInClus + 1;
    else
        nodeCheckCnt = nodeCheckCnt + 1;
        RNNGetAllLeafs(clusterNode(cNodeID,2),Q,Qid,upBnd);
        nodeCheckCnt = nodeCheckCnt + 1;
        RNNGetAllLeafs(clusterNode(cNodeID,3),Q,Qid,upBnd);
    end

end