InitGlobalVars;

scriptName = 'ProcessHSTSetM';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

scrList = ["MatlabData/HSTPigeonHomingDataSz10000Meth3.mat"; ...
           "MatlabData/HSTPigeonHomingDataSz10000Meth3.mat"; ...
           "MatlabData/HSTPigeonHomingDataSz10000Meth3.mat"; ...
           "MatlabData/HSTFootballDataSz10000Meth3.mat"; ...
           "MatlabData/HSTFootballDataSz10000Meth3.mat"; ...
           "MatlabData/HSTFootballDataSz10000Meth3.mat"];

otherList = [0 0 0 0 0 1 20 500; ...
             0 0 0 0 0 1 20 1000; ...
             0 0 0 0 0 1 20 1500; ...
             0 0 0 0 0 1 20 500; ...
             0 0 0 0 0 1 20 1000; ...
             0 0 0 0 0 1 20 1500];

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
