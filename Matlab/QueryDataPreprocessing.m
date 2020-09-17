tic;
    
h = waitbar(0, 'Preprocess Queries');
sP = size(queryTraj,1);

for i = 1:size(queryTraj,1)
    PreprocessQuery(i);
    
    if mod(i,100) == 0
        X = ['Preprocess Queries ',num2str(i),'/',num2str(sP)];
        waitbar(i/sP, h, X);
    end
end

close(h);
timeElapsed = toc;