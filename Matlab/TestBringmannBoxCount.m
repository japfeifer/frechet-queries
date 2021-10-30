InitGlobalVars;

scriptName = 'TestBringmannBoxCount';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

CCTType = 'CCT1';
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
jNum = 500;
kNum = 20;

% dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
%     "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
%     "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
%     "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
%     "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
%     "PenTipData"];

dataList = ["MaskedBoobiesData"];

res = [];
res(size(dataList,2) * jNum * kNum ,3) = 0;
cnt = 1;

h = waitbar(0, 'Test Bringmann Box Count');
for i = 1:size(dataList,2)   
    dataName = char(dataList(i));
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
            ans1 = FrechetDPBringmann2(P,Q,currDist); % calls Brinagmann lessThan and getNumberOfBoxes
            [ans2,numCell] = FrechetDecideFast(P,Q,currDist); % our greedy decider cell counts
            res(cnt,1:3) = [size(P,1) size(Q,1) numCell];
            cnt = cnt + 1;
        end
        if mod(j,500) == 0
            X = [num2str(i),': ',dataName,': ',num2str(j)];
            waitbar(j/jNum, h, X);
        end
    end
end
close(h);
diary off;
a = load (diaryFile); % load in the bringmann box count results
res = [res(1:cnt-1,:) a];
disp(['----------']);
disp(['Number tests: ',num2str(cnt-1)]);
disp(['Mean greedy decider cell cnt: ',num2str(mean(res(:,3)))]);
disp(['Mean Bringmann box cnt: ',num2str(mean(res(:,4)))]);
disp(['Mean size P: ',num2str(mean(res(:,1)))]);
disp(['Mean size Q: ',num2str(mean(res(:,2)))]);

