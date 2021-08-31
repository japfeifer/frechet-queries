InitGlobalVars;

scriptName = 'ProcessHSTConst_Football2500';
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

dataList = ["FootballData"];
scrList = ["MatlabData/CCT1FootballData.mat"];
otherList = [1 2500   3 3 10 3 1 1000];

for iProc = 1:size(dataList,1)   
    dataName = char(dataList(iProc));
    disp(['--------------------']);
    disp([dataName]);
    disp([scrList(iProc)]);
    disp([otherList(iProc,:)]);
    
    rngSeed = 1; % random seed value
    rng(rngSeed); % reset random seed so experiments are reproducable
    
    ConstructHST(dataName,scrList(iProc),otherList(iProc,1),otherList(iProc,2),...
                 otherList(iProc,3),otherList(iProc,4),otherList(iProc,5),...
                 otherList(iProc,6),otherList(iProc,7),otherList(iProc,8));
    
    fileNameHST = ['MatlabData/HST' num2str(dataList(iProc)) 'Sz' num2str(otherList(iProc,2)) 'Meth' num2str(otherList(iProc,3)) '.mat'];
    save(fileNameHST,'inP','inpTrajErr','inpTrajErrF','inpTrajPtr','inpTrajSz','inpTrajVert','inpLen','queryStrData','inpTrajRad');
end

diary off;
