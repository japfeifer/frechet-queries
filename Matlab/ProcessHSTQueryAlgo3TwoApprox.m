InitGlobalVars;

scriptName = 'ProcessHSTQueryAlgo3TwoApprox';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

% dataList = ["TruckData" "SchoolBusData" "PetCatsData" ...
%     "ShippingMississippiData" "ShippingYangtzeData" "FootballData" ...
%     "TaxiData" "BlackBackedGullsData" "PigeonHomingData" ...
%     "MaskedBoobiesData" "KrugerBuffaloData" "TrawlingBatsData" ...
%     "NBABasketballData" "GeoLifeData" "Hurdat2AtlanticData" ...
%     "PenTipData"];

scrList = ["MatlabData/HSTPigeonHomingDataSz1000Meth1.mat"; ...
           "MatlabData/HSTPigeonHomingDataSz10000Meth1.mat"; ...
           "MatlabData/HSTPigeonHomingDataSz100000Meth1.mat"; ...
           "MatlabData/HSTFootballDataSz1000Meth1.mat"; ...
           "MatlabData/HSTFootballDataSz10000Meth1.mat"; ...
           "MatlabData/HSTFootballDataSz100000Meth1.mat"; ...
           "MatlabData/HSTSyntheticLowSz1000Meth1.mat"; ...
           "MatlabData/HSTSyntheticLowSz10000Meth1.mat"; ...
           "MatlabData/HSTSyntheticLowSz100000Meth1.mat"; ...
           "MatlabData/HSTSyntheticHighSz1000Meth1.mat"; ...
           "MatlabData/HSTSyntheticHighSz10000Meth1.mat"; ...
           "MatlabData/HSTSyntheticHighSz100000Meth1.mat"];
otherList = [0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf; ...
             0 0 0 0 0 1 Inf];

disp(['====================']);
for iProc = 1:size(scrList,1)   
    disp(['--------------------']);
    disp([scrList(iProc)]);
    disp([otherList(iProc,:)]);
    
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    
    QueryHST(scrList(iProc),otherList(iProc,:),2,2);  % do a 2-approximation

end

diary off;
