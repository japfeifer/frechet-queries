% Import the UTKinect-Action 3D dataset

% Get a list of all action sequences
filename = 'UTKA/actionseq.txt';
fid = fopen(filename, 'r');
seqList = [];
actions = ["walk","sitDown","standUp","pickUp",...
           "carry","throw","push",...
           "pull","waveHands","clapHands"];
line = fgetl(fid);
while ischar(line)
    s = str2num(line(2:3)); % subject
    r = str2num(line(6:7)); % repetition number
    for i=1:10 % for each action
        % get start and end frame ids
        line = fgetl(fid);
        [garbage,line] = strtok(line,':');
        [garbage,line] = strtok(line,' ');
        se = sscanf(line,'%f'); % start and end frame for this sequence
        % store results in seqList
        seqList(end+1,:) = [i s r se(1) se(2)];
    end
    line = fgetl(fid);
end
fclose(fid);

% now load in trajectory coordinates for each sequence
CompMoveData = {[]};
numSequence = 1;
for i=1:size(seqList,1)
    filename = sprintf('UTKA/joints_s%02d_e%02d.txt', seqList(i,2), seqList(i,3));
    fid = fopen(filename, 'r');
    line = fgetl(fid);
    currTraj = [];
    
    while ischar(line) % for each line in the file
        frame = sscanf(line,'%f',[1 61]); % extract frame
        if frame(1) >= seqList(i,4) && frame(1) <= seqList(i,5) % if this frame is within seq start/end frame
            currTraj(end+1,:) = frame(2:end);
        end
        line = fgetl(fid);
    end
    % store results in CompMoveData
    if isempty(currTraj) == false
        
        reach = TrajReach(currTraj); % get traj reach 
        currTraj = TrajSimp(currTraj,reach * 0.02); % simplify sequence to speed up experiment processing

        CompMoveData(numSequence,1) = {char(actions(seqList(i,1)))};
        CompMoveData(numSequence,2) = {['Subject ' num2str(seqList(i,2))]};
        CompMoveData(numSequence,3) = num2cell(seqList(i,3));
        CompMoveData(numSequence,4) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
        numSequence = numSequence + 1;
    end
    fclose(fid);
end



