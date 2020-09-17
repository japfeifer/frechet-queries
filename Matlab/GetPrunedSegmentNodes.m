% function GetPrunedSegmentNodes
%
% Gets a set of discs (node id's) where the line segment PVertex1-PVertex2
% intersects the disc radius.

function GetPrunedSegmentNodes(nodeID,PVertex1,PVertex2)

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
        SegIntCir = SegIntersectCircle(PVertex1,PVertex2,child1CentrePoint,child1DiscRad);
        if SegIntCir == true
            child1IntersectSegment = true;
        else
            child1IntersectSegment = false;
        end

        child2CentrePoint = randPts(clusterPointNode(child2NodeID,6), :);
        SegIntCir = SegIntersectCircle(PVertex1,PVertex2,child2CentrePoint,child2DiscRad);
        if SegIntCir == true
            child2IntersectSegment = true;
        else
            child2IntersectSegment = false;
        end
    end
    
    if lowestLevel == true 
        % from previous recursion, we already know that PVertex is within 
        % disc radius of nodeID, so just add the node to the prunedNodes list
        pointPrunedNodes(end+1) = nodeID;
    elseif lowestLevel == false && (child1IntersectSegment == true || child2IntersectSegment == true)
        % else, if not at lowest level, and either of the two child nodes
        % cluster radius contains PVertex, recurse
        if child1IntersectSegment == true
            GetPrunedSegmentNodes(child1NodeID,PVertex1,PVertex2);
        end
        if child2IntersectSegment == true
            GetPrunedSegmentNodes(child2NodeID,PVertex1,PVertex2);
        end
    end

end
