% Get the CCT Cluster Radius Reduction Factor. Measures how quickly 
% clusster radii reduce in size from the root towards the leafs. A smaller
% Reduction Factor means the radii are reducing in size faster, compared 
% to a larger Reduction Factor.
% it is also called compactness

tmpCCT = clusterNode;
reductFacList = [];

% normalize cluster radius size
maxRad = tmpCCT(1,4);
NormalizeClusterRad(1,maxRad,1);

% loop thru each node
for i = 1:size(tmpCCT,1)
    % if node has parent, and is not a leaf, and does not have zero radius
    if tmpCCT(i,1) ~= 0 && tmpCCT(i,5) ~= 1 && tmpCCT(i,4) ~= 0
        reductFacList(end+1) = tmpCCT(i,4) / tmpCCT(tmpCCT(i,1),4);
    end
end

reductFacMean = mean(reductFacList);
reductFacStd = std(reductFacList);
