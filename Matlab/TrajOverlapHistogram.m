
[stabMean,stabSTD] = GetCCTTrajOverlap();

disp(['Num Overlap Nodes Mean: ',num2str(mean(trajOverlapNodesCnt))]);
disp(['Num Overlap Nodes STD: ',num2str(std(trajOverlapNodesCnt))]);

figure;
h1 = histogram(trajOverlapNodesCnt,40);
hold on

% edges = [0:0.02:2]; % taxi edges
% h = histogram(distList,edges);

