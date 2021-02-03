disp(['------------']);

tic;
clear all;

% save(['MatlabData/StockData.mat'],'stockData');

stockData = []; % cols: open, high, low, close, adj close, volume
szWindow = 40; % number of days of historical info for each training/testing observation

load(['MatlabData/StockData.mat']);

trainStockData = [];
trainStockLabel = [];
testStockData = [];
testStockLabel = [];

% for stockData, determine if price went up (1) or down (0) from previous day
szStock = size(stockData,1);
for i = 2:szStock
    if stockData(i,5) >= stockData(i-1,5)
        stockData(i,7) = 1;
    else
        stockData(i,7) = 0;
    end
end

% create trainStockData and labels - use approx 2/3rds of data
numtrain = floor(szStock*2/3);
cnt = 1;
for i = 1+szWindow:numtrain
    trainStockData(cnt,1:szWindow) = [stockData(i-szWindow:i-1,5)];
    trainStockLabel(cnt,1) = stockData(i,7);
    cnt = cnt + 1;
end

% create testStockData and labels - use rest of the data
cnt = 1;
for i = 1+szWindow+numtrain:szStock
    testStockData(cnt,1:szWindow) = [stockData(i-szWindow:i-1,5)];
    testStockLabel(cnt,1) = stockData(i,7);
    cnt = cnt + 1;
end
t = toc;
disp(['Data preprocessing time: ',num2str(t)]);

disp(['Test data number days price goes down: ',num2str(sum(testStockLabel(:,1) == 0))]);
disp(['Test data number days price goes up: ',num2str(sum(testStockLabel(:,1) == 1))]);

tic;
% train the classifier
% t = templateSVM('KernelFunction','linear');
% options = statset('UseParallel',true);
% Mdl = fitcecoc(trainStockData,trainStockLabel,'Coding','onevsone','Learners','svm','Learners',t,'Options',options); 

t = templateDiscriminant('DiscrimType','diagLinear');
numPredictor = floor(size(trainStockData,2) / 2);
numLearner = 50;
Mdl = fitcensemble(...
            trainStockData, ...
            trainStockLabel, ...
            'Method', 'Subspace', ...
            'NumLearningCycles', numLearner, ...
            'Learners', 'discriminant', ...
            'Learners',t, ...
            'NPredToSample', numPredictor);
t = toc;
disp(['Training time: ',num2str(t)]);

% run the test data 
tic
classifierRes = predict(Mdl,testStockData); 
t = toc;
disp(['Testing time: ',num2str(t)]);

% output results
classifierRes(:,2) = testStockLabel;
classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
classAccuracy = mean(classifierRes(:,3)) * 100;  
disp(['Classification accuracy: ',num2str(classAccuracy)]);
disp(['Test Seq correct: ',num2str(sum(classifierRes(:,3)))]);
disp(['Test Seq incorrect: ',num2str(size(classifierRes,1) - sum(classifierRes(:,3)))]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Convolutional Neural Network Experiment (no validation data used in training)
% rngSeed = 1;
% rng(rngSeed); % reset random seed so experiments are reproducable
% 
% trainMat = trainStockData;
% trainLabels = trainStockLabel;
% testMat = testStockData;
% testLabels = testStockLabel;
% 
% numFeatures = size(trainMat,2);
% numClasses = 2;
% XTrain = reshape(trainMat', [1,1,size(trainMat,2),size(trainMat,1)]);
% XTest = reshape(testMat', [1,1,size(testMat,2),size(testMat,1)]);
% YTrain = categorical(trainLabels);
% YTest = categorical(testLabels);
% 
% layers = [ ... 
% imageInputLayer([1 1 numFeatures]) % this layer needs the first 3 dimensions of input "XNew"
% 
% convolution2dLayer([1 1],100)
% batchNormalizationLayer
% reluLayer 
% 
% % maxPooling2dLayer([1 1]) 
% % convolution2dLayer([1 1],300)
% % batchNormalizationLayer
% % reluLayer 
% 
% fullyConnectedLayer(numClasses)
% softmaxLayer
% classificationLayer]; 
% 
% options = trainingOptions('rmsprop', ...
%     'MaxEpochs',80, ...
%     'MiniBatchSize',8, ...
%     'SquaredGradientDecayFactor',0.9, ...
%     'GradientThresholdMethod','l2norm', ...
%     'ValidationPatience',5, ...
%     'InitialLearnRate',1e-4, ...
%     'Verbose',false, ...
%     'Plots','training-progress'); 
% 
% net = trainNetwork(XTrain, YTrain, layers, options);
% 
% YPred = classify(net,XTest);
% 
% acc = mean(YPred == YTest)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MLP Neural Network Experiment (validation data is used in training)

% rngSeed = 1;
% rng(rngSeed); % reset random seed so experiments are reproducable
% 
% trainMat = trainStockData;
% trainLabels = trainStockLabel;
% testMat = testStockData;
% testLabels = testStockLabel;
% 
% numFeatures = size(trainMat,2);
% numClasses = 2;
% XTrain = trainMat;
% XTest = testMat;
% YTrain = categorical(trainLabels);
% YTest = categorical(testLabels);
% 
% XValidation = XTest;
% YValidation = YTest;
% 
% layers = [featureInputLayer(numFeatures,'Normalization', 'zscore')
%     fullyConnectedLayer(100)
%     batchNormalizationLayer
%     reluLayer
%     fullyConnectedLayer(numClasses)
%     softmaxLayer
%     classificationLayer];
% 
% miniBatchSize = 8;
% 
% options = trainingOptions('sgdm', ...
%     'MaxEpochs',80, ...
%     'Shuffle','every-epoch', ...
%     'MiniBatchSize',16, ...
%     'Verbose',false, ...
%     'ValidationData',{XValidation,YValidation}, ...
%     'ValidationPatience',Inf, ...
%     'Plots','training-progress'); 
% 
% 
% tic;
% net = trainNetwork(XTrain, YTrain, layers, options);
% toc;
% 
% tic;
% YPred = classify(net,XTest);
% toc;
% 
% acc = mean(YPred == YTest);
% disp(['Classification accuracy: ',num2str(acc)]);
% disp(['Test Seq correct: ',num2str(sum(YPred == YTest))]);
% disp(['Test Seq incorrect: ',num2str(size(YTest,1) - sum(YPred == YTest))]);

