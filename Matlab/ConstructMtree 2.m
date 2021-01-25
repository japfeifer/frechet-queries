% Construct an M-tree using an insert algorithm from paper:
% "M-tree: An Efficient Access Method for Similarity Search in Metric Spaces"
% Authors: P. Ciaccia, M. Patella, P. Zezula
%
% Notes on mTree variable:
% - each row is a node
% - first column: NodeType, 0 = leaf, 1 = routing
% - second column: NumNodeEntries
% - the next 4 columns are: TrajId, ptr to child node, radius, distance to parent entry
% - the four columns above are repeated for each additional entry in the node, up to mTreeNodeCapacity
% - for leaf nodes, radius and distance to parent node are empty
% - for the root node, ptr to parent node, parent node entry num, and distance to parent node are all empty
%
% Notes on mTreePtrList variable:
% - each row is a node
% - the first column is the parent node Id
% - the second column is the parent node-entry number

tic;
h = waitbar(0, 'Construct M-tree');

mTree = [];  % the M-Tree data structure
mTreePtrList = [];  % For each node id, store the ptr to parent node and parent node entry num
mTreeRootId = 0;  % point to the root node in the mTree
mTreeNodeCapacity = 100;  % the max number of routing/data objects per node
mTreeMaxCol = (mTreeNodeCapacity * 4)+2;  % maximum columns in mTree variable
numCFD = 0;  % set number of continuous frechet distance calcs to 0
numDP = 0;
nodeCheckCnt = 0;
rng('default'); % reset the random seed so that experiments are reproducable

totalTraj = size(trajData,1);  % get number of trajectories to process

% insert each traj into the M-tree
% for i = 1:19
for i = 1:totalTraj
    X = ['Construct M-tree ',num2str(i),'/',num2str(totalTraj)];
    waitbar(i/totalTraj, h, X);
    
    InsertMtree(mTreeRootId,i,0);
end

close(h);
timeElapsed = toc;
disp(['Runtime per trajectory (ms): ',num2str(timeElapsed/totalTraj*1000)]);