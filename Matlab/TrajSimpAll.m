% Simplify all trajectories.  Base the epsilon dist of the simplification
% on a percentage of the trajectory's reach. Run simplification
% using Agarwal method (proc TrajSimp) for epsilon.

tic;
h = waitbar(0, 'Simplify All Trajectories');
trajSimpStrData = [];
sizeData = size(trajStrData,2);
numDecisionCalls = 0;
totDecisionCalls = 0;

% sizeData = 500;

if sizeData > 0
    for i = 1:sizeData
        currTraj = trajStrData(i).traj;
        currReach = TrajReach(currTraj);
        epsilonDist = reachPercent * currReach;
        
%         currTraj = LinearSimp(currTraj,epsilonDist/2); % Dreimel method

        [currTraj,numDecisionCalls] = TrajSimp(currTraj,epsilonDist); % Agarwal method
        
        totDecisionCalls = totDecisionCalls + numDecisionCalls;
        trajSimpStrData(i).traj = currTraj;
        if mod(i,20) == 0
            X = ['Simplify ',num2str(i),'/',num2str(sizeData), ...
                ', ',num2str(totDecisionCalls),' Tot Decision Proc Calls'];
            waitbar(i/sizeData, h, X);
        end
    end
end

close(h);
timeElapsed = toc;
disp(['Time to run Agarwal et al. simplification (s): ',num2str(timeElapsed)]);