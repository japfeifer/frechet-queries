function [newLB, newUB, newAlpha] = ImproveBound(nodeID,oldLB,oldUB,Q,QID,alpha)

    global trajData clusterNode
    
    parentNodeID = clusterNode(nodeID,1);
    parentRad = clusterNode(parentNodeID,4);
    leafTrajID = clusterNode(nodeID,6);
    
    if parentNodeID ~= 0
        if clusterNode(parentNodeID,6) == leafTrajID
            PID = clusterNode(parentNodeID,7);
        else
            PID = clusterNode(parentNodeID,6);
        end
        P = cell2mat(trajData(PID,1));
        LB = GetBestConstLB(P,Q,Inf,1,PID,QID) - parentRad;
        UB = GetBestUpperBound(P,Q,1,PID,QID) + parentRad;
        newAlpha = GetBestLinearLBDP(P,Q,alpha+parentRad,1,PID,QID);
        newLB = max(oldLB,LB);
        newUB = min(oldUB,UB);
    else 
        newLB = oldLB;
        newUB = oldUB;
        newAlpha = false;
    end

%     if newLB > oldLB
%         disp(['Old LB: ',num2str(oldLB),', New LB: ',num2str(newLB)]);
%     end
%     if newUB < oldUB
%         disp(['Old UB: ',num2str(oldUB),', New UB: ',num2str(newUB)]);
%     end
%     if newAlpha == true
%          disp(['newAlpha is true']);
%     end

end