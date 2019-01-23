% Simplification Prune Step
% note that this is an O(nlogn) procedure.  This step can be done in 
% O(n) time by calling the frechet decision procedure.
% For query curve Q, set Q' to first & last vertex of Q.  
% Calc distance from Q to Q' (called Eq). 
% If 0.5 times the difference between Ep and Eq
% is > Emax then the distance between P and Q is > Emax and you can prune
% (discard) P from the list of potential candidates.

tic;

for k = 1:numQueryTraj % for each query do
    % get Q and Q'
    sampleTraj = cell2mat(queryTraj(k,1));
    currTraj = cell2mat(queryTraj(k,2));

    % calc using continuous frechet
    Eq = ContFrechet(sampleTraj,currTraj);

    % get list of traj from the Range Search Prune
    currTrajList = cell2mat(queryTraj(k,3));
    
    % now compare Eq to each Ep in the list
    smallTrajIdList = [];
    if isempty(currTrajList) == false % only process if list is not null        
        for j = 1:size(currTrajList,1) % for each traj            
            % get Ep
            currTrajId = currTrajList(j,1);
            Ep = cell2mat(trajData(currTrajId,6));
            
            if (abs(Eq-Ep)*0.5) <= Emax  % don't prune this curve - keep it
                smallTrajIdList = [smallTrajIdList; currTrajId];
            end     
        end       
    end
    
    if isempty(smallTrajIdList) == false
        queryTraj(k,6) = mat2cell(smallTrajIdList,size(smallTrajIdList,1),size(smallTrajIdList,2));
    else
        queryTraj(k,6) = mat2cell([],size([],1),size([],2));
    end
    
end

timeElapsed = toc;