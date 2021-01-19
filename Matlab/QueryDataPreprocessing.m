tic;
    
h = waitbar(0, 'Preprocess Queries');
sP = size(queryStrData,2);

for i = 1:sP
    PreprocessQuery(i);
    
    if mod(i,100) == 0
        X = ['Preprocess Queries ',num2str(i),'/',num2str(sP)];
        waitbar(i/sP, h, X);
    end
end

close(h);
timeElapsed = toc;
disp(['Time to preprocess query traj: ',num2str(timeElapsed)]);