


function QueryHST(sourceName,inVars,typeQ,eVal)

    switch nargin
    case 2
        typeQ = 2;
        eVal = 0;
    end

    global queryStrData globalBringmann

    load(sourceName);
    
    globalBringmann = 0; % do no run Bringmann c++ code, instead run matlab code for Frechet dist
    
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
                txt = 'Baseline 1'; % modified Alt&Godau decider for sub-traj
                BaseSubNN(j);
            elseif currMeth == 2
                txt = 'Baseline 2'; % modified Driemel approx algorithm for sub-traj (use Baseline 1 decider)
                BaseModDriemel(j,typeQ,eVal); % do a (1+epsilon) approximation - set epsilon to 1
            elseif currMeth == 3
                tSearch = tic;
                timeSearch = 0;
                txt = 'Baseline 3'; % exact CCT NN query on all pairwise sub-traj
                NN(j,2,0); 
                timeSearch = toc(tSearch);
                queryStrData(j).sublb = 0;
                queryStrData(j).subub = 0;
                queryStrData(j).subsearchtime = timeSearch;
                queryStrData(j).submemorysz = 0;
                queryStrData(j).subnumoperations = 0;
            elseif currMeth == 4
                txt = 'Algorithm 1'; % modified Alt&Godau decider for sub-traj, with additional heuristics
                Algo1SubNN(j);
            elseif currMeth == 5
                txt = 'Algorithm 2'; % slightly modified Cover Tree FindNearest algo
                level = 1; sIdx = 1; eIdx = 2;
                MainSubNN(j,level,[sIdx eIdx]);
            elseif currMeth == 6
                txt = 'Algorithm 3'; % our contribution, a combo of Algo 1 & 2, and additional heuristics
                level = 1; sIdx = 1; eIdx = 2;
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
          
        if currMeth == 5 || currMeth == 6
            tmp1 = [];
            tmp1(1:numQueries,1:3) = 0;
            for j = 1:numQueries
                tmp1(j,1) = queryStrData(j).subevert - queryStrData(j).subsvert + 1;
                tmp1(j,2) = queryStrData(j).submemorysz;
                tmp1(j,3) = tmp1(j,2) / tmp1(j,1);
            end
            currMean = mean([tmp1(1:numQueries,3)]);
            disp(['Max |c| as a factor of the result |P''| size: ',num2str(currMean)]);
        end
          
        currMin = min([queryStrData(1:numQueries).subnumoperations]);
        currMax = max([queryStrData(1:numQueries).subnumoperations]);
        currMean = mean([queryStrData(1:numQueries).subnumoperations]);
        currStd = std([queryStrData(1:numQueries).subnumoperations]);
        disp(['Num operations wrt |P| Min: ',num2str(currMin),'  Max: ',num2str(currMax),...
              '  Mean: ',num2str(currMean),'  Std: ',num2str(currStd)]);
    end

end