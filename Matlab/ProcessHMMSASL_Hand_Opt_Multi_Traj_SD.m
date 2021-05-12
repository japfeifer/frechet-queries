% Human Movement Experiment - sub model

InitGlobalVars;

scriptName = 'ProcessHMMSASL_Hand_Opt_Multi_Traj_SD';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)

resultList = {[]};

disp(['--------------------']);
disp([scriptName]);

batchFlg = 1;
datasetType = 7; % 1 = KinTrans, 2 = MHAD, 3 = LM, 4 = UCF
classifierCurr = 1;  % 1 = subspace discriminant compute all distances, 2 = NN search
trajDefTypeCurr = 2; % Trajectory definition type, 1 = append to a single traj, 2 = insert to a traj set
doTrainSplit = 1;
reachPctCurr = 0;
acc_iter_def = [2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 ...
                     2102 2103 2104 2105 2106 2107 2108 2109 2110 2111 2112 2113 2114 2115 2116 2117 2118 2119 2120 2121 2122 ...
                2201      2203 2204 2205 2206 2207 2208 2209 2210 2211 2212 2213 2214 2215 2216 2217 2218 2219 2220 2221 2222 ...
                2301 2302 2303 2304      2306 2307 2308 2309 2310 2311 2312 2313 2314 2315 2316 2317 2318 2319 2320 2321 2322 ...
                2401 2402 2403 2404 2405 2406 2407 2408 2409 2410 2411 2412 2413 2414 2415 2416 2417 2418 2419 2420 2421 2422 ...
                2501 2502 2503 2504 2505 2506 2507 2508 2509 2510 2511 2512 2513 2514 2515 2516 2517 2518 2519 2520 2521 2522 ...
                2601 2602 2603 2604 2605 2606 2607      2609 2610 2611 2612 2613 2614 2615 2616 2617 2618 2619 2620 2621 2622 ...
                2701 2702 2703 2704 2705 2706 2707 2708 2709 2710 2711 2712 2713 2714 2715 2716 2717 2718 2719 2720 2721 2722 ...
                2801 2802 2803 2804 2805 2806 2807 2808 2809 2810 2811 2812 2813 2814 2815 2816 2817 2818 2819 2820 2821 2822]; % accuracy iteration traj def id's
numPredictor = 0;
numLearner = 100;
featureSetNum = 5;
normDistCurr = 0;
kCurr = 0;
numTrainCurr = -1;
distMeasCurr = [1 0 0 0];
% distMeasCurr = [1 1 0 0];
% seqNormalSetCurr = [0 0 0 0; 1 0 0 0; 0 1 0 0; 1 0 1 0; 0 1 1 0; 1 0 1 1; 0 1 1 1];
seqNormalSetCurr = [0 1 1 1];
numTestCurr = -1;
trainSubCurr = [1];
testSubCurr = [2];
trainSampleCurr = 10;
testSampleCurr = 0;
edrTol = 0.15;  % edit distance tolerance
% these variables should never be changed for this type of experiment
implicitErrorFlg = 0;
ConstructCCTType = 1;
trainMethodCurr = 1;
bestTrainRepFlgCurr = 0;
swapKFoldCurr = 0;

groupClassesFlg = 0; 
subsetClassesFlg = 0;
groupClassesList = {[]}; 
subsetClassesList = [];
featureSetClass = [];
testSetClass = [];
trainSetClass = [];
testSetList = [];

doIterNumJtsIncl = 1;
% iterNumJtsIncl = 3;
% doSVMFlg = 1;
% doDMmMin = 15;

