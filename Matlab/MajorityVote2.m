% MajorityVote2
% Used by kNN-s , i.e. kNN - single feature traj
% Computes a distance-weighted kNN result

if ~exist('mvFactor','var')
    mvFactor = 1;
end

for mvi = 1:size(queryResults,1)

    idxOffset = kCurr;
    predWordIds = unique(queryResults(mvi,6:5+idxOffset));
    
    szA = size(predWordIds,2);
    resA = []; resA(1:szA,1:2) = [0]; resA(1:szA,1) = predWordIds';
    
    mvDistList = [];
    for mvj = 1:idxOffset
        mvDistList = [mvDistList queryResults(mvi,5+idxOffset+mvj)];
    end
    mvMinDist = min(mvDistList);
    
    for mvj = 1:idxOffset
        mvDist = queryResults(mvi,5+idxOffset+mvj);
        mvCurrWordID = queryResults(mvi,5+mvj);
        mvNewDist = 1 / ((mvDist / mvMinDist) ^ mvFactor);
        for mvk = 1:szA
            if mvCurrWordID == resA(mvk,1)
                resA(mvk,2) = resA(mvk,2) + mvNewDist;
            end
        end
    end
    resA = sortrows(resA, [2], {'descend'});
    bestPredWord = resA(1,1);
    
    queryResults(mvi,5) = queryResults(mvi,4) == bestPredWord;
    queryResults(mvi,6+(idxOffset*2)) = bestPredWord; % store the best word the majority vote chose
    
end

% % this code is a simpler majority vote, ties are broken by closer distance
% for mvi = 1:size(queryResults,1)
% 
%     idxOffset = kCurr;
%     predWordIds = queryResults(mvi,6:5+idxOffset);
%     
%     szA = size(predWordIds,2);
%     resA = []; resA(1:szA,1:3) = [0]; resA(1:szA,3) = Inf; resA(1:szA,1) = predWordIds';
%     for mvj = 1:szA
%         resA(mvj,1) = predWordIds(mvj);
%         for mvk = 1:szA
%             if predWordIds(mvj) == resA(mvk,1)
%                 resA(mvk,2) = resA(mvk,2) + 1;
%                 currResADist = queryResults(mvi,5+idxOffset+mvj);
%                 if currResADist < resA(mvk,3)
%                     resA(mvk,3) = currResADist;
%                 end
%             end
%         end
%     end
%     resA = sortrows(resA, [2 3], {'descend' 'ascend'});
%     bestPredWord = resA(1,1);
%     
%     queryResults(mvi,5) = queryResults(mvi,4) == bestPredWord;
%     queryResults(mvi,6+(idxOffset*2)) = bestPredWord; % store the best work the majority vote chose
%     
% end