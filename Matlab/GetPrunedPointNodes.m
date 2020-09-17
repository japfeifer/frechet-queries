% function GetPrunedPointNodes
%
% Gets a set of discs (node id's) where the vertex (PVertex) 
% is within the disc radius.

function GetPrunedPointNodes(nodeID,PVertex)

    global pointPrunedNodes randPts clusterPointNode nodeVisitCnt
    
    % if at leaf level, or lowest level based on minRad, and PVertex is within
    % nodeID radius, then add node to pruned node list
    
    lowestLevel = false;
    nodeVisitCnt = nodeVisitCnt + 1;
    
    if clusterPointNode(nodeID,5) == 1 % at leaf level
        lowestLevel = true;
    else
        % first get child1 and child2 node disc radius. The disc radius is
        % the node radius plus the radius of the furthest point
        child1NodeID = clusterPointNode(nodeID,2);
        child1DiscRad = clusterPointNode(child1NodeID,4);
        
        child2NodeID = clusterPointNode(nodeID,3);
        child2DiscRad = clusterPointNode(child2NodeID,4);
   
        child1CentrePoint = randPts(clusterPointNode(child1NodeID,6), :);
        child1PointToCentreDist = CalcPointDist(PVertex,child1CentrePoint);
        if child1PointToCentreDist <= child1DiscRad
            child1ContainVertex = true;
        else
            child1ContainVertex = false;
        end

        child2CentrePoint = randPts(clusterPointNode(child2NodeID,6), :);
        child2PointToCentreDist = CalcPointDist(PVertex,child2CentrePoint);
        if child2PointToCentreDist <= child2DiscRad
            child2ContainVertex = true;
        else
            child2ContainVertex = false;
        end
    end
    
    if lowestLevel == true 
        % from previous recursion, we already know that PVertex is within 
        % disc radius of nodeID, so just add the node to the prunedNodes list
        pointPrunedNodes = [pointPrunedNodes nodeID];
    elseif lowestLevel == false && (child1ContainVertex == true || child2ContainVertex == true)
        % else, if not at lowest level, and either of the two child nodes
        % cluster radius contains PVertex, recurse
        if child1ContainVertex == true
            GetPrunedPointNodes(child1NodeID,PVertex);
        end
        if child2ContainVertex == true
            GetPrunedPointNodes(child2NodeID,PVertex);
        end
    end

end