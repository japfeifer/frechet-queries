% find the curve P with the largest size

nMax=0;
iBest = 0;
for i = 1:size(trajOrigData,1)
    P = cell2mat(trajOrigData(i,1));
    n = size(P,1);
    trajOrigData(i,2) = {n};
end

trajOrigData = sortrows(trajOrigData,[2],'ascend');

% P = cell2mat(trajOrigData(215,1));
% Q = cell2mat(trajOrigData(216,1));