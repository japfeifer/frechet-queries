% Import the Leap Motion data
%
% left hand joint coordinates:
% thumbProximal_L_X, thumbProximal_L_Y, thumbProximal_L_Z, 
% thumbDistal_L_X, thumbDistal_L_Y, thumbDistal_L_Z, 
% thumbEF_L_X, thumbEF_L_Y, thumbEF_L_Z, 
% indexProximal_L_X, indexProximal_L_Y, indexProximal_L_Z, 
% indexMedial_L_X, indexMedial_L_Y, indexMedial_L_Z, 
% indexDistal_L_X, indexDistal_L_Y, indexDistal_L_Z, 
% indexEF_L_X, indexEF_L_Y, indexEF_L_Z, 
% middleProximal_L_X, middleProximal_L_Y, middleProximal_L_Z, 
% middleMedial_L_X, middleMedial_L_Y, middleMedial_L_Z, 
% middleDistal_L_X, middleDistal_L_Y, middleDistal_L_Z, 
% middleEF_L_X, middleEF_L_Y, middleEF_L_Z, 
% ringProximal_L_X, ringProximal_L_Y, ringProximal_L_Z, 
% ringMedial_L_X, ringMedial_L_Y, ringMedial_L_Z, 
% ringDistal_L_X, ringDistal_L_Y, ringDistal_L_Z, 
% ringEF_L_X, ringEF_L_Y, ringEF_L_Z, 
% pinkyProximal_L_X, pinkyProximal_L_Y, pinkyProximal_L_Z, 
% pinkyMedial_L_X, pinkyMedial_L_Y, pinkyMedial_L_Z, 
% pinkyDistal_L_X, pinkyDistal_L_Y, pinkyDistal_L_Z, 
% pinkyEF_L_X, pinkyEF_L_Y, pinkyEF_L_Z, 
% palm_L_X, palm_L_Y, palm_L_Z, 
% wrist_L_X, wrist_L_Y, wrist_L_Z, 
% handBaseRadius_L_X, handBaseRadius_L_Y, handBaseRadius_L_Z, 
% elbow_L_X, elbow_L_Y, elbow_L_Z, 
% armFrontRadius_L_X, armFrontRadius_L_Y, armFrontRadius_L_Z, 
% armFrontUlna_L_X, armFrontUlna_L_Y, armFrontUlna_L_Z, 
% armBackLateral_L_X, armBackLateral_L_Y, armBackLateral_L_Z, 
% armBackMedial_L_X, armBackMedial_L_Y, armBackMedial_L_Z
%
% right hand joints are same as above but with *_R_*

%
% CompMoveData has four columns: Class (string), Subject, Seq ID, Traj Coordinates, Class (int)
%

h = waitbar(0, 'Import Leap Motion Dataset');

tic;
CompMoveData = {[]};
numSequence = 1;

% get a list of all the subjects
dirList = dir('LM/');

