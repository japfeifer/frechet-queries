InitGlobalVars;

scriptName = 'ProcessHSTQueryAlgo2Meth3';
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

scrList = ["MatlabData/HSTFootballDataSz1000Meth3.mat"; ...
           "MatlabData/HSTSyntheticLowSz1000Meth3.mat"; ...
           "MatlabData/HSTSyntheticLowSz10000Meth3.mat"; ...
           "MatlabData/HSTSyntheticHighSz1000Meth3.mat"];
otherList = [0 0 0 0 1 0 Inf; ...
             0 0 0 0 1 0 Inf; ...
             0 0 0 0 1 0 Inf; ...
             0 0 0 0 1 0 Inf];

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