aggFlg = 1;
totBodyJts = 9; 
mapCanonJts =  [2001 1; 2002 1; 2003 1; 2004 1; 2005 1; 2006 1; 2007 1; 2008 1; 2009 1; 2010 1; 2011 1; 2012 1; 2013 1; 2014 1; 2015 1; 2016 1; 2017 1; 2018 1; 2019 1; 2020 1; 2021 1; 2022 1; ...
                        2102 2; 2103 2; 2104 2; 2105 2; 2106 2; 2107 2; 2108 2; 2109 2; 2110 2; 2111 2; 2112 2; 2113 2; 2114 2; 2115 2; 2116 2; 2117 2; 2118 2; 2119 2; 2120 2; 2121 2; 2122 2; ...
                2201 3;         2203 3; 2204 3; 2205 3; 2206 3; 2207 3; 2208 3; 2209 3; 2210 3; 2211 3; 2212 3; 2213 3; 2214 3; 2215 3; 2216 3; 2217 3; 2218 3; 2219 3; 2220 3; 2221 3; 2222 3; ...
                2301 4; 2302 4; 2303 4; 2304 4;         2306 4; 2307 4; 2308 4; 2309 4; 2310 4; 2311 4; 2312 4; 2313 4; 2314 4; 2315 4; 2316 4; 2317 4; 2318 4; 2319 4; 2320 4; 2321 4; 2322 4; ...
                2401 5; 2402 5; 2403 5; 2404 5; 2405 5; 2406 5; 2407 5; 2408 5; 2409 5; 2410 5; 2411 5; 2412 5; 2413 5; 2414 5; 2415 5; 2416 5; 2417 5; 2418 5; 2419 5; 2420 5; 2421 5; 2422 5; ...
                2501 6; 2502 6; 2503 6; 2504 6; 2505 6; 2506 6; 2507 6; 2508 6; 2509 6; 2510 6; 2511 6; 2512 6; 2513 6; 2514 6; 2515 6; 2516 6; 2517 6; 2518 6; 2519 6; 2520 6; 2521 6; 2522 6; ...
                2601 7; 2602 7; 2603 7; 2604 7; 2605 7; 2606 7; 2607 7;         2609 7; 2610 7; 2611 7; 2612 7; 2613 7; 2614 7; 2615 7; 2616 7; 2617 7; 2618 7; 2619 7; 2620 7; 2621 7; 2622 7; ...
                2701 8; 2702 8; 2703 8; 2704 8; 2705 8; 2706 8; 2707 8; 2708 8; 2709 8; 2710 8; 2711 8; 2712 8; 2713 8; 2714 8; 2715 8; 2716 8; 2717 8; 2718 8; 2719 8; 2720 8; 2721 8; 2722 8; ...
                2801 9; 2802 9; 2803 9; 2804 9; 2805 9; 2806 9; 2807 9; 2808 9; 2809 9; 2810 9; 2811 9; 2812 9; 2813 9; 2814 9; 2815 9; 2816 9; 2817 9; 2818 9; 2819 9; 2820 9; 2821 9; 2822 9]; 

% output variable selections
disp(['datasetType: ',num2str(datasetType)]);
disp(['classifierCurr: ',num2str(classifierCurr)]);
disp(['trajDefTypeCurr: ',num2str(trajDefTypeCurr)]);
disp(['acc_iter_def: ',num2str(acc_iter_def)]);
disp(['numPredictor: ',num2str(numPredictor)]);
disp(['numLearner: ',num2str(numLearner)]);
disp(['featureSetNum: ',num2str(featureSetNum)]);
disp(['normDistCurr: ',num2str(normDistCurr)]);
disp(['kCurr: ',num2str(kCurr)]);
disp(['numTrainCurr: ',num2str(numTrainCurr)]);
disp(['distMeasCurr: ',num2str(distMeasCurr)]);
for i = 1:size(seqNormalSetCurr,1)
    disp(['seqNormalSetCurr: ',num2str(seqNormalSetCurr(i,:))]);
end
disp(['numTestCurr: ',num2str(numTestCurr)]);
disp(['trainSubCurr: ',num2str(trainSubCurr)]);
disp(['testSubCurr: ',num2str(testSubCurr)]);
disp(['trainSampleCurr: ',num2str(trainSampleCurr)]);
disp(['testSampleCurr: ',num2str(testSampleCurr)]);
disp(['edrTol: ',num2str(edrTol)]);
disp(['implicitErrorFlg: ',num2str(implicitErrorFlg)]);
disp(['ConstructCCTType: ',num2str(ConstructCCTType)]);
disp(['trainMethodCurr: ',num2str(trainMethodCurr)]);
disp(['bestTrainRepFlgCurr: ',num2str(bestTrainRepFlgCurr)]);
disp(['swapKFoldCurr: ',num2str(swapKFoldCurr)]);

% load the dataset
timeLoad = 0; tLoad = tic;
LoadModelDataset;
timeLoad = timeLoad + toc(tLoad);
disp(['Data Load Time (sec): ',num2str(timeLoad)]);

% change Subject to Xview
MSASLSubjectToXview;

rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
RunSubModel3;

% output the final results
for i = 1:size(resultList,1)
   disp(['distType: ',num2str(cell2mat(resultList(i,1))), ...
         ' seqNormalCurr: ',num2str(cell2mat(resultList(i,2))), ...
         ' Best Accuracy: ',num2str(cell2mat(resultList(i,3))), ...
         ' Best Definition: ',num2str(cell2mat(resultList(i,4)))]);
end   

save(matFile,'resultList');
diary off;

