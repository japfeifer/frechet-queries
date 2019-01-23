% convert the datatypes of clusterNode and clusterTrajNode 
% from cell to matrix.  Opertions on matrix datatypes run much faster.

cSz = size(clusterNode,1);
clusterNode2 = [];
clusterNode2(cSz,7) = 0;
for i = 1:cSz
    clusterNode2(i,:) = [cell2mat(clusterNode(i,1)) ...
                             cell2mat(clusterNode(i,2)) ...
                             cell2mat(clusterNode(i,3)) ...
                             cell2mat(clusterNode(i,4)) ...
                             cell2mat(clusterNode(i,5)) ...
                             cell2mat(clusterNode(i,6)) ...
                             cell2mat(clusterNode(i,7))];
    
end

cSz = size(clusterTrajNode,1);
clusterTrajNode2 = [];
clusterTrajNode2(cSz,1) = 0;
for i = 1:cSz
    clusterTrajNode2(i,:) = [cell2mat(clusterTrajNode(i,1))];
end

clear clusterNode;
clusterNode = clusterNode2;

clear clusterTrajNode;
clusterTrajNode = clusterTrajNode2;

clear clusterNode2;
clear clusterTrajNode2;