CCTType = 'CCT1';
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
jNum = 1000;
kNum = 100;
timeOldFreDP = 0;
timeNewFreDP = 0;

% dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
%     "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
%     "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
%     "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
%     "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
%     "PenTipData"];

dataList = ["PenTipData"];

h = waitbar(0, 'Test Fast Frechet');
for i = 1:size(dataList,2)   
    dataName = char(dataList(i));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    InitDatasetVars(dataName);
    CreateTrajStr;
    
    for j = 1:jNum

        % get a P and Q curve
        sz = size(trajStrData,2);
        idxP = randi(sz);
        idxQ = randi(sz);
        P = trajStrData(idxP).traj;
        Q = trajStrData(idxQ).traj;
        
        % get UB and LB
        distLB = GetBestConstLB(P,Q,Inf,2,idxP,idxQ);
        distUB = GetBestUpperBound(P,Q,2,idxP,idxQ);
        
        distLB = round(distLB,7)+0.00000009;
        distLB = fix(distLB * 7^10)/7^10;
        distUB = round(distUB,7)+0.00000009;
        distUB = fix(distUB * 7^10)/7^10;
        
        if distLB == distUB
            distList = distLB;
        else
            distList = distLB: (distUB-distLB) / (kNum-1) :distUB;
        end
        
        for k = 1:size(distList,2)
            currDist = distList(k);
            
            tOldFreDP = tic;
%             ans1 = FrechetDecide(P,Q,currDist,1,0,0);
            ans1 = FrechetDPBringmann(P,Q,currDist);
%             ans1 = FrechetDistBringmann(P,Q);
            timeOldFreDP = timeOldFreDP + toc(tOldFreDP);
            
            tNewFreDP = tic;
            ans2 = FrechetDecideFast(P,Q,currDist);
%             ans2 = ContFrechetPrecision(P,Q);
            timeNewFreDP = timeNewFreDP + toc(tNewFreDP);
            
            if ans1 ~= ans2
                error('different results');
            end
        end
        if mod(j,500) == 0
            X = [num2str(i),': ',dataName,': ',num2str(j)];
            waitbar(j/jNum, h, X);
        end
    end
end
close(h);
disp(['----------']);
disp(['timeOldFreDP: ',num2str(timeOldFreDP)]);
disp(['timeNewFreDP: ',num2str(timeNewFreDP)]);
disp(['New DP factor faster: ',num2str(timeOldFreDP / timeNewFreDP)]);
