InitGlobalVars;

scriptName = 'ProcessHSTQueryBase2TwoApproxTaxi';
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

scrList = ["MatlabData/HSTTaxiDataSz1000Meth3.mat"; ...
           "MatlabData/HSTTaxiDataSz5000Meth3.mat"; ...
           "MatlabData/HSTTaxiDataSz10000Meth3.mat"; ...
           "MatlabData/HSTTaxiDataSz50000Meth3.mat"; ...
           "MatlabData/HSTTaxiDataSz100000Meth3.mat"; ...
           "MatlabData/HSTTaxiDataSz500000Meth3.mat"; ...
           "MatlabData/HSTTaxiDataSz1000000Meth3.mat"];
otherList = [0 1 0 0 0 0 Inf; ...
             0 1 0 0 0 0 Inf; ...
             0 1 0 0 0 0 Inf; ...
             0 1 0 0 0 0 100; ...
             0 1 0 0 0 0 100; ...
             0 1 0 0 0 0 20; ...
             0 1 0 0 0 0 20];

disp(['====================']);
for iProc = 1:size(scrList,1)   
    disp(['--------------------']);
    disp([scrList(iProc)]);
    disp([otherList(iProc,:)]);
    
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable

    QueryHST(scrList(iProc),otherList(iProc,:),2,2);

end

diary off;
