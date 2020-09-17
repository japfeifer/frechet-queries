% Import the MSR Daily Activity 3D dataset

% "The format of the skeleton file is as follows. The first integer is the 
% number of frames. The second integer is the number of joints which is 
% always 20. For each frame, the first integer is the number of rows. 
% This integer is 40 when there is exactly one skeleton being detected in 
% this frame. It is zero when no skeleton is detected. It is 80 when two 
% skeletons are detected (in that case which is rare, we simply use the 
% first skeleton in our experiments). For most of the frames, the number 
% of rows is 40. Each joint corresponds to two rows. The first row is its 
% real world coordinates (x,y,z) and the second row is its screen 
% coordinates plus depth (u, v, depth) where u and v are normalized to be 
% within [0,1]. For each row, the integer at the end is supposed to be the 
% confidence value, but it is not useful."

h = waitbar(0, 'Import MSRDA Dataset');

tic;
CompMoveData = {[]};
numSequence = 1;
actions = ["drink","eat","read book","call cellphone",...
           "write on paper","use laptop","use vacuum cleaner",...
           "cheer up","sit still","toss paper","play game",...
           "lay down on sofa","walk","play guitar","stand up","sit"];
dirName = ['MSRDA/*.txt'];
fileList = dir(dirName);

for i = 1:size(fileList,1)
    X = ['Import MSRDA Dataset: ',num2str(numSequence),'/',num2str(size(fileList,1))];
    waitbar(numSequence/size(fileList,1), h, X);
    
    % load in the file
    filename = [fileList(i).folder '\' fileList(i).name];
    
    % get action, subject, repetition number
    asr = sscanf(fileList(i).name,'a%f_s%f_e%f_skeleton.txt',[1 3]);
    a = asr(1); s = asr(2); r = asr(3);
    
    % load in trajectory coordinates for this sequence
    currTraj = [];
    fid = fopen(filename);
    line = fgetl(fid);
    values = sscanf(line,'%f',[1 2]); % the first is number of frames, the second is number of joints
    numFrame = values(1);
    numJoint = values(2);
    line = fgetl(fid); % get number of rows for first frame
    currFrame = 1;
    while ischar(line)
        framerows = str2num(line); % the number of rows of data for this frame
        for j = 1:framerows
            line = fgetl(fid);
            % only save coordinates for real-world, and for first skeleton
            if j <= 40 && mod(j,2) == 1
                values = sscanf(line,'%f',[1 4]);
                colStart = (((j+1)/2)*3)-2;
                colEnd = ((j+1)/2)*3;
                currTraj(currFrame,colStart:colEnd) = values(1,1:3);
            end
        end
        currFrame = currFrame + 1;
        line = fgetl(fid); % get number of rows for next frame
    end
    fclose(fid);
    
    reach = TrajReach(currTraj); % get traj reach 
    currTraj = TrajSimp(currTraj,reach * 0.02); % simplify sequence to speed up experiment processing

    % store results in CompMoveData
    CompMoveData(numSequence,1) = {char(actions(a))};
    CompMoveData(numSequence,2) = {['Subject ' num2str(s)]};
    CompMoveData(numSequence,3) = num2cell(r);
    CompMoveData(numSequence,4) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
    numSequence = numSequence + 1;
end
close(h);
timeElapsed = toc;
