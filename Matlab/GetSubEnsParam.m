% get the subspace ensemble parameters

maxPredictor = size(trainMat,2) - 1;
parmRes = [];
for i = 10:10:maxPredictor
    rng(rngSeed); % reset random seed so experiments are reproducable
    numPredictor = i;
    numLearner = 30;
    % t = templateDiscriminant('DiscrimType','linear','Gamma',0.01);
    t = templateDiscriminant('DiscrimType','linear');
    Mdl2 = fitcensemble(...
        trainMat, ...
        trainLabels, ...
        'Method', 'Subspace', ...
        'NumLearningCycles', numLearner, ...
        'Learners', 'discriminant', ...
        'Learners',t, ...
        'NPredToSample', numPredictor);
    classifierRes = predict(Mdl2,testMat);

    % compute classifier accuracy
    classifierRes(:,2) = testLabels;
    classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
    classAccuracy = mean(classifierRes(:,3)) * 100;  
    parmRes(i) = classAccuracy;
    disp(['i: ',num2str(i),' Classification accuracy: ',num2str(classAccuracy)]);
end