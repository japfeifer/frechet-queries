% MajorityVote3

for mvi = 1:size(queryResults,1)

    idxOffset = size(trajFeatureCurr,2);
    predWordIds = queryResults(mvi,6:5+idxOffset);
    
    szA = size(predWordIds,2);
    resA = []; resA(1:szA,1:3) = [0]; resA(1:szA,3) = Inf; resA(1:szA,1) = predWordIds';
    for mvj = 1:szA
        resA(mvj,1) = predWordIds(mvj);
        for mvk = 1:szA
            if predWordIds(mvj) == resA(mvk,1)
                resA(mvk,2) = resA(mvk,2) + 1;
                currResADist = queryResults(mvi,5+idxOffset+mvj);
                if currResADist < resA(mvk,3)
                    resA(mvk,3) = currResADist;
                end
            end
        end
    end
    resA = sortrows(resA, [2 3], {'descend' 'ascend'});
    bestPredWord = resA(1,1);
    
    queryResults(mvi,5) = queryResults(mvi,4) == bestPredWord;
    queryResults(mvi,6+(idxOffset*2)) = bestPredWord; % store the best work the majority vote chose
    
end