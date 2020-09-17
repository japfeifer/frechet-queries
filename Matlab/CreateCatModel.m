% transform each single-column predictor into a set of multiple binary
% columns, where each new col represents a distinct word ID

szTrain = size(trainMat,1);
A = [trainMat; testMat];
C = [];
if classifierCurr == 1 % normalize dist to: 1 - x/(x+1)
    D = [trainMatDist; testMatDist];
    Dnorm = 1 - (D ./ (D+1));
end
for i=1:size(A,2)
    B = dummyvar({categorical(A(:,i))});
    if classifierCurr == 1 % use normalized dist
        B = B .* Dnorm(:,i);
    end
    C = [C B];
end
modelTrainMat = C(1:szTrain,:);
modelTestMat = C(szTrain+1:end,:);