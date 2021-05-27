


function QueryHST(sourceName,inVars)

    load(sourceName);
    
    testMethods = [];
    for i = 1:6
        if inVars(i) == 1
            testMethods = [testMethods i];
        end
    end
    
    numQueries = min(size(queryStrData,2),inVars(7));

    for i = 1:size(testMethods,2) % sub-traj methods
        currMeth = testMethods(i);

        % perform queries
        for j = 1:numQueries
            
            if currMeth == 1
                txt = 'Baseline 1';
                BaseSubNN(j);
            elseif currMeth == 2
                txt = 'Baseline 2';
                BaseSubNN(j);
            elseif currMeth == 3
                txt = 'Baseline 3';
                BaseSubNN(j);
            elseif currMeth == 4
                txt = 'Algorithm 1';
                Algo1SubNN(j);
            elseif currMeth == 5
                txt = 'Algorithm 2';
                level = 1; sIdx = 1; eIdx = 2;
                MainSubNN(j,level,[sIdx eIdx]);
            elseif currMeth == 6
                txt = 'Algorithm 3';
                level = 1; sIdx = 1; eIdx = 2; typeQ = 2; eVal = 0;
                MainImprovedSubNN3(j,level,[sIdx eIdx],0,typeQ,eVal);
            end
        end
        currMin = min([queryStrData(1:numQueries).subsearchtime]);
        currMax = max([queryStrData(1:numQueries).subsearchtime]);
        currMean = mean([queryStrData(1:numQueries).subsearchtime]);
        currStd = std([queryStrData(1:numQueries).subsearchtime]);
        disp(['Query time (ms) Min: ',num2str(currMin*1000),'  Max: ',num2str(currMax*1000),...
              '  Mean: ',num2str(currMean*1000),'  Std: ',num2str(currStd*1000)]);
          
        currMin = min([queryStrData(1:numQueries).submemorysz]);
        currMax = max([queryStrData(1:numQueries).submemorysz]);
        currMean = mean([queryStrData(1:numQueries).submemorysz]);
        currStd = std([queryStrData(1:numQueries).submemorysz]);
        disp(['Max size candidate Min: ',num2str(currMin),'  Max: ',num2str(currMax),...
              '  Mean: ',num2str(currMean),'  Std: ',num2str(currStd)]);
          
        currMin = min([queryStrData(1:numQueries).subnumoperations]);
        currMax = max([queryStrData(1:numQueries).subnumoperations]);
        currMean = mean([queryStrData(1:numQueries).subnumoperations]);
        currStd = std([queryStrData(1:numQueries).subnumoperations]);
        disp(['Num operations wrt |P| Min: ',num2str(currMin),'  Max: ',num2str(currMax),...
              '  Mean: ',num2str(currMean),'  Std: ',num2str(currStd)]);
    end

end