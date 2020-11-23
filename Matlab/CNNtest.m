% Convolutional Neural Network Experiment (no validation data used in training)

rng(rngSeed); % reset random seed so experiments are reproducable

numFeatures = size(trainMat,2);
numClasses = size(classes,1);
XTrain = reshape(trainMat', [1,1,size(trainMat,2),size(trainMat,1)]);
XTest = reshape(testMat', [1,1,size(testMat,2),size(testMat,1)]);
YTrain = categorical(trainLabels);
YTest = categorical(testLabels);

layers = [ ... 
imageInputLayer([1 1 numFeatures]) % this layer needs the first 3 dimensions of input "XNew"

convolution2dLayer([1 1],100)
batchNormalizationLayer
reluLayer 

% maxPooling2dLayer([1 1]) 
% convolution2dLayer([1 1],300)
% batchNormalizationLayer
% reluLayer 

fullyConnectedLayer(numClasses)
softmaxLayer
classificationLayer]; 

options = trainingOptions('rmsprop', ...
    'MaxEpochs',100, ...
    'MiniBatchSize',8, ...
    'SquaredGradientDecayFactor',0.9, ...
    'GradientThresholdMethod','l2norm', ...
    'ValidationPatience',5, ...
    'InitialLearnRate',1e-4, ...
    'Verbose',false, ...
    'Plots','training-progress'); 

net = trainNetwork(XTrain, YTrain, layers, options);

YPred = classify(net,XTest);

acc = mean(YPred == YTest)
