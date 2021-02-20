% Get Pruned S1 for NN search

function SubInvRNNPrune(cNodeID,tau,Q,Qid)

    global clusterNode S1 distCalcCnt nodeCheckCnt trajStrData
    global sCellCheck sDPCalls sSPVert

    nodeCheckCnt = nodeCheckCnt + 1;
    centerTrajID = clusterNode(cNodeID,6);
    centreTraj = trajStrData(centerTrajID).traj; % get center traj
    crad = clusterNode(cNodeID,4);

    [ans,totCellCheck,totDPCalls,totSPVert] = GetSubDP(Q,centreTraj,tau+crad);
    sCellCheck = sCellCheck + totCellCheck;
    sDPCalls = sDPCalls + totDPCalls;
    sSPVert = sSPVert + totSPVert;
    distCalcCnt = distCalcCnt + 1;
    if ans == 1 % some nodes may be in result set
        if clusterNode(cNodeID,5) == 1 % at leaf 
            S1(end+1,:) = [cNodeID 0 tau+crad]; % traj is in result set
        else % at parent node, some or all of the cluster may be in results
            if tau-crad > 0 % check if all of cluster is in result set
                [ans2,totCellCheck,totDPCalls,totSPVert] = GetSubDP(Q,centreTraj,tau-crad);
                sCellCheck = sCellCheck + totCellCheck;
                sDPCalls = sDPCalls + totDPCalls;
                sSPVert = sSPVert + totSPVert;
                distCalcCnt = distCalcCnt + 1;
            else % some of cluster may still be in result set
                ans2 = 0;
            end
            if ans2 == 1 % all leafs beneath this node are in results
                RNNGetAllLeafs(cNodeID,Q,Qid,tau-crad);
            else % some leafs beneath this node may be in results
                SubInvRNNPrune(clusterNode(cNodeID,2),tau,Q,Qid);
                SubInvRNNPrune(clusterNode(cNodeID,3),tau,Q,Qid);
            end
        end
    end
    
end