function stabOrder = GetTrajectoryStabOrder(P)
    
    global pointPrunedNodes clusterPointNode randPtsBallRad randPts
    global tEncode timeEncode
    
    szP = size(P,1);
    stabOrder = [];
    % for each edge in the traj, get set of intersecting discs, then determine
    % stabbing order 
    for i = 1:size(P,1) - 1
        % get intersecting discs
        pointPrunedNodes = [];
        p1 = P(i,:);
        p2 = P(i+1,:);
        
        tEncode = tic;
        GetPrunedSegmentNodes(1,p1,p2);
        timeEncode = timeEncode + toc(tEncode);

        % get stab order of intersecting discs
        if isempty(pointPrunedNodes) == false
            edgeStabOrder = [];
            for j = 1:size(pointPrunedNodes,2)
                % get node radius
                nodeID = pointPrunedNodes(j);
                r = clusterPointNode(nodeID,4);
                % get node centre point coordinates
                c = randPts(clusterPointNode(nodeID,6),:);
                % get the point on edge that stabs disc
                s = StabPoint(p1,p2,c,r);
                if isempty(s) == false
                    dist = CalcPointDist(p1,s);
                    edgeStabOrder = [edgeStabOrder; nodeID dist randPtsBallRad(clusterPointNode(nodeID,7))];
                end
            end
            if isempty(edgeStabOrder) == false
                % sort the stab orders based on dist to start vertex of the edge 
                edgeStabOrder = sortrows(edgeStabOrder,2,'ascend');
                stabOrder = [stabOrder; edgeStabOrder(:,1) edgeStabOrder(:,3)];
            end
        end
    end
end