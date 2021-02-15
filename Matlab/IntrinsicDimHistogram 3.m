
numSamples = 5000;
distList = [];
distList(1,numSamples) = 0;
distList2 = distList;
rng('default'); % reset the random seed so that experiments are reproducable

for i=1:numSamples
    [tmpTraj,trajIdx] = datasample(trajStrData,2,'Replace',false); % uniformly randomly sample two traj
    P = cell2mat(tmpTraj(1,1));
    Q = cell2mat(tmpTraj(2,1));
    
    distCont = ContFrechet(P,Q);
    distList(1,i) = distCont;

    distLB = GetBestConstLB(P,Q,Inf,2,trajIdx(1),trajIdx(2));
    distList2(1,i) = distLB;
    
%     distUB = GetBestUpperBound(P,Q,2,trajIdx(1),trajIdx(2));
%     distList2(1,i) = distUB;
end

intrDim = (mean(distList)^2) / (2 * var(distList));
disp(['Instrinsic Dimensionality (rho): ',num2str(intrDim)]);

figure;
h1 = histogram(distList,200);
hold on
h2 = histogram(distList2,200);
hold off

% edges = [0:0.02:2]; % taxi edges
% h = histogram(distList,edges);

