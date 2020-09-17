% Import the UCF data
%
% 15 joints:
% 1 - HEAD
% 2 - NECK
% 3 - TORS
% 4 - LSHO
% 5 - LELB
% 6 - LHND
% 7 - RSHO
% 8 - RELB
% 9 - RHND
% 10 - LHIP
% 11 - LKNE
% 12 - LFOT
% 13 - RHIP
% 14 - RKNE
% 15 - RFOT
%
% CompMoveData has four columns: Class (string), Subject, Seq ID, Traj Coordinates, Class (int)
%
% Note the user is hard-coded to 1, since user 1 is the user of
% interest (so ignore user 2,3, etc in the processing).

tic;
CompMoveData = {[]};
numSequence = 1;

% get a list of all the subjects
dirList = dir('UCF\');

for i = 3:size(dirList,1)  % skip first two rows in fileList as they are '.' and '..'
    
    % get list of all files (sequences) for this subject
    dirName = ['UCF\' dirList(i).name '/*.ske'];
    fileList = dir(dirName);
    
    LMSubject = dirList(i).name; % current subject
    
    % process each sequence (first seq is left-hand, second seq is right-hand)
    for j = 1:size(fileList,1)
        % load in the file
        [ posMat, posConf, oriMat, oriConf ] = UCFLoadSkeleton( [fileList(j).folder '\' fileList(j).name] );
        
        % set some variables
        fileName = fileList(j).name;
        [UCFClass fileName] = strtok(fileName,'.');
        UCFSeqID = str2num(strtok(fileName,'.'));
        
        % rearrange the trajectories in the sequence
        seq = [];
        for a = 1:size(posMat,1) % for each frame
            frameCoord = [];
            for b = 1:size(posMat,3) % for each joint
                frameCoord = [frameCoord posMat(a,1,b,1) posMat(a,1,b,2) posMat(a,1,b,3)];  % user is hard-coded to 1
            end
            seq(end+1,:) = frameCoord;
        end
        
        reach = TrajReach(seq); % get traj reach 
        seq = TrajSimp(seq,reach * 0.02); % simplify sequence to speed up experiment processing
        
        % store results in CompMoveData
        CompMoveData(numSequence,1) = {UCFClass};
        CompMoveData(numSequence,2) = {LMSubject};
        CompMoveData(numSequence,3) = num2cell(UCFSeqID);
        CompMoveData(numSequence,4) = mat2cell(seq,size(seq,1),size(seq,2));
        
        numSequence = numSequence + 1;
    end

end
timeElapsed = toc;