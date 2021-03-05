% Generate data used to do inverse sub-traj search experiment on KinTrans
% sign language data

ProcessHMKinTrans_20pct_NN_CF_opt_sing; % run the experiment to generate the data

save('MatlabData\HMKinTrans_20pct_NN_CF_opt_sing.mat','allClasses','classes','classIDs',...
    'clusterNode','clusterTrajNode','CompMoveData','queryResults','querySet',...
    'queryStrData','trainSet','trajDistList','trajStrData','wordIDs');