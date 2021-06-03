% Test distances

InitGlobalVars;
load('MatlabData/CCT1PigeonHomingData.mat');

sSize = size(trajOrigData,1);
numQuery = 100000;
rng('default'); % reset the random seed so that experiments are reproducable
time1 = 0;
time2 = 0;
for i = 1:numQuery
    P = cell2mat(trajOrigData(randi([1 sSize]),1));
    Q = cell2mat(trajOrigData(randi([1 sSize]),1));

    % continuous frechet
    t1 = tic;
    distCont1 = ContFrechetPrecision(P,Q);
    time1 = time1 + toc(t1);
    
end

disp(['time1: ',num2str(time1)]);
