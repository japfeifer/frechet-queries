% SVM Experiment 

disp(['-------------------------']);

rng(rngSeed); % reset random seed so experiments are reproducable

t = templateSVM('KernelFunction','linear');

trainLabels2 = cell2mat(trainSet(:,4));

tic;
Mdl = fitcecoc(trainMat,trainLabels2,'Coding','onevsone','Learners','svm','Learners',t); % train the classifier
toc;

tic;
classifierRes = predict(Mdl,testMat);
toc;

for i = 1:size(classifierRes,1)
    [row,col] = find(subClassList(:,1) == classifierRes(i,1));
    classifierRes(i,1) = subClassList(row,2);
end

disp(['Prediction Complete']);

% compute classifier accuracy
classifierRes(:,2) = testLabels;
classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
classAccuracy = mean(classifierRes(:,3)) * 100;  
disp(['Classification accuracy: ',num2str(classAccuracy)]);
disp(['Test Seq correct: ',num2str(sum(classifierRes(:,3)))]);
disp(['Test Seq incorrect: ',num2str(size(classifierRes,1) - sum(classifierRes(:,3)))]);
