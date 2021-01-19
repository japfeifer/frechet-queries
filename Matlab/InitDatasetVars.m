% initialize dataset variables

function InitDatasetVars(datasetType)

    global doDFD numQueryTraj genQueryType tau eAdd reachPercent eMult numDim decimalPrecision

    if strcmp(datasetType,'TruckData') == 1  % Trucks dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.04;
        eAdd = 0.005;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'SchoolBusData') == 1  % School Bus dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.04;
        eAdd = 0.005;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
     elseif strcmp(datasetType,'PetCatsData') == 1  % Pet Cats dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.04;
        eAdd = 0.005;
        reachPercent = 0.25;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'ShippingMississippiData') == 1  % Shipping Mississippi dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.0500;
        eAdd = 0.002;
        reachPercent = 0.01;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'ShippingYangtzeData') == 1  % Shipping Yangtze dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.00100;
        eAdd = 0.00050;
        reachPercent = 0.01;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'FootballData') == 1  % Football dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 500;
        eAdd = 50;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'TaxiData') == 1  % Taxi dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.0260;
        eAdd = 0.005;
        reachPercent = 0.03;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'BlackBackedGullsData') == 1  % Black Backed Gulls dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 15.00;
        eAdd = 1.00;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'PigeonHomingData') == 1  % Pigeon Homing dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.2;
        eAdd = 0.01;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'MaskedBoobiesData') == 1  % Masked Boobies dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.20;
        eAdd = 0.05;
        reachPercent = 0.01;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'KrugerBuffaloData') == 1  % Kruger Buffalo dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.12;
        eAdd = 0.01;
        reachPercent = 0.10;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'TrawlingBatsData') == 1  % Trawling Bats dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.00004;
        eAdd = 0.000003;
        reachPercent = 0.01;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'NBABasketballData') == 1  % NBA Basketball dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 1.8;
        eAdd = 0.5;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 3;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'GeoLifeData') == 1  % GeoLife dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.012;
        eAdd = 0.002;
        reachPercent = 0.02;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'Hurdat2AtlanticData') == 1  % HURDAT2 dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.10;
        eAdd = 0.01;
        reachPercent = 0.01;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    elseif strcmp(datasetType,'PenTipData') == 1  % Pen Tip dataset
        doDFD = false;
        numQueryTraj = 1000;
        genQueryType = 2; 
        tau = 0.45;
        eAdd = 0.10;
        reachPercent = 0.01;
        eMult = 0.5;
        numDim = 2;
        decimalPrecision = 1e-8;
    else
        error('datasetType unknown');
    end
end

