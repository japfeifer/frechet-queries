% % sort traj by |P|
% for i = 1:size(trajOrigData,1)
%     Pcurr = cell2mat(trajOrigData(i,1));
%     szP = size(Pcurr,1);
%     trajOrigData(i,2) = {szP};
%     
% end
% trajOrigData = sortrows(trajOrigData,2,'ascend');
% 
% P = cell2mat(trajOrigData(1,1));
% Q = cell2mat(trajOrigData(3,1));
% 
% currDist = 2390;
% currDist = 2391;

% tic
% for i = 1:10
%     ans = FrechetDecide(P,Q,currDist);
% end
% toc

% ans = FrechetDecide(P,Q,currDist,1,1);

% dist1 = ContFrechet(P,Q,1);


% tic
% for i = 1:10
%     [ans,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,currDist);
% end
% toc


% [ans,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,currDist);
% 
% [ans,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,currDist);