
function [overlapMean, overlapStd] = GetTrajOverlap()

    global clusterNode tmpCCT dendroOverlapList tmpCCTDepth overlapWeight
    
    tmpCCT = clusterNode;
    tmpCCTDepth = Inf;
    tmpCCT = [tmpCCT zeros(size(tmpCCT,1),1)]; % insert 0's to overlap distance column
    dendroOverlapList = [];
    overlapWeight = [];
    GetDendrogramTrajOverlap(1,1);
    overlapMean = sum(dendroOverlapList.*overlapWeight)/sum(overlapWeight);
    overlapStd = std(dendroOverlapList,overlapWeight);

end