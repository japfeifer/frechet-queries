InitGlobalVars;

scriptName = 'ProcessHSTQueryBase3_P500';
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
scrList = ["MatlabData/HSTCCTPigeonHomingDataSz500.mat"; ...
           "MatlabData/HSTCCTFootballDataSz500.mat"; ...
           "MatlabData/HSTCCTSyntheticLowSz500.mat"; ...
           "MatlabData/HSTCCTSyntheticHighSz500.mat"];
otherList = [0 0 1 0 0 0 Inf; ...
             0 0 1 0 0 0 Inf; ...
             0 0 1 0 0 0 Inf; ...
             0 0 1 0 0 0 Inf];

disp(['====================']);
for iProc = 1:size(scrList,1)   
    disp(['--------------------']);
    disp([scrList(iProc)]);
    disp([otherList(iProc,:)]);
    
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    
    QueryHST(scrList(iProc),otherList(iProc,:));

end

diary off;
