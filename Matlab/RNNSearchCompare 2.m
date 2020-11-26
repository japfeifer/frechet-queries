% RNNSearchCompare
% 
% Do Prune, Reduce, and Decide Stages

function RNNSearchCompare(typeQ,eVal,stage)

    global rnnSearchResults cntNF cntConLB cntBBUB cntADF cntADFR
    global cntADFD cntInClus cntBBUBConst cntBBUBLin cntUBClust queryTraj

    cntNF = 0; cntConLB = 0; cntBBUB = 0; cntADF = 0; cntADFR = 0; 
    cntADFD = 0; cntInClus = 0; cntBBUBConst = 0; cntBBUBLin = 0; cntUBClust = 0;
    numQ = size(queryTraj,1);
    
    h = waitbar(0, 'RNN Search Compare');

    for i = 1:numQ  % do NN search for each query traj

        % get the tau distance variable
        tau = cell2mat(queryTraj(i,25));

        RNN(i,typeQ,tau,eVal,stage,1);

        if mod(i,100) == 0
            X = ['RNN Search Compare: ',num2str(i),'/',num2str(numQ)];
            waitbar(i/numQ, h, X);
        end
    end

    % number of cluster centre tree distance computations
    distList = [];
    for i = 1:size(queryTraj,1)
        distList = [distList; cell2mat(queryTraj(i,6))]; 
    end
    dAvg = mean(distList);

    fdpAvg = 0;

    disp(['-----------------']);
    disp(['numNodeDist: ',num2str(dAvg)]);
    disp(['ResCCT: ',num2str((cntConLB+cntInClus)/numQ)]);
    disp(['avgInClus: ',num2str(cntInClus/numQ)]);
    disp(['cntUBClust: ',num2str(cntUBClust/numQ)]);
    disp(['avgBBUB: ',num2str(cntBBUB/numQ)]);
    disp(['avgADF: ',num2str(cntADF/numQ)]);
    disp(['avgADFR: ',num2str(cntADFR/numQ)]);
    disp(['avgADFD: ',num2str(cntADFD/numQ)]);
    disp(['avgNF: ',num2str(cntNF/numQ)]);
    disp(['avgFDP: ',num2str(fdpAvg)]);

    rnnSearchResults = [dAvg (cntConLB+cntInClus)/numQ cntInClus/numQ cntUBClust/numQ cntBBUB/numQ cntADF/numQ cntADFR/numQ cntADFD/numQ cntNF/numQ fdpAvg];

    close(h);

end