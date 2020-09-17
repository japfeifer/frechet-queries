function GetMinClusterRad(nodeID,depth)
    
    global tmpCCT lowClustRad

        if tmpCCT(nodeID,4) < lowClustRad
            lowClustRad = tmpCCT(nodeID,4);
        end

        if tmpCCT(tmpCCT(nodeID,2),4) > 0
            GetMinClusterRad(tmpCCT(nodeID,2),depth+1);
        end

        if tmpCCT(tmpCCT(nodeID,3),4) > 0
            GetMinClusterRad(tmpCCT(nodeID,3),depth+1);
        end
end