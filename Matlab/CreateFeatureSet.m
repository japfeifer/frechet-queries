function featureSet = CreateFeatureSet(fSetNum,featureSetClass,otherFeatureColFlg,featureSetNum2)

    featureSet = {[]};
    
    disp(['Create feature columns']);
    tFeatColPrep = tic;
    
    featureSet = CreateFeatureSet2(fSetNum,featureSetClass);
    
    if otherFeatureColFlg == 1
        featureSet2 = {[]};
        featureSet2 = CreateFeatureSet2(featureSetNum2,[]);
        a = cell2mat(featureSet);
        b = cell2mat(featureSet2);
        c = union(a,b,'rows');
        featureSet = {[]};
        for i = 1:size(c,1)
            featureSet(i,1) = {c(i,1)};
            featureSet(i,2) = {c(i,2)};
        end
        
    end
    
    timeFeatColPrep = toc(tFeatColPrep);
    disp(['Create feature columns time: ',num2str(timeFeatColPrep)]);

end