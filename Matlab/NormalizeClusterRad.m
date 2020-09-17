function NormalizeClusterRad(nodeID,maxRad,depth)
    
    global tmpCCT 

        tmpCCT(nodeID,4) = tmpCCT(nodeID,4) / maxRad;

        if tmpCCT(tmpCCT(nodeID,2),4) > 0
            NormalizeClusterRad(tmpCCT(nodeID,2),maxRad,depth+1);
        end

        if tmpCCT(tmpCCT(nodeID,3),4) > 0
            NormalizeClusterRad(tmpCCT(nodeID,3),maxRad,depth+1);
        end
end