disp(['------']);
Qid = 10;

Q = queryStrData(Qid).traj;
dist = ContFrechet(inP(677:678,:),Q);
disp(['dist: ' sprintf('%0.10f',dist)]);

Q = queryStrData(Qid).traj;
dist = ContFrechet(inP([108 111 112 122],:),Q);
disp(['dist: ' sprintf('%0.10f',dist)]);

Q = queryStrData(Qid).traj;
dist = ContFrechet(inP([112 122 127 130 131 134 139],:),Q);
disp(['dist: ' sprintf('%0.10f',dist)]);

disp(['err:  ' sprintf('%0.10f',inpTrajErr(simpLevelCCT))]);

% Q = inP(404:462,:);
% queryStrData(100).traj = Q;
% PreprocessQuery(100);

