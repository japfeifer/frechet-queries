% calculate bounds test result avg, std dev, %

szQueryTraj = size(queryTraj,1);
boundsTestRes = [];

disp(['-----------------------------']);

% exact continuous Fréchet distance
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,29))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['exact cont Fréchet distance Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% SE LB 
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,30))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['SE LB Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% BB no rot LB 
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,31))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['BB no rot LB Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% BB include rot LB 
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,32))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['BB include rot LB Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% SSE LB 
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,33))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['SSE LB Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% SE LB best?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,34))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['SE LB best Pct:',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% BB no rot LB best?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,35))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['BB no rot LB best Pct:',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% BB include rot LB best?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,36))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['BB include rot LB best Pct:',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% SSE LB best?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,37))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['SSE LB best Pct:',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% ADF no pad 
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,38))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['ADF no pad Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% ADF include pad 
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,39))]; 
end
currAvg = mean(currList);
currStd = std(currList);
disp(['ADF include pad Avg:',num2str(currAvg),'      Std:',num2str(currStd)]);
boundsTestRes = [boundsTestRes currAvg currStd];

% ADF include pad better than ADF no pad?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,40))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['ADF include pad better than ADF no pad Pct: ',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% NF no pad better than best LB?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,41))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['NF no pad better than best LB Pct: ',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% NF pad better than best LB?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,42))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['NF pad better than best LB Pct: ',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

% NF pad better than NF no pad?
currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,43))]; 
end
currPct = sum(currList) / szQueryTraj * 100;
disp(['NF pad better than NF no pad Pct: ',num2str(currPct)]);
boundsTestRes = [boundsTestRes currPct];

