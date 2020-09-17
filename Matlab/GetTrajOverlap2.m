function GetTrajOverlap2(cNodeID,Qid,Q)

    global clusterNode trajData allNodesCnt

    cID = clusterNode(cNodeID,6);
    cTraj = cell2mat(trajData(cID,1)); % get center traj 
    cRad = clusterNode(cNodeID,4);
    lowBnd1 = GetBestConstLB(cTraj,Q,Inf,2,cID,Qid);
    
    cRad = round(cRad,9);
    lowBnd1 = round(lowBnd1,9);
    
%     disp(['Qid:',num2str(Qid),' cRad',num2str(cRad),' lowBnd1:',num2str(lowBnd1)]);
    
    if lowBnd1 <= cRad
        allNodesCnt = allNodesCnt + 1;
        child1NodeID = clusterNode(cNodeID,2);
        child2NodeID = clusterNode(cNodeID,3);
        if clusterNode(child1NodeID,5) ~= 1 % if child is not a leaf
            GetTrajOverlap2(child1NodeID,Qid,Q);
        end
        if clusterNode(child2NodeID,5) ~= 1 % if child is not a leaf
            GetTrajOverlap2(child2NodeID,Qid,Q);
        end
    end

end