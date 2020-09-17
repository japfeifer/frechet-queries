% ConstructHVCCT
%
% Construct the hyper vector CCT

function ConstructHVCCT

    global trajHyperVector clusterHVNode clusterHVNodeToID h currNodeID totNode

    h = waitbar(0, 'Construct HV CCT');

    totalVectors = size(trajHyperVector,1);  % get number of hyper vectors to process
    totNode = (totalVectors * 2) - 1;  % calc total nodes
    centerId = 0;
    currDist = 0;
    smallestCosDist = 0;
    furthestPointID = 0;
    currNodeID = 0;
    pointDistList = [];
    clusterHVNode = [];
    clusterHVNodeToID = [];
    tmpIndex = 0;

    clusterHVNode(totNode,7) = 0;
    clusterHVNodeToID(totalVectors,1) = 0;

    % randomly choose a point as the first center
    % centerId = randi(totalVectors,1);

    % for testing purposes hardcode the first center ID so that it is easy to do
    % comparisons of code changes and recreate the same output 
    centerId = 1;

    % process top node cluster
    % compare distance from center point to all other points
    for j = 1:totalVectors 
        if j == centerId % we are comparing the point to itself
            currDist = 1;
        else
            currDist = VectorCosDist(trajHyperVector(centerId,:), trajHyperVector(j,:));
        end  
        pointDistList = [pointDistList; j currDist];
    end

    % get max Rsize and associated ID
    [smallestCosDist,tmpIndex] = min(pointDistList(:,2));
    furthestPointID = pointDistList(tmpIndex,1);

    % save info to clusterHVNode
    currNodeID = 1;
    clusterHVNode(currNodeID,:) = [0 0 0 smallestCosDist totalVectors centerId furthestPointID];

    X = ['Construct HV CCT ',num2str(currNodeID),'/',num2str(totNode)];
    waitbar(currNodeID/totNode, h, X);

    % now call function to recursively split node into 2-k clusters
    SplitHVNode(currNodeID,pointDistList);

    close(h);

end