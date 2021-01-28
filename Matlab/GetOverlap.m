
function [overlapMean, overlapStd] = GetOverlap()

    global clusterNode tmpCCT dendroOverlapList tmpCCTDepth overlapWeight
    
    tmpCCT = clusterNode;
    tmpCCTDepth = Inf;
    tmpCCT = [tmpCCT zeros(size(tmpCCT,1),1)]; % insert 0's to overlap distance column
    dendroOverlapList = [];
    overlapWeight = [];
    GetDendrogramOverlap(1,1);
    overlapMean = sum(dendroOverlapList.*overlapWeight)/sum(overlapWeight);
    overlapStd = std(dendroOverlapList,overlapWeight);
    disp(['Traj overlap (overlapMean): ',num2str(overlapMean)]);
    disp(['Traj overlap std (overlapStd): ',num2str(overlapStd)]);
end