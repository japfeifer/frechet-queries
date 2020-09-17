function GetDendrogramOverlap(nodeID,depth)

    global tmpCCT tmpCCTDepth dendroOverlapList overlapWeight
    
    if depth <= tmpCCTDepth % only process up to a certain tree depth
        % only do calc if both children are non-leafs
        if tmpCCT(tmpCCT(nodeID,2),5) ~= 1 && tmpCCT(tmpCCT(nodeID,3),5) ~= 1
            cRad = tmpCCT(nodeID,4); % cluster radius
            child1Rad = tmpCCT(tmpCCT(nodeID,2),4);
            child2Rad = tmpCCT(tmpCCT(nodeID,3),4);
            pctOverlap = (child1Rad + child2Rad - cRad) / cRad;
            if pctOverlap < 0
                pctOverlap = 0;
            end
            dendroOverlapList(end+1) = pctOverlap;
            overlapWeight(end+1) = tmpCCT(nodeID,5);
        else
            pctOverlap = 0;
        end

        tmpCCT(nodeID,8) = pctOverlap;

        if tmpCCT(tmpCCT(nodeID,2),5) > 1
            GetDendrogramOverlap(tmpCCT(nodeID,2),depth+1);
        end

        if tmpCCT(tmpCCT(nodeID,3),5) > 1
            GetDendrogramOverlap(tmpCCT(nodeID,3),depth+1);
        end
    end

end