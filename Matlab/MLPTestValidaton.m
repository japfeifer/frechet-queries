% MLP Neural Network Experiment (validation data is used in training)

rng(rngSeed); % reset random seed so experiments are reproducable

allClasses = CompMoveData(:,1);
classes = unique(allClasses);

numFeatures = size(trainMat,2);
numClasses = size(classes,1);
XTrain = trainMat;
XTest = testMat;
YTrain = categorical(trainLabels);
YTest = categorical(testLabels);

XValidation = XTest;
YValidation = YTest;

layers = [featureInputLayer(numFeatures,'Normalization', 'zscore')
    fullyConnectedLayer(100)
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

miniBatchSize = 8;

options = trainingOptions('sgdm', ...
    'MaxEpochs',80, ...
    'Shuffle','every-epoch', ...
    'MiniBatchSize',16, ...
    'Verbose',false, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationPatience',Inf, ...
    'Plots','training-progress'); 


tic;
net = trainNetwork(XTrain, YTrain, layers, options);
toc;

tic;
YPred = classify(net,XTest);
toc;

acc = mean(YPred == YTest);
disp(['Classification accuracy: ',num2str(acc)]);
disp(['Test Seq correct: ',num2str(sum(YPred == YTest))]);
disp(['Test Seq incorrect: ',num2str(size(YTest,1) - sum(YPred == YTest))]);
