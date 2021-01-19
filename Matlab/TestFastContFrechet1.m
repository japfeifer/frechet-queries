CCTType = 'CCT1';
rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
jNum = 500;
SimplFlg = 1;
timeOldFreDist = 0;
timeNewFreDist = 0;

dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
    "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
    "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
    "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
    "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
    "PenTipData"];

h = waitbar(0, 'Test Fast Cont Frechet Distance');
for i = 1:size(dataList,2)   
    dataName = char(dataList(i));
    disp(['--------------------']);
    disp([CCTType dataName]);
    load(['MatlabData/' CCTType dataName '.mat']);
    
    for j = 1:jNum
        if mod(j,100) == 0
            X = [num2str(i),': ',dataName,': ',num2str(j)];
            waitbar(j/jNum, h, X);
        end
            
        % get a P and Q curve
        if SimplFlg == 1
            sz = size(trajData,1);
            idxP = randi(sz);
            idxQ = randi(sz);
            P = cell2mat(trajData(idxP,1));
            Q = cell2mat(trajData(idxQ,1));
        else
            sz = size(trajOrigData,1);
            idxP = randi(sz);
            idxQ = randi(sz);
            P = cell2mat(trajOrigData(idxP,1));
            Q = cell2mat(trajOrigData(idxQ,1));
        end

        tOldFreDist = tic;
        ans1 = ContFrechet(P,Q,1,1,1);
        timeOld = toc(tOldFreDist);
        timeOldFreDist = timeOldFreDist + timeOld;

        tNewFreDist = tic;
        ans2 = ContFrechet(P,Q,2,1,1);
        timeNew =  toc(tNewFreDist);
        timeNewFreDist = timeNewFreDist + timeNew;

%         if round(ans1,7) ~= round(ans2,7)
%             error('different results');
%         end
    end
    disp(['timeOldFreDist: ',num2str(timeOldFreDist)]);
    disp(['timeNewFreDist: ',num2str(timeNewFreDist)]);
    disp(['New Dist factor faster: ',num2str(timeOldFreDist / timeNewFreDist)]);
    timeOldFreDist = 0; timeNewFreDist = 0;
end

close(h);

