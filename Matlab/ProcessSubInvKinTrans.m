InitGlobalVars;

scriptName = 'ProcessSubInvKinTrans';
bothFile = ['ExpRes/',scriptName,'_',datestr(now,'dd-mm-yy','local'),'_',datestr(now,'hh-MM-ss','local')];
matFile = [bothFile '.mat'];
diaryFile = [bothFile,'.txt'];
diary(diaryFile)
disp([scriptName]);

disp(['--------------------']);
dataName = 'HMKinTrans_20pct_NN_CF_opt_sing';
disp([dataName]);
load(['MatlabData/' dataName '.mat']);

rngSeed = 1; % random seed value
rng(rngSeed); % reset random seed so experiments are reproducable
    
CreateSubInvSignLangQueries;
SubInvSignLang;

diary off;
