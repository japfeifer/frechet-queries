% initialize dataset variables

datasetType = 6;

if datasetType == 1  % Trucks dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.04;
    Emin = 0.005;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 2  % School Bus dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.04;
    Emin = 0.005;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 2;
 elseif datasetType == 3  % Cats dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.04;
    Emin = 0.005;
    reachPercent = 0.25;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 4  % Shipping Mississippi dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.0500;
    Emin = 0.002;
    reachPercent = 0.01;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 5  % Shipping Yangtze dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.00100;
    Emin = 0.00050;
    reachPercent = 0.01;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 6  % Football dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 500;
    Emin = 50;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 7  % Taxi dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.0260;
    Emin = 0.005;
    reachPercent = 0.03;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 8  % Black Backed Gulls dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 15.00;
    Emin = 1.00;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 9  % Pigeon Homing dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.2;
    Emin = 0.01;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 10  % Masked Boobies dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.20;
    Emin = 0.05;
    reachPercent = 0.01;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 11  % Kruger Buffalo dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.12;
    Emin = 0.01;
    reachPercent = 0.10;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 12  % Trawling Bats dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.00004;
    Emin = 0.000003;
    reachPercent = 0.01;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 13  % NBA Basketball dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 1.8;
    Emin = 0.5;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 3;
elseif datasetType == 14  % GeoLife dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.012;
    Emin = 0.002;
    reachPercent = 0.02;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 15  % HURDAT2 dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.10;
    Emin = 0.01;
    reachPercent = 0.01;
    Eapx = 0.5;
    numDim = 2;
elseif datasetType == 16  % Pen Tip dataset
    totalTraj = size(trajData,1);
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    Emax = 0.45;
    Emin = 0.10;
    reachPercent = 0.01;
    Eapx = 2.0;
    numDim = 2;
end