% for each subject do
for i = 3:size(dirList,1)  % skip first two rows in fileList as they are '.' and '..'
    X = ['Import Leap Motion Dataset: ',num2str(i-2),'/',num2str((size(dirList,1) - 2))];
    waitbar((i-2)/(size(dirList,1) - 2), h, X);
    
    % get list of all files (sequences) for this subject
    dirName = ['LM/' dirList(i).name '/*.csv'];
    fileList = dir(dirName);
    
    LMSubject = dirList(i).name; % current subject
    
    % process each seq file (one file is left-hand, one file is right-hand)
    for j = 1:size(fileList,1)
        filename = fileList(j).name;
        % get the Class name and side (Left or Right)
        [LMClass,line] = strtok(filename,'_');
        [line,garbage] = strtok(line,'_');
        [side,garbage] = strtok(line,'.');
        if strcmp(side,'Left') == true
            seqL = [];
            seqR = [];
        end
        seqCnt = 1;

         % do not process the 'Neutral' class as this is just a seq test with minimal hand movement
         % do not process the 'Bad' class as there is one seq with this class name
        if strcmp(LMClass,'Neutral') == false && strcmp(LMClass,'Bad') == false
            
            % get the first non-empty row in the datafile
            fid = fopen([fileList(j).folder '/' filename], 'r');
            line = fgetl(fid); % first line is a header
            line = fgetl(fid); % first row of coordinate data
            aFull = [];
            while ischar(line)
                [garbage,line] = strtok(line,',');
                [garbage,line] = strtok(line,',');
                line = line(2:end); % get rid of comma
                a = sscanf(line, '%f,', [1, inf]); % put values into an array
                if isempty(a) == false
                    aFull = a; % first non-empty row
                    break
                end
                line = fgetl(fid); % get next row
            end
            fclose(fid);
            
            % reopen the file
            fid = fopen([fileList(j).folder '/' filename], 'r');

            line = fgetl(fid); % first line is a header
            line = fgetl(fid); % first row of coordinate data
            while ischar(line)
                [garbage,line] = strtok(line,',');
                [garbage,line] = strtok(line,',');
                line = line(2:end); % get rid of comma
                a = sscanf(line, '%f,', [1, inf]); % put values into an array
                if isempty(a) == false % this frame has coordinate values
                    if strcmp(side,'Left') == true % store frame in Left or Right seq
                        seqL(seqCnt,:) = a;
                    else
                        seqR(seqCnt,:) = a;
                    end
                    aFull = a;
                else % this frame is empty, so insert the aFull coordinate values
                    if strcmp(side,'Left') == true % store frame in Left or Right seq
                        seqL(seqCnt,:) = aFull;
                    else
                        seqR(seqCnt,:) = aFull;
                    end
                end
                seqCnt = seqCnt + 1;
                line = fgetl(fid); % get next row
            end
            fclose(fid);  

            % store results in CompMoveData
            if strcmp(side,'Right') == true % left has already been processed, and now right is done so save seq
                if size(seqL,1) ~= size(seqR,1) % some sequences have empty rows at the end
                    disp(['Diff number of frames for: ' fileList(j).folder '/' filename]);
                    disp(['Left-hand frames: ',num2str(size(seqL,1))]);
                    disp(['Right-hand frames: ',num2str(size(seqR,1))]);
                    numF = min(size(seqL,1), size(seqR,1));
                    seq = [seqL(numF,:) seqR(numF,:)]; % put Left and Right seq together
                else
                    seq = [seqL seqR]; % put Left and Right seq together
                end
                % only save seq that have at least 10 frames (e.g. some data files can have bad data and only one frame)
                if size(seq,1) >= 10
                    CompMoveData(numSequence,1) = {LMClass};
                    CompMoveData(numSequence,2) = {['Subject ' LMSubject]};
                    CompMoveData(numSequence,3) = num2cell(1); % one repetition sequence per subject and class
                    CompMoveData(numSequence,4) = mat2cell(seq,size(seq,1),size(seq,2));
                    numSequence = numSequence + 1;
                end
            end
        end
    end
end

% compute numSubSeq
for i = 1:size(CompMoveData,1) % for each seq
    seq = cell2mat(CompMoveData(i,4));
    seq = LMExtractFeatures(seq,2);
    lowVaryPct = 0.3;
    highVaryPct = 0.4;
    lastFramePct = 0.05;
    x = GetSeqDist(seq); % get seq distances to first frame
    [phase,numSubSeq,freqSize] = GetSeqDistFreqSize(x,seq,0,lowVaryPct,highVaryPct,lastFramePct); % get number of frames per sub-seq
    CompMoveData(i,5) = num2cell(numSubSeq);
end

CompMoveData = sortrows(CompMoveData,[5,1,2,3]); % sort on numSubSeq, class, subject, repetition num

close(h);
timeElapsed = toc;