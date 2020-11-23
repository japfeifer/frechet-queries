% MLP Neural Network Experiment (validation data is used in training)

rng(rngSeed); % reset random seed so experiments are reproducable

numFeatures = size(trainMat,2);
numClasses = size(subClassList,1);
XTrain = trainMat;
XTest = testMat;

trainLabels2 = cell2mat(trainSet(:,4));

YTrain = categorical(trainLabels2);

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
    'Plots','training-progress'); 


tic;
net = trainNetwork(XTrain, YTrain, layers, options);
toc;

tic;
YPred = classify(net,XTest);
toc;

n = grp2idx(YPred);

for i = 1:size(n,1)
    [row,col] = find(subClassList(:,1) == n(i,1));
    n(i,1) = subClassList(row,2);
end

acc = mean(n == testLabels);
disp(['Classification accuracy: ',num2str(acc)]);
disp(['Test Seq correct: ',num2str(sum(n == testLabels))]);
disp(['Test Seq incorrect: ',num2str(size(testLabels,1) - sum(n == testLabels))]);
