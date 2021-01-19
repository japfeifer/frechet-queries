% Test NN CCT pruning vs naive linear scan pruning 
% 

eAdd = 0; % run an exact NN search

tic;
nodeCheckCnt = 0; linLBcnt = 0; linUBcnt = 0; conLBcnt = 0; timeConstLB = 0;
timeLinLB = 0; timeLinUB = 0; 

for i = 1:size(queryStrData,2)  % for each query traj

    NN(i,1,0,1); % NN exact search, do only Prune stage

end

time = toc;

disp(['--------CCT---------']);
disp(['Overall time: ',num2str(time)]);
disp(['Constant LB time: ',num2str(timeConstLB)]);
disp(['Linear LB time: ',num2str(timeLinLB)]);
disp(['Linear UB time: ',num2str(timeLinUB)]);
disp(['Constant LB count: ',num2str(conLBcnt)]);
disp(['Linear LB count: ',num2str(linLBcnt)]);
disp(['Linear UB count: ',num2str(linUBcnt)]);

CCTvsNaiveResults = [time timeConstLB timeLinLB timeLinUB conLBcnt linLBcnt linUBcnt];

tic;
nodeCheckCnt = 0; linLBcnt = 0; linUBcnt = 0; conLBcnt = 0; timeConstLB = 0;
timeLinLB = 0; timeLinUB = 0; 

for i = 1:size(queryStrData,2)  % for each query traj

    % Naive pruning linear scan with filters
    prunedNodes = [];
    Q = queryStrData(i).traj;
    for j = 1:size(trajStrData,2)
        if j == 1
            centreTraj = trajStrData(j).traj; % get center traj 
            tStartConstLB = tic;
            lowBnd = GetBestConstLB(centreTraj,Q,Inf,1,j,i);
            timeConstLB = timeConstLB + toc(tStartConstLB);
            conLBcnt = conLBcnt + 1;
            tStartLinUB = tic;
            upBnd = GetBestUpperBound(centreTraj,Q,1,j,i);
            timeLinUB = timeLinUB + toc(tStartLinUB);
            linUBcnt = linUBcnt + 1;
            currBestLowNodeDist = lowBnd;
            currBestUpNodeDist = upBnd;
            prunedNodes = [j lowBnd upBnd];
        else
            centreTraj = trajStrData(j).traj; % get center traj 
            tStartConstLB = tic;
            lowBnd = GetBestConstLB(centreTraj,Q,currBestUpNodeDist,1,j,i);
            timeConstLB = timeConstLB + toc(tStartConstLB);
            conLBcnt = conLBcnt + 1;
            if lowBnd < currBestUpNodeDist
                tStartLinUB = tic;
                upBnd = GetBestUpperBound(centreTraj,Q,1,j,i);
                timeLinUB = timeLinUB + toc(tStartLinUB);
                linUBcnt = linUBcnt + 1;
                
                tStartLinLB = tic;
                linearLB = GetBestLinearLBDP(centreTraj,Q,currBestUpNodeDist,1,j,i);
                timeLinLB = timeLinLB + toc(tStartLinLB);
                linLBcnt = linLBcnt + 1;
                if linearLB == false
                    prunedNodes = [prunedNodes; j lowBnd upBnd];
                end
                if upBnd < currBestUpNodeDist
                    currBestUpNodeDist = upBnd;
                end
                if lowBnd < currBestLowNodeDist
                    currBestLowNodeDist = lowBnd;
                end
            end
        end
    end
    
%     % find traj with the smallest UB (SUB).  Search other traj and delete
%     % them if their LB + eAdd > SUB.
%     if size(prunedNodes,1) > 1
%         prunedNodes = sortrows(prunedNodes,3,'ascend'); % sort asc by UB
%         sUB = prunedNodes(1,3); % smallest UB
%         TF1 = prunedNodes(2 : end, 2) + eAdd > sUB; % for all but first row, if  LB + eAdd > SUB then mark for deletion
%         prunedNodes([false; TF1],:) = []; % delete rows - always keep first row
%     end
%     
%     % find traj with largest UB (LUB). search other traj and delete them if
%     % their LB + eAdd > LUB.
%     if size(prunedNodes,1) > 1
%         lUB = prunedNodes(end,3); % largest UB - we already sorted asc by UB, so just get last item in list
%         TF1 = prunedNodes(1 : end-1, 2) + eAdd > lUB; % for all but last row, if LB + eAdd > LUB then mark for deletion
%         prunedNodes([TF1; false],:) = []; % delete rows - always keep last row
%     end
% 
%     numNaiveS1 = size(prunedNodes,1);
%     queryTraj(i,16) = num2cell(numNaiveS1);
%     queryTraj(i,17) = mat2cell(prunedNodes,size(prunedNodes,1),size(prunedNodes,2));

end

time = toc;

disp(['--------Naive---------']);
disp(['Overall time: ',num2str(time)]);
disp(['Constant LB time: ',num2str(timeConstLB)]);
disp(['Linear LB time: ',num2str(timeLinLB)]);
disp(['Linear UB time: ',num2str(timeLinUB)]);
disp(['Constant LB count: ',num2str(conLBcnt)]);
disp(['Linear LB count: ',num2str(linLBcnt)]);
disp(['Linear UB count: ',num2str(linUBcnt)]);

CCTvsNaiveResults = [CCTvsNaiveResults time timeConstLB timeLinLB timeLinUB conLBcnt linLBcnt linUBcnt];
 
