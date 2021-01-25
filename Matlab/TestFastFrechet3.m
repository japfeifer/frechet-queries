CCTType = 'CCT1';
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
jNum = 1000;
kNum = 10;
SimplFlg = 0;

% dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
%     "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
%     "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
%     "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
%     "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
%     "PenTipData"];

dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
    "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
    "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
    "PenTipData"];

% dataList = ["PenTipData"];

h = waitbar(0, 'Test Fast Frechet');
for i = 1:size(dataList,2)   
    dataName = char(dataList(i));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    
    resTrue(jNum * kNum,1:3) = 0;
    resFalse(jNum * kNum,1:3) = 0;
    cntTrue = 0;
    cntFalse = 0;
    
    for j = 1:jNum
        X = [num2str(i),': ',dataName,': ',num2str(j)];
        waitbar(j/jNum, h, X);
            
        % get a P and Q curve
        if SimplFlg == 1
            sz = size(trajStrData,2);
            idxP = randi(sz);
            idxQ = randi(sz);
            P = trajStrData(idxP).traj;
            Q = trajStrData(idxQ).traj;
        else
            sz = size(trajOrigData,1);
            idxP = randi(sz);
            idxQ = randi(sz);
            P = cell2mat(trajOrigData(idxP,1));
            Q = cell2mat(trajOrigData(idxQ,1));
        end
        
        % get UB and LB
        distLB = GetBestConstLBLessBnd(P,Q,Inf,2,idxP,idxQ);
        distUB = GetBestUpperBound(P,Q,2,idxP,idxQ);
        
        distLB = round(distLB,7)+0.00000009;
        distLB = fix(distLB * 7^10)/7^10;
        distUB = round(distUB,7)+0.00000009;
        distUB = fix(distUB * 7^10)/7^10;
        
        if distLB == distUB
            distList(1,1:kNum) = distLB;
        else
            distList = distLB: (distUB-distLB) / (kNum-1) :distUB;
        end
        
        for k = 1:size(distList,2)
            currDist = distList(k);
            [ans,numCellCheck,boundCutPath] = FrechetDecideFast(P,Q,currDist);
            linCell = size(P,1) + size(Q,1) - 3;
            quadCell = (size(P,1) - 1) * (size(Q,1) - 1);
            if ans == 0
                cntFalse = cntFalse + 1;
                resFalse(cntFalse,1:3) = [linCell quadCell numCellCheck];
            else
                cntTrue = cntTrue + 1;
                resTrue(cntTrue,1:3) = [linCell quadCell numCellCheck];
            end
        end
    end
    resFalse = resFalse(1:cntFalse,:);
    resTrue = resTrue(1:cntTrue,:);
    
    res1 = mean(resFalse(:,1)); res2 = std(resFalse(:,1));
    res3 = mean(resFalse(:,2)); res4 = std(resFalse(:,2));
    res5 = mean(resFalse(:,3)); res6 = std(resFalse(:,3));
    res7 = mean(resTrue(:,1)); res8 = std(resTrue(:,1));
    res9 = mean(resTrue(:,2)); res10 = std(resTrue(:,2));
    res11 = mean(resTrue(:,3)); res12 = std(resTrue(:,3));

    disp(['resFalse linCell mean: ',num2str(res1),'     stddev: ',num2str(res2)]);
    disp(['resFalse quadCell mean: ',num2str(res3),'     stddev: ',num2str(res4)]);
    disp(['resFalse DP Cell mean: ',num2str(res5),'     stddev: ',num2str(res6)]);
    disp(['resTrue linCell mean: ',num2str(res7),'     stddev: ',num2str(res8)]);
    disp(['resTrue quadCell mean: ',num2str(res9),'     stddev: ',num2str(res10)]);
    disp(['resTrue DP Cell mean: ',num2str(res11),'     stddev: ',num2str(res12)]);
    disp(['--------------------']);
    
    resList(i,1:13) = [i res1 res2 res3 res4 res5 res6 res7 res8 res9 res10 res11 res12];
    
end
close(h);
disp(['--------------------']);

