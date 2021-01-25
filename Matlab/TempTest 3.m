
tic
Q = cell2mat(queryTraj(100,1));

results1 = [];
for i = 1:size(trajStrData,2)
    P = trajStrData(i).traj;
    freDist = ContFrechet(P,Q);
    results1 = [results1; i freDist];
end
results1 = sortrows(results1,2);
toc

tic
qv = EncodeTrajToHV(Q);
toc

tic
results2 = [];
for i = 1:size(trajHyperVector,1)
    CosDist = VectorCosDist(qv,trajHyperVector(i,:));
    results2 = [results2; i CosDist];
end
results2 = sortrows(results2,2,'descend');
results = [results1 results2];
toc