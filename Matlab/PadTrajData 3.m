% pad trajectories in the main dataset trajStrData

numPadVert = 4;

for i = 1:size(trajStrData,2)
    P = trajStrData(i).traj;
    padP = PadTraj(P,numPadVert);
    trajStrData(i).padtraj = padP;
end