
% this code is specific to the KinTrans dataset

h = waitbar(0, 'Export');
tic;

% write header to file
fileName = labelFile; % name of file to create
fid = fopen(fileName,'w');
currText = '{';
fprintf(fid,'%s\n',currText);
    
for i=1:size(currSeqSet,1) % for each sequence do
    X = [targetFolder,': ',num2str(i),'/',num2str(size(currSeqSet,1))];
    X = strrep(X,'\','/');
    waitbar(i/size(currSeqSet,1), h, X);
    
    currSeqID = cell2mat(currSeqSet(i,1));
    currLabelID = cell2mat(currSeqSet(i,2));
    currLabelID = currLabelID - 1;
    
    currText = ['    "',typeFile,num2str(currSeqID),'": {'];
    fprintf(fid,'%s\n',currText);
    currText = '        "has_skeleton": true,';
    fprintf(fid,'%s\n',currText);
    currText = ['        "label": "',num2str(currLabelID),'",'];
    fprintf(fid,'%s\n',currText);
    currText = ['        "label_index": ',num2str(currLabelID)];
    fprintf(fid,'%s\n',currText);
    
    currText = '    },';
    if size(currSeqSet,1) == i
        currText = currText(1:end-1);  % remove last comma
    end
    fprintf(fid,'%s\n',currText);
  
end
currText = '}';
fprintf(fid,'%s',currText);

fclose(fid);

close(h);
timeElapsed = toc;
