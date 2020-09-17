% Import the MSRA dataset

% typeMSRA - 1 is skeleton, 2 is Real3D skeleton
typeMSRA = 2;

h = waitbar(0, 'Import MSRA Dataset');

tic;
CompMoveData = {[]};
numSequence = 1;
actions = ["high arm wave","horizontal arm wave","hammer","hand catch"...
           "forward punch","high throw","draw x","draw tick",...
           "draw circle","hand clap","two hand wave","side boxing",...
           "bend","forward kick","side kick","jogging",...
           "tennis swing","tennis serve","golf swing","pick up and throw" ];
       
if typeMSRA == 1 
    dirName = ['MSRA\MSRAction3DSkeleton(20joints)\*.txt'];
else
    dirName = ['MSRA\MSRAction3DSkeletonReal3D\*.txt'];
end
fileList = dir(dirName);

for i = 1:size(fileList,1)
    X = ['Import MSRA Dataset: ',num2str(numSequence),'/',num2str(size(fileList,1))];
    waitbar(numSequence/size(fileList,1), h, X);
    
    % load in the file
    filename = [fileList(i).folder '\' fileList(i).name];
    
    % get action, subject, repetition number
    if typeMSRA == 1 
        asr = sscanf(fileList(i).name,'a%f_s%f_e%f_skeleton.txt',[1 3]);
    else
        asr = sscanf(fileList(i).name,'a%f_s%f_e%f_skeleton3D.txt',[1 3]);
    end
    a = asr(1); s = asr(2); r = asr(3);
      
    % load in trajectory coordinates for this sequence
    currTraj = [];
    fid = fopen(filename);
    line = fgetl(fid); % get coordinates: first joint of first frame
    currFrame = 1;
    while ischar(line)
        values = sscanf(line,'%f',[1 4]); % coordinates of first joint
        currTraj(currFrame,1:3) = values(1,1:3);
        for j = 2:20 % get joints 2 to 20
            line = fgetl(fid);
            values = sscanf(line,'%f',[1 4]);
            colStart = (j*3) - 2;
            colEnd = (j*3);
            currTraj(currFrame,colStart:colEnd) = values(1,1:3);
        end
        currFrame = currFrame + 1;
        line = fgetl(fid); % get coordinates: first joint of next frame
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

% now delete rows in CompMoveData that have bad data - all points at coordinate (0,0,0)
idxs = [];
for i=1:size(CompMoveData,1)
    traj = cell2mat(CompMoveData(i,4));
    cnt = 0;
    for j=1:size(traj,2)
        for k=1:size(traj,1)
            if traj(k,j) == 0
                cnt = cnt + 1;
            end
        end
    end
    if cnt > 30
        idxs = [idxs i];
    end
end
CompMoveData(idxs,:)=[];

close(h);
timeElapsed = toc;
