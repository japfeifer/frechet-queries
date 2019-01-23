% Simplify all trajectories.  Base the epsilon dist of the simplification
% on a percentage of the trajectory's reach. Run simplification
% using Agarwal method (proc TrajSimp) for epsilon.

tic;
h = waitbar(0, 'Simplify All Trajectories');
trajSimpData = {[]};
sizeData = size(trajData,1);
numDecisionCalls = 0;
totDecisionCalls = 0;

% sizeData = 500;

if sizeData > 0
    for i = 1:sizeData
        currTraj = cell2mat(trajData(i,1));
        currReach = TrajReach(currTraj);
        epsilonDist = reachPercent * currReach;
        
%         currTraj = LinearSimp(currTraj,epsilonDist/2); % Dreimel method

        [currTraj,numDecisionCalls] = TrajSimp(currTraj,epsilonDist); % Agarwal method
        
        totDecisionCalls = totDecisionCalls + numDecisionCalls;
        trajSimpData(i,1) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
        if mod(i,20) == 0
            X = ['Simplify ',num2str(i),'/',num2str(sizeData), ...
                ', ',num2str(totDecisionCalls),' Tot Decision Proc Calls'];
            waitbar(i/sizeData, h, X);
        end
    end
end

close(h);
timeElapsed = toc;