% RunPredictor3kNNmulti
% Run the predictor for NN or kNN multi with joint aggregation 

acc_iter_def_curr = acc_iter_def;
lastBestAcc = 0;
lastBestDef = [];

if ~exist('reachPctCurr','var')
    reachPctCurr = 0;
end
if ~exist('batchFlg','var')
    batchFlg = 0;
end
if ~exist('iterNumJtsIncl','var')
    iterNumJtsIncl = 1;
end
if ~exist('doDMmMin','var')
    doDMmMin = 1;
end

% pre-compute the NN/kNN word Id's and distances for each joint (canonical subskeleton)
precompJoint = [];
queryResHeader = [];
disp(['pre-compute the NN/kNN word Id''s and distances for each joint (i.e. canonical subskeleton)']);
for HMc = 1:size(acc_iter_def_curr,2)
    currDef = [acc_iter_def_curr(HMc)];  % test the accuracy with this particular set of canonical sub-skeleton features
    disp(['currDef: ',num2str(currDef)]);
    kHM = 1;
    trajFeatureCurr = [1];
    queryResults = [];
    kNNFeatureCurr = currDef;
    
    GetkNNmultiRes; % compute NN/kNN results for this currDef and store in queryResults

    % save the NN/kNN joint and accuracy
    currWordIDs = []; currDistances = []; idx1 = 0; idx2 = 0;
    szQuery = size(queryResults,1);
    idx1 = 6;
    idx2 = idx1 + kCurr - 1;
    currWordIDs(1:szQuery,1:kCurr) = queryResults(:,idx1:idx2);
    idx1 = idx2 + 1;
    idx2 = idx1 + kCurr - 1;
    currDistances(1:szQuery,1:kCurr) = queryResults(:,idx1:idx2);
    precompJoint(HMc).joints = currDef;
    precompJoint(HMc).wordids = currWordIDs;
    precompJoint(HMc).distances = currDistances;
    
    % save the queryResults "header" - i.e. first four columns
    if HMc == 1
        queryResHeader = queryResults(:,1:4);
    end
end

% structure used to hold feature traj's
aggDefStr = [];
for i=1:totBodyJts
    aggDefStr(i).joints = [];
    aggDefStr(i).wordids = [];
    aggDefStr(i).distances = [];
end

while isempty(acc_iter_def_curr) == false  % continue until the set of canonical sub-skeleton features is empty or accuracy is not improved
    
    currBestDef = [];
    curBestFeat = 0;
    currIterAccList = [];

    for HMc = 1:size(acc_iter_def_curr,2) % find next-best canonical sub-skeleton feature
        currJt = acc_iter_def_curr(HMc);
        currDef = [lastBestDef currJt];  % test the accuracy with this particular set of canonical sub-skeleton features
        disp(['currDef: ',num2str(currDef)]);

        % get the current joint id, and body joint number
        idx1 = find(mapCanonJts(:,1) == currJt);
        currBodyJt = mapCanonJts(idx1,2);
        
        % get number of feature traj
        numFeat = 0;
        trajFeatCurr = [];
        for HMd = 1:size(aggDefStr,2)
            if size(aggDefStr(HMd).joints,2) > 0 || HMd == currBodyJt
                numFeat = numFeat + 1;
                trajFeatCurr = [trajFeatCurr 1];
            end
        end
        
        % build the queryResults
        kHM = 0; % feat traj
        queryResults = [];
        queryResults(1:szQuery,1:((numFeat*kCurr*2) + 6)) = 0;
        queryResults(1:szQuery,1:4) = queryResHeader;
        for HMd = 1:size(aggDefStr,2)
            if HMd == currBodyJt % we have to change this joint set
                kHM = kHM + 1;
                if size(aggDefStr(HMd).joints,2) == 0 % this joint set is empty, just use results from precompJoint
                    idxJ = find([precompJoint(:).joints] == currJt);
                    idx1 = 6 + (kHM*kCurr) - kCurr;
                    idx2 = idx1 + kCurr - 1;
                    idx3 = 6 + (kHM*kCurr) + (numFeat*kCurr) - kCurr;
                    idx4 = idx3 + kCurr - 1;
                    queryResults(1:szQuery,idx1:idx2) = precompJoint(idxJ).wordids;
                    queryResults(1:szQuery,idx3:idx4) = precompJoint(idxJ).distances;
                else % this joint set is not empty, have to compute new kNN results for this feat traj
                    kNNFeatureCurr = [aggDefStr(HMd).joints currJt];
                    GetkNNmultiRes; % compute NN/kNN results for this currDef and store in queryResults
                end
            elseif size(aggDefStr(HMd).joints,2) > 0 % just append this joint set to queryResults
                kHM = kHM + 1;
                idx1 = 6 + (kHM*kCurr) - kCurr;
                idx2 = idx1 + kCurr - 1;
                idx3 = 6 + (kHM*kCurr) + (numFeat*kCurr) - kCurr;
                idx4 = idx3 + kCurr - 1;
                queryResults(1:szQuery,idx1:idx2) = aggDefStr(HMd).wordids;
                queryResults(1:szQuery,idx3:idx4) = aggDefStr(HMd).distances;
            end
        end
 
        % get accuracy from queryResults
%         if kCurr == 1 % NN-m
%             MajorityVote5; % just do majority vote
%         else % kNN-m
            MajorityVote6; % do weighted method for each traj feature, then majority vote on those results
%         end
%         if kNNmDistWeightFlg == 0
%             MajorityVote5;
%         else
%             MajorityVote4;
%         end
        classAccuracy = mean(queryResults(:,5)) * 100;
        disp(['kNN multi mean accuracy: ',num2str(classAccuracy)]);
    
        currIterAccList(HMc,1) = currJt;
        currIterAccList(HMc,2) = classAccuracy;
        
        if classAccuracy > lastBestAcc
%         if classAccuracy >= lastBestAcc
            lastBestAcc = classAccuracy;
            currBestDef = currDef;
            currBestJt = currJt;
        end

    end
    
    currIterAccList = sortrows(currIterAccList,[2],'descend'); % sort by accuracy desc

    if isempty(currBestDef) == false % the accuracy was improved
        currBestDef = lastBestDef;
        for HMc2 = 1:min(iterNumJtsIncl,size(currIterAccList,1))
            currBestJt = currIterAccList(HMc2,1);
            currBestDef = [currBestDef currBestJt];
            acc_iter_def_curr(acc_iter_def_curr == currBestJt) = [];  % remove the best feature from the set
            UpdatekNNAggDefStr;
        end
        lastBestDef = currBestDef;
        disp(['Accuracy improved: ',num2str(lastBestAcc),' currBestDef: ',num2str(currBestDef)]);
    elseif doDMmMin > 1 % we want to include a minimum number of canonical subskeletons
        currBestDef = lastBestDef;
        for HMc2 = 1:min(iterNumJtsIncl,size(currIterAccList,1))
            currBestJt = currIterAccList(HMc2,1);
            currBestDef = [currBestDef currBestJt];
            acc_iter_def_curr(acc_iter_def_curr == currBestJt) = [];  % remove the best feature from the set
            UpdatekNNAggDefStr;
        end
        disp(['Accuracy did NOT improve: ',num2str(currIterAccList(1,2)),' currBestDef: ',num2str(currBestDef)]);
        lastBestDef = currBestDef;
        
        if size(currBestDef,2) >= doDMmMin % we have the minimum number of canonical subskeletons
            disp(['Minimum number of subskeletons reached']);
            break
        end
    else
        break  % the accuracy was not improved, so stop searching
    end

end

