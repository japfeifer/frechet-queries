% Test distances

sSize = size(trajStrData,2);
numQuery = 5000;
rng('default'); % reset the random seed so that experiments are reproducable
time1 = 0;
time2 = 0;
for i = 1:numQuery
    P = trajStrData(randi([1 sSize])).traj;
    Q = trajStrData(randi([1 sSize])).traj;

    % continuous frechet
    t1 = tic;
    distCont1 = SubTrajContFrechetPrecision(P,Q,decimalPrecision);
    time1 = time1 + toc(t1);
    
    t2 = tic;
    distCont2 = SubTrajContFrechetPrecisionFast(P,Q,decimalPrecision);
    time2 = time2 + toc(t2);


    if distCont1 ~= distCont2
        error('dist not equal');
    end
    
end

disp(['time1: ',num2str(time1)]);
disp(['time2: ',num2str(time2)]);