% Calculate Trajectory Simplification Signature
tic;

% calc simp sig for each data traj
for i = 1:size(trajData,1) 
    tmpSimpSig = SimpSig(cell2mat(trajData(i,1)));
    trajData(i,3) = mat2cell(tmpSimpSig,size(tmpSimpSig,1),size(tmpSimpSig,2));
end

% calc simp sig for each query traj
for i = 1:size(queryTraj,1) 
    tmpSimpSig = SimpSig(cell2mat(queryTraj(i,1)));
    queryTraj(i,17) = mat2cell(tmpSimpSig,size(tmpSimpSig,1),size(tmpSimpSig,2));
end

timeElapsed = toc;