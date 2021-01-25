% export trajectory dataset2

trajExport = [];

textHeader = 'x y k tid'; %cHeader in text with commas

for i=1:size(trajData,1)
% for i=1:2
    tmpTraj = cell2mat(trajData(i,1));
    
    tmpTrajSz = size(tmpTraj,1);
    c1 = [0:tmpTrajSz-1]';
    c2 = i*ones(tmpTrajSz,1) ;
    tmpTraj = [tmpTraj c1 c2];
    
    fileName = strcat('trajectory-',num2str(i),'.dat');
    
%     %write header to file
%     fid = fopen(fileName,'w'); 
%     fprintf(fid,'%s\n',textHeader);
%     fclose(fid);

    % write data to end of file
%     dlmwrite(fileName,tmpTraj,'-append','precision',15,'delimiter',' ');
    dlmwrite(fileName,tmpTraj,'precision',15,'delimiter',' ');

end
