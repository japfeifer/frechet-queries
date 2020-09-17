% export trajectory dataset3

% NOTE: uses UNSIMPLIFIED trajectory data

% for i=1:2
for i=1:size(trajOrigData,1)
    tmpTraj = cell2mat(trajOrigData(i,1));
    
    tmpTrajSz = size(tmpTraj,1);
    c1 = [0:tmpTrajSz-1]';
    c2 = i*ones(tmpTrajSz,1) ;
    tmpTraj = [tmpTraj c1 c2];
    
    fileName = strcat('trajectory-',num2str(i),'.dat');

    % write data to end of file
    dlmwrite(fileName,tmpTraj,'precision',15,'delimiter',',');

end
