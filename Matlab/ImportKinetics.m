% Import the Kinetics *.json files dataset
% This is a 2-d dataset (x,y axis), so just set z axis to 0

h = waitbar(0, 'Import Kinetics Dataset');

tic;
CompMoveData = {[]};
numSequence = 1;

% dirName = ['C:\Users\jpfe0390\Downloads\upload-skeleton-samples\*.json'];
dirName = ['Export\Train\*.json'];

fileList = dir(dirName);

for i = 1:size(fileList,1)
    X = ['Import Kinetics Dataset: ',num2str(numSequence),'/',num2str(size(fileList,1))];
    waitbar(numSequence/size(fileList,1), h, X);

    % now get skeleton(s) from the data file
    currTraj = [];
    fileName = [fileList(i).folder '\' fileList(i).name];
    fileid = fopen(fileName);
    line = fgetl(fileid);
    fclose(fileid);
    
    % process the "pose" and "score" values for each frame
    line = strrep(line, ',', ' ');
    [garbage,line] = strtok(line,':');
    [garbage,line] = strtok(line,'{');
    while 1 == 1 
        if strcmp(line(3:6),'pose') == true
            [garbage,line] = strtok(line,'[');
            line = line(2:end);
            ctrash = sscanf(line,'%f',[2 18]);
            [garbage,line] = strtok(line,']');
            [garbage,line] = strtok(line,'[');
            line = line(2:end);
            strash = sscanf(line,'%f',[1 9]);
            [garbage,line] = strtok(line,'}');
            line = line(4:end);
        else
            [garbage,line] = strtok(line,'[');
            if line(2) ~= ']'
                [garbage,line] = strtok(line,'{');
                [garbage,line] = strtok(line,'[');
                line = line(2:end);
                c = sscanf(line,'%f',[2 18]);
                c = c';
                [garbage,line] = strtok(line,']');
                [garbage,line] = strtok(line,'[');
                line = line(2:end);
                s = sscanf(line,'%f',[1 9]);
                s = s';
                currTraj(end+1,:) = [c(1,1) c(1,2) 0 c(2,1) c(2,2) 0 c(3,1) c(3,2) 0 c(4,1) c(4,2) 0 c(5,1) c(5,2) 0 c(6,1) c(6,2) 0 c(7,1) c(7,2) 0 c(8,1) c(8,2) 0 c(9,1) c(9,2) 0 c(10,1) c(10,2) 0 c(11,1) c(11,2) 0 c(12,1) c(12,2) 0 c(13,1) c(13,2) 0 c(14,1) c(14,2) 0 c(15,1) c(15,2) 0 c(16,1) c(16,2) 0 c(17,1) c(17,2) 0 c(18,1) c(18,2) 0];
                [garbage,line] = strtok(line,'}');
                line = line(4:end);
            else
                [garbage,line] = strtok(line,'}'); 
                line = line(2:end);
            end 
        end
        if line(1) == ']'
            break
        end
    end
    
    % get the label
    [garbage,line] = strtok(line,':');
    [garbage,line] = strtok(line,'"');
    line = line(2:end);
    [label,line] = strtok(line,'"');
    
    % store results in CompMoveData
    CompMoveData(numSequence,1) = {label};
    CompMoveData(numSequence,2) = {['Subject 0']};
    CompMoveData(numSequence,3) = num2cell(0);
    CompMoveData(numSequence,4) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
    numSequence = numSequence + 1;

end
close(h);
timeElapsed = toc;

