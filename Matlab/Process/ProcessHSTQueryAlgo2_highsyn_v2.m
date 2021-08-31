InitGlobalVars;

scriptName = 'ProcessHSTQueryAlgo2_highsyn_v2';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

scrList = ["MatlabData/HSTSyntheticHighSz50000Meth3_v2.mat"];
otherList = [0 0 0 0 1 0 4];

% the HSTSyntheticHighSz50000Meth3_v2 dataset uses the queries from the
% HSTSyntheticHighSz100000Meth3 dataset

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
