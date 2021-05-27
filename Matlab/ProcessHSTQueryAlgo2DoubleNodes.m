InitGlobalVars;

scriptName = 'ProcessHSTQueryAlgo2DoubleNodes';
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

scrList = ["MatlabData/HSTPigeonHomingDataSz1000Meth2.mat"; ...
           "MatlabData/HSTFootballDataSz1000Meth2.mat"; ...
           "MatlabData/HSTSyntheticLowSz1000Meth2.mat"; ...
           "MatlabData/HSTSyntheticLowSz10000Meth2.mat"; ...
           "MatlabData/HSTSyntheticHighSz1000Meth2.mat"];
otherList = [0 0 0 0 1 0 50; ...
             0 0 0 0 1 0 50; ...
             0 0 0 0 1 0 50; ...
             0 0 0 0 1 0 50; ...
             0 0 0 0 1 0 50];

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
