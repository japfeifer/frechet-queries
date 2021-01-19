% initialize synthetic data variables

if strcmp(dataName,'SyntheticData1') == 1  % Synthetic 1 dataset - baseline
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData2') == 1  % Synthetic 2 - same as baseline, except numDiffTraj = 5500, numSimilarTraj = 1 
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 5500;
    numSimilarTraj = 1;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData3') == 1 % Synthetic 3 -  same as baseline, except numDiffTraj = 220, numSimilarTraj = 25
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 220;
    numSimilarTraj = 25;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData4') == 1 % Synthetic 4 -  same as baseline, except numDiffTraj = 110, numSimilarTraj = 50
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 110;
    numSimilarTraj = 50;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData5') == 1 % Synthetic 5 -  same as baseline, except numDiffTraj = 55, numSimilarTraj = 100
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 55;
    numSimilarTraj = 100;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData6') == 1 % Synthetic 6 -  same as baseline, except straightFactor = 0.5, maxVertDist = 4
    dimUnits = 500;
    maxVertDist = 4;
    straightFactor = 0.5;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData7') == 1 % Synthetic 7 -  same as baseline, except straightFactor = 0.8, maxVertDist = 5
    dimUnits = 500;
    maxVertDist = 5;
    straightFactor = 0.8;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData8') == 1 % Synthetic 8 -  same as baseline, except straightFactor = 0.9, maxVertDist = 7
    dimUnits = 500;
    maxVertDist = 7;
    straightFactor = 0.9;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData9') == 1 % Synthetic 9 -  same as baseline, except straightFactor = 0.99, maxVertDist = 8
    dimUnits = 500;
    maxVertDist = 8;
    straightFactor = 0.99;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData10') == 1 % Synthetic 10 -  same as baseline, except avgNumVertices = 25
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 25;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData11') == 1 % Synthetic 11 -  same as baseline, except avgNumVertices = 35
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 35;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData12') == 1 % Synthetic 12 -  same as baseline, except avgNumVertices = 45
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 45;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData13') == 1 % Synthetic 13 -  same as baseline, except avgNumVertices = 55
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 55;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData14') == 1 % Synthetic 14 -  same as baseline, except numDiffTraj = 1050
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 1050;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData15') == 1 % Synthetic 15 -  same as baseline, except numDiffTraj = 2050
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 2050;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData16') == 1 % Synthetic 16 -  same as baseline, except numDiffTraj = 3050
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 3050;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData17') == 1 % Synthetic 17 -  same as baseline, except numDiffTraj = 4050
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 4050;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData18') == 1 % Synthetic 18 - same as baseline, except numDim = 4
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 4;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData19') == 1 % Synthetic 19 - same as baseline, except numDim = 8
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 8;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData20') == 1 % Synthetic 20 - same as baseline, except numDim = 16
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 16;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData21') == 1 % Synthetic 21 - same as baseline, except numDim = 32
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 15;
    numDiffTraj = 550;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 32;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData22') == 1 % Synthetic 22 - numDiffTraj = 105, numSimilarTraj = 100, avgNumVertices = 45, straightFactor = 0.99, maxVertDist = 8,  numDim = 2, numNoiseTraj = 500
    dimUnits = 500;
    maxVertDist = 8;
    straightFactor = 0.99;
    avgNumVertices = 45;
    numDiffTraj = 105;
    numSimilarTraj = 100;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData23') == 1 % Synthetic 23 - numDiffTraj = 10500, numSimilarTraj = 1, avgNumVertices = 10, straightFactor = 0.35, maxVertDist = 3,  numDim = 2, numNoiseTraj = 500
    dimUnits = 500;
    maxVertDist = 3;
    straightFactor = 0.35;
    avgNumVertices = 10;
    numDiffTraj = 10500;
    numSimilarTraj = 1;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData24') == 1  % Synthetic 24 dataset - modified baseline to 1,000,000 trajectories, 10 vertices
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 10;
    numDiffTraj = 100050;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
elseif strcmp(dataName,'SyntheticData25') == 1  % Synthetic 24 dataset - modified baseline to 1,000,000 trajectories, 10 vertices
    dimUnits = 500;
    maxVertDist = 6;
    straightFactor = 0.95;
    avgNumVertices = 10;
    numDiffTraj = 1000050;
    numSimilarTraj = 10;
    numNoiseTraj = 500;
    totalTraj = numDiffTraj * numSimilarTraj;
    doDFD = false;
    numQueryTraj = 1000;
    genQueryType = 2; 
    tau = 10;
    eAdd = 0;
    reachPercent = 0.01;
    eMult = 0.03;
    numDim = 2;
    decimalPrecision = 1e-8;
    
end

 