% calculate bounds test result avg, std dev, %

szQueryTraj = size(queryTraj,1);
boundsTestRes = [];

disp(['-----------------------------']);

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,29))]; 
end
currAvg = mean(currList);
disp(['exact cont Fréchet distance Avg:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,30))]; 
end
currAvg = mean(currList);
disp(['LB - SE:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,31))]; 
end
currAvg = mean(currList);
disp(['LB - BB no rotation:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,32))]; 
end
currAvg = mean(currList);
disp(['LB - BB rotate 22.5:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,33))]; 
end
currAvg = mean(currList);
disp(['LB - BB rotate 45:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,34))]; 
end
currAvg = mean(currList);
disp(['LB - SSE:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,35))]; 
end
currAvg = mean(currList);
disp(['LB - NF beats best LB?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,36))]; 
end
currAvg = mean(currList);
disp(['LB - SE best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,37))]; 
end
currAvg = mean(currList);
disp(['LB - BB no rotation best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,38))]; 
end
currAvg = mean(currList);
disp(['LB - BB rotate 22.5 best:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,39))]; 
end
currAvg = mean(currList);
disp(['LB - BB rotate 45 best:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,40))]; 
end
currAvg = mean(currList);
disp(['LB - SSE Bound best:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,41))]; 
end
currAvg = mean(currList);
disp(['UB - BB no rotation:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,42))]; 
end
currAvg = mean(currList);
disp(['UB - BB rotate 22.5:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,43))]; 
end
currAvg = mean(currList);
disp(['UB - BB rotate 45:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,44))]; 
end
currAvg = mean(currList);
disp(['UB - ADF:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,45))]; 
end
currAvg = mean(currList);
disp(['UB - ADFR:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,46))]; 
end
currAvg = mean(currList);
disp(['UB - ADFD:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,47))]; 
end
currAvg = mean(currList);
disp(['UB - BB no rotation best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,48))]; 
end
currAvg = mean(currList);
disp(['UB - BB rotate 22.5 best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,49))]; 
end
currAvg = mean(currList);
disp(['UB - BB rotate 45 best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,50))]; 
end
currAvg = mean(currList);
disp(['UB - ADF best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,51))]; 
end
currAvg = mean(currList);
disp(['UB - ADFR best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];

currList = [];
for i = 1:szQueryTraj
    currList = [currList; cell2mat(queryTraj(i,52))]; 
end
currAvg = mean(currList);
disp(['UB - ADFD best?:',num2str(currAvg)]);
boundsTestRes = [boundsTestRes currAvg];





