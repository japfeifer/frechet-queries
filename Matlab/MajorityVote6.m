% MajorityVote6
% Used by NN-m and kNN-m
% Computes a distance-weighted result for each feat traj, then does a majority vote on those results

if ~exist('mvFactor','var')
    mvFactor = 1;
end

numTrajFeat = size(trajFeatureCurr,2);

for mvi = 1:size(queryResults,1) % process each query
    
    % do weighted method for each traj feature
    resC = [];
    for mvj = 1:numTrajFeat 
        % get word id and dist for this traj feature
        resA = [];
        for mvk = 1:kCurr
            idx1 = 6 + (mvj * kCurr) - kCurr; % word id idx
            idx2 = idx1 + (numTrajFeat * kCurr); % dist idx
            resA(mvk,1:2) = [queryResults(mvi,idx1) queryResults(mvi,idx2)];
        end
        resB = [];
        resB = [unique(resA(:,1))]; % unique list of word id and weighted dist
        resB(:,2) = 0; % this will contain the weighted distance
        resB(:,3) = Inf; % this will contain the min non-weighted distance
        mvMinDist = min(resA(:,2));
        for mvk = 1:kCurr
            mvNewDist = 1 / ((resA(mvk,2) / mvMinDist) ^ mvFactor);
            for mvl = 1:size(resB,1)
                if resB(mvl,1) == resA(mvk,1)
                    resB(mvl,2) = resB(mvl,2) + mvNewDist;
                    if resA(mvk,2) < resB(mvl,3)
                        resB(mvl,3) = resA(mvk,2);
                    end
                end
            end
        end
        resB = sortrows(resB, [2], {'descend'}); % the best weighted word id is the first in the list
        resC(mvj,1) = resB(1,1); % store the best weighted word id
        resC(mvj,2) = resB(1,3); % store the min non-weighted distance
    end
    
    % do majority vote on results from each traj feature
    resD = [];
    resD = [unique(resC(:,1))];
    resD(:,2) = Inf; % default distance = Inf
    resD(:,3) = 0;  % default count = 0
    for mvk = 1:size(resC,1)
        for mvl = 1:size(resD,1)
            if resC(mvk,1) == resD(mvl,1)
                resD(mvl,3) = resD(mvl,3) + 1; % increment count
                if resC(mvk,2) < resD(mvl,2) % update distance to minimum
                    resD(mvl,2) = resC(mvk,2);
                end
            end
        end
    end
    resD = sortrows(resD, [3 2], {'descend' 'ascend'}); % sort by count asc, distance desc
    bestPredWord = resD(1,1);
    queryResults(mvi,5) = queryResults(mvi,4) == bestPredWord;
    queryResults(mvi,6+(numTrajFeat*kCurr*2)) = bestPredWord; % store the best word the majority vote chose
    
end
