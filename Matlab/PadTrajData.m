% pad trajectories in the main dataset trajData

numPadVert = 4;

for i = 1:size(trajData,1)
    P = cell2mat(trajData(i,1));
    padP = PadTraj(P,numPadVert);
    trajData(i,1) = mat2cell(padP,size(padP,1),size(padP,2));
end