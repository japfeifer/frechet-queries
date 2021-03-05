% UpdatekNNAggDefStr

% get the current joint id, and body joint number
idx1 = find(mapCanonJts(:,1) == currBestJt);
HMd = mapCanonJts(idx1,2);

% update the joint set in aggDefStr
if size(aggDefStr(HMd).joints,2) == 0 % this joint set is empty, just use results from precompJoint
    idxJ = find([precompJoint(:).joints] == currBestJt);
    aggDefStr(HMd).joints = currBestJt;
    aggDefStr(HMd).wordids = precompJoint(idxJ).wordids;
    aggDefStr(HMd).distances = precompJoint(idxJ).distances;
else % this joint set is not empty, have to compute new kNN results for this feat traj
    kHM = 1;
    trajFeatureCurr = [1];
    queryResults = [];
    kNNFeatureCurr = [aggDefStr(HMd).joints currBestJt];
    GetkNNmultiRes; % compute NN/kNN results for this currDef and store in queryResults
    idx1 = 6;
    idx2 = idx1 + kCurr - 1;
    idx3 = idx2 + 1;
    idx4 = idx3 + kCurr - 1;
    aggDefStr(HMd).joints = kNNFeatureCurr;
    aggDefStr(HMd).wordids = queryResults(1:szQuery,idx1:idx2);
    aggDefStr(HMd).distances = queryResults(1:szQuery,idx3:idx4);
end

disp(['Current best aggregated joints']);
for iNTT = 1:size(aggDefStr,2)
    if size(aggDefStr(iNTT).joints,2) > 0
        disp(['Body Joint: ',num2str(iNTT),'  Joint Ids: ',num2str(aggDefStr(iNTT).joints)]);
    end
end