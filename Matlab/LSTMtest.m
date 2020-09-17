% Experiment using long short-term memory (LSTM) classification network.
% An LSTM network is a type of recurrent neural network (RNN) that learns 
% long-term dependencies between time steps of sequence data.
%
% Hard-coded for experiments that have 8 train seq/class, with 73 classes.

rng(rngSeed); % reset random seed so experiments are reproducable

XTrain = {[]};
YTrain = [];
trainCnt = 1;
for i=1:size(trainMat,1)
    tmpMat = trainMat(i,:)';
    XTrain(i,1) = mat2cell(tmpMat,size(tmpMat,1),size(tmpMat,2));
    YTrain(i,1) = trainLabels(i,1);
end
YTrain = categorical(YTrain);

XTest = {[]};
for i=1:size(testMat,1)
    tmpMat = testMat(i,:)';
    XTest(i,1) = mat2cell(tmpMat,size(tmpMat,1),size(tmpMat,2));
end
YTest = categorical(testLabels);

numFeatures = size(trainMat,2);
numHiddenUnits = 100;
numClasses = size(classes,1);

layers = [ ...
    sequenceInputLayer(numFeatures)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

miniBatchSize = 27;

% options = trainingOptions('adam', ...
%     'ExecutionEnvironment','cpu', ...
%     'MaxEpochs',100, ...
%     'MiniBatchSize',miniBatchSize, ...
%     'ValidationData',{XTest,YTest}, ...
%     'GradientThreshold',2, ...
%     'Shuffle','every-epoch', ...
%     'Verbose',false, ...
%     'Plots','training-progress');

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',100, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',2, ...
    'Shuffle','every-epoch', ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(XTrain,YTrain,layers,options);

YPred = classify(net,XTest,'MiniBatchSize',miniBatchSize);
acc = mean(YPred == YTest)