% MajorityVote4
% Used by kNN-m , i.e. kNN - multi feature traj
% Computes a distance-weighted kNN result

if ~exist('mvFactor','var')
    mvFactor = 1;
end

numTrajFeat = size(trajFeatureCurr,2);

for mvi = 1:size(queryResults,1)

    idxOffset = kCurr * numTrajFeat;
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
