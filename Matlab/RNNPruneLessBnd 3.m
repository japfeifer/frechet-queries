% Get Pruned Nodes for RNN search.
% 
% Find all trajetories where their lower bound < range value (tau)
% Only have to search clusters where the node traj centre lower bound <=
% tau + node radius.

function RNNPruneLessBnd(cNodeID,tau,Q,Qid,prevCentreTrajID,prevLowBnd,doCnt)

    global clusterNode S1 nodeCheckCnt trajStrData distCalcCnt
    global cntNF cntConLB cntUBClust

    nodeCheckCnt = nodeCheckCnt + 1;
    centerTrajID = clusterNode(cNodeID,6);
    centreTraj = trajStrData(centerTrajID).traj; % get center traj 
    
    % get lower bound
    if prevCentreTrajID == centerTrajID % this centre Traj is same as parent centre Traj
        lowBnd = prevLowBnd;
    else % have to calc constant time lowBnd distance
        lowBnd = GetBestConstLBLessBnd(centreTraj,Q,tau + clusterNode(cNodeID,4),1,centerTrajID,Qid);
        distCalcCnt = distCalcCnt + 1;
    end
    
    if clusterNode(cNodeID,5) == 1 % at leaf 
        if lowBnd <= tau % traj is a potential candidate for result set
            cntConLB = cntConLB + 1;
            upBnd = GetBestUpperBoundLessBnd(centreTraj,Q,1,centerTrajID,Qid,tau,doCnt);
            if upBnd <= tau
                S1(end+1,:) = [cNodeID lowBnd upBnd];
            else
%                 linearLB = GetBestLinearLBDP(centreTraj,Q,tau,1,centerTrajID,Qid); 
%                 if linearLB == false
                    S1(end+1,:) = [cNodeID lowBnd upBnd];
%                 else
%                     cntNF = cntNF + 1;
%                 end
            end
        end
    elseif lowBnd <= tau + clusterNode(cNodeID,4) % some or all of the cluster may be in results
        
        % heuristic determines if we do upper bound check
        if lowBnd * 1.25 + clusterNode(cNodeID,4) < tau 
            upBnd = GetBestUpperBoundLessBnd(centreTraj,Q,1,centerTrajID,Qid, tau - clusterNode(cNodeID,4));
            cntUBClust = cntUBClust + 1;
        else
            upBnd = Inf;
        end
        
        if upBnd + clusterNode(cNodeID,4) <= tau % all leafs beneath this node are in results
            RNNGetAllLeafs(cNodeID,Q,Qid,upBnd + clusterNode(cNodeID,4));
        else % some leafs beneath this node may be in results
            RNNPruneLessBnd(clusterNode(cNodeID,2),tau,Q,Qid,centerTrajID,lowBnd,doCnt);
            RNNPruneLessBnd(clusterNode(cNodeID,3),tau,Q,Qid,centerTrajID,lowBnd,doCnt);
        end
    end
end