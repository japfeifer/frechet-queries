function ImportFncMSASL(trainTest,fileName,dirName)

    global CompMoveData
    
    h = waitbar(0, 'Import MSASL Dataset');

    if size(CompMoveData,1) == 1
        numSequence = 1;
    else
        numSequence = size(CompMoveData,1) + 1;
    end

    % this file contains a list of sequences
    fileid = fopen(fileName);

    while 1 == 1 
        line = fgetl(fileid);
        if line == -1 % end of file
            break
        end

        [seqId,line] = strtok(line,char(9));
        if isnan(str2double(seqId)) == 0 % seq data exists for this sequence
            [label,line] = strtok(line,char(9)); % get the signed word
            X = ['Import MS-ASL Dataset:  ' label,'  ',num2str(numSequence)];
            waitbar(numSequence, h, X);
            thisDirName = [dirName '\' num2str(seqId) '\*.json'];
            fileList = dir(thisDirName);
            T = struct2table(fileList); % convert the struct array to a table
            sortedT = sortrows(T, 'name'); % sort the table by 'name'
            fileList = table2struct(sortedT); % change it back to struct array
            currTraj = [];
            for j = 1:size(fileList,1)  % for each seq frame
                fileName = [fileList(j).folder '\' fileList(j).name]; % seq frame file name
                fileid2 = fopen(fileName);
                line = fgetl(fileid2);
                fclose(fileid2);
                [garbage,line] = strtok(line,'['); % remove some unwanted text
                [garbage,line] = strtok(line,'[');
                [garbage,line] = strtok(line,'[');
                if size(line,2) > 0 % some seq frame files contain no coordinate info
                    c = sscanf(strrep(line(2:end),',',' '),'%f',[3 18]); % get x &y coordinates and score for 18 joints
                    currTraj(end+1,:) = [c(1,1)  c(2,1)  0 c(1,2)  c(2,2)  0 c(1,3)  c(2,3)  0 c(1,4)  c(2,4)  0 ...
                                         c(1,5)  c(2,5)  0 c(1,6)  c(2,6)  0 c(1,7)  c(2,7)  0 c(1,8)  c(2,8)  0 ...
                                         c(1,9)  c(2,9)  0 c(1,10) c(2,10) 0 c(1,11) c(2,11) 0 c(1,12) c(2,12) 0 ...
                                         c(1,13) c(2,13) 0 c(1,14) c(2,14) 0 c(1,15) c(2,15) 0 c(1,16) c(2,16) 0 ...
                                         c(1,17) c(2,17) 0 c(1,18) c(2,18) 0];
                end
            end
            % store results in CompMoveData
            CompMoveData(numSequence,1) = {label};
            CompMoveData(numSequence,2) = {['Subject 0']};
            CompMoveData(numSequence,3) = num2cell(trainTest);
            CompMoveData(numSequence,4) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            numSequence = numSequence + 1;
        end

    end

    close(h);
    
end
