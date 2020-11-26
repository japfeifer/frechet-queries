function RNNGetAllLeafsOld(cNodeID,Q,Qid,upBnd)

    global clusterNode prunedNodes nodeCheckCnt cntInClus 

    if clusterNode(cNodeID,5) == 1 % at leaf 
        prunedNodes(end+1,:) = [cNodeID 0 upBnd];
        cntInClus = cntInClus + 1;
    else
        nodeCheckCnt = nodeCheckCnt + 1;
        RNNGetAllLeafsOld(clusterNode(cNodeID,2),Q,Qid,upBnd);
        nodeCheckCnt = nodeCheckCnt + 1;
        RNNGetAllLeafsOld(clusterNode(cNodeID,3),Q,Qid,upBnd);
    end

end