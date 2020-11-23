 disp(['Start Training']);
    if ~exist('doGaussFit','var')
        doGaussFit = 0;
    end
    
    if doGaussFit == 1
        trainMat = trainMat + 0.00001; % can not have zeros for boxcox
        for iBox = 1:size(trainMat,2)
            trainMat(:,iBox) = FitGaussian(trainMat(:,iBox));
        end
        testMat = testMat + 0.00001; % can not have zeros for boxcox
        for iBox = 1:size(testMat,2)
            testMat(:,iBox) = FitGaussian(testMat(:,iBox));
        end
    end
    
    rng(rngSeed); % reset random seed so experiments are reproducable

    if numPredictor == 0
        numPredictor = floor(size(trainMat,2) / 2);
    end
    if numLearner == 0
        numLearner = 50;
    end

    tic;
    
    if classifierCurr == 1 && numTrainCurr == 1 && distType == 4
        t = templateDiscriminant('DiscrimType','diagLinear'); % subspace discriminant, edit distance, low trainers requires this type
    else
        t = templateDiscriminant('DiscrimType','linear','Delta',1.6841e-05,'Gamma',0.046833);   % 'Delta',1.6841e-05    'Gamma',0.046833
    end
    
%     Mdl = fitcensemble(...
%         trainMat, ...
%         trainLabels, ...
%         'Method', 'Subspace', ...
%         'NumLearningCycles', numLearner, ...
%         'Learners',t, ...
%         'NPredToSample', numPredictor, ...
%         'OptimizeHyperparameters', {'Gamma'}, ...
%         'HyperparameterOptimizationOptions',struct('UseParallel',true));

    Mdl = fitcensemble(...
        trainMat, ...
        trainLabels, ...
        'Method', 'Subspace', ...
        'NumLearningCycles', numLearner, ...
        'Learners',t, ...
        'NPredToSample', numPredictor);
    
    toc;
    
    disp(['Training Complete']);
    
    tic;
    
    disp(['Start Prediction']);
    classifierRes = predict(Mdl,testMat);
    disp(['Prediction Complete']);
    
    toc;

    % compute classifier accuracy
    classifierRes(:,2) = testLabels;
    classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
    classAccuracy = mean(classifierRes(:,3)) * 100;  
    disp(['Classification accuracy: ',num2str(classAccuracy)]);
    