% SVM Experiment 

disp(['-------------------------']);

rng(rngSeed); % reset random seed so experiments are reproducable


options = statset('UseParallel',true);   
t = templateSVM('KernelFunction','linear');

tic;
Mdl = fitcecoc(trainMat,trainLabels,'Coding','onevsone','Learners','svm','Learners',t,'Options',options); % train the classifier
toc;

tic;
classifierRes = predict(Mdl,testMat);
toc;

disp(['Prediction Complete']);

% compute classifier accuracy
classifierRes(:,2) = testLabels;
classifierRes(:,3) = classifierRes(:,1) == classifierRes(:,2);
classAccuracy = mean(classifierRes(:,3)) * 100;  
disp(['Classification accuracy: ',num2str(classAccuracy)]);
disp(['Test Seq correct: ',num2str(sum(classifierRes(:,3)))]);
disp(['Test Seq incorrect: ',num2str(size(classifierRes,1) - sum(classifierRes(:,3)))]);
