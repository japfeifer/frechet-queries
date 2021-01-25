
tic;


for i = 1:20
    P = trajStrData(i).traj;
    P = LinearSimp(P,0);
    currReach = TrajReach(P);
    epsilonDist = reachPercent * currReach;
    Pos1 = 1;
    Pos2 = min(size(P,1),300);
    xyz = P(Pos1,:) == P(Pos2,:);
    ContFrechet(P(Pos1:Pos2,:),cat(1,P(Pos1,:),P(Pos2,:)));
%     DiscreteFrechetDist(P(Pos1:Pos2,:),cat(1,P(Pos1,:),P(Pos2,:)));
%     FrechetDecide(P(Pos1:Pos2,:)',cat(1,P(Pos1,:),P(Pos2,:))',epsilonDist);
end

timeElapsed = toc;