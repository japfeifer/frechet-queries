function ImportFncMSASL(trainTest,fileName,dirName,handThresh)

    global CompMoveData
    
    h = waitbar(0, 'Import MSASL Dataset');

    if size(CompMoveData,1) == 1
        numSequence = 1;
    else
        numSequence = size(CompMoveData,1) + 1;
    end

    % this file contains a list of sequences
    fileid = fopen(fileName);
    
    emptyHand = [0 0 0  0 0 0  0 0 0  0 0 0 ...
                 0 0 0  0 0 0  0 0 0  0 0 0 ...
                 0 0 0  0 0 0  0 0 0  0 0 0 ...
                 0 0 0  0 0 0  0 0 0  0 0 0 ...
                 0 0 0  0 0 0  0 0 0  0 0 0 ...
                 0 0 0];

    while 1 == 1 
        line = fgetl(fileid);
        if line == -1 % end of file
            break
        end
        
%         if numSequence == 6
%             break
%         end

        [seqId,line] = strtok(line,char(9));
        if isnan(str2double(seqId)) == 0 % seq data exists for this sequence
            [labelTxt,line] = strtok(line,char(9)); % get the signed word text
            [labelId,line] = strtok(line,char(9)); % get the signed word id number
            [subjectNum,line] = strtok(line,char(9)); % get the subject id number
            X = ['Import MS-ASL Dataset:  ' labelTxt,'  ',num2str(numSequence)];
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

                value = jsondecode(line);
                if isfield(value.people,'pose_keypoints_2d') == true
                    v = value.people.pose_keypoints_2d; % 18 joints, each has x,y, and score
                    if size(v,2) > 0
                        currTraj(end+1,1:54) = [v(1)   v(2)   0 v(4)   v(5)  0 v(7)   v(8)  0 v(10)  v(11) 0 ...
                                                v(13)  v(14)  0 v(16)  v(17) 0 v(19)  v(20) 0 v(22)  v(23) 0 ...
                                                v(25)  v(26)  0 v(28)  v(29) 0 v(31)  v(32) 0 v(34)  v(35) 0 ...
                                                v(37)  v(38)  0 v(40)  v(41) 0 v(43)  v(44) 0 v(46)  v(47) 0 ...
                                                v(49)  v(50)  0 v(52)  v(53) 0];
                                         
                        if isfield(value.people,'hand_left_keypoints_2d') == true
                            v = value.people.hand_left_keypoints_2d; % 21 joints, each has x,y, and score
                            if size(v,2) > 0
                                vNew = MSASLGetHand(v,handThresh);
                                currTraj(end,55:117) = vNew;
                            else
                                currTraj(end,55:117) = emptyHand;
                            end
                        else
                            currTraj(end,55:117) = emptyHand;
                        end
                        
                        if isfield(value.people,'hand_right_keypoints_2d') == true
                            v = value.people.hand_right_keypoints_2d; % 21 joints, each has x,y, and score
                            if size(v,2) > 0
                                vNew = MSASLGetHand(v,handThresh);
                                currTraj(end,118:180) = vNew;
                            else
                                currTraj(end,118:180) = emptyHand;
                            end
                        else
                            currTraj(end,118:180) = emptyHand;
                        end
                    end
                end
            end
            % store results in CompMoveData
            CompMoveData(numSequence,1) = {labelId};
            CompMoveData(numSequence,2) = {['Subject ',subjectNum]};
            CompMoveData(numSequence,3) = num2cell(trainTest);
            CompMoveData(numSequence,4) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
            CompMoveData(numSequence,7) = {labelTxt};
            numSequence = numSequence + 1;
        end

    end

    close(h);
    
end
