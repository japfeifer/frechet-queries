
% P = queryStrData(1).traj;
P = trajStrData(10).traj;


disp(['---------------------']);
% get disc nodes that cover trajectory start vertex point
PStartVertex = P(1,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PStartVertex);
startNodes = pointPrunedNodes;

% display start location 
if isempty(startNodes) == false
    for i=1:size(startNodes,2)
        disp([sprintf('S%d ',startNodes(i))]);
    end
end

% get disc nodes that cover trajectory end vertex point
PEndVertex = P(end,:);
pointPrunedNodes = [];
GetPrunedPointNodes(1,PEndVertex);
endNodes = pointPrunedNodes;

% display end location 
if isempty(endNodes) == false
    for i=1:size(endNodes,2)
        disp([sprintf('E%d ',endNodes(i))]);
    end   
end

so = GetTrajectoryStabOrder(P); % get the disc stab order

for i = 1:size(ballSet,1) % attempt to create a RI for each ball set
    tmpSO = [];
    for j = 1:size(so,1) % generate new subset stabbing order
        currBallSet = ballSet(i,:);
        currBallSet(currBallSet==0) = [];
        if ismember(mod(so(j),8)+1,currBallSet)
            tmpSO = [tmpSO; so(j)];
        end
    end
    if isempty(tmpSO) == false
        disp([sprintf('N%d ',tmpSO)]);
    end
end