% Import the Berkeley MHAD dataset

h = waitbar(0, 'Import MHAD Dataset');

tic;
CompMoveData = {[]};
numSequence = 1;
actions = ["Jumping in place","Jumping Jacks","Bending","Punching",...
           "Waving - two hands","Waving - right hand","Clapping hands",...
           "Throwing ball","Sit down stand up","Sit down","Stand up"];
dirName = ['MHAD/*.bvh'];
fileList = dir(dirName);

for i = 1:size(fileList,1)
    X = ['Import MHAD Dataset: ',num2str(numSequence),'/',num2str(size(fileList,1))];
    waitbar(numSequence/size(fileList,1), h, X);
    
    % load in the file
    [skel,channel,framerate] = bvhReadFile([fileList(i).folder '/' fileList(i).name]);
    skel_jnt = 10*chan2xyz(skel,channel);
        
    % set subject s, action a, repetition r
    fileName = fileList(i).name;
    [garbage fileName] = strtok(fileName,'_');
    [s fileName] = strtok(fileName,'_');
    s = str2num(s(:,2:end));
    [a fileName] = strtok(fileName,'_');
    a = str2num(a(:,2:end));
    [r fileName] = strtok(fileName,'.');
    r = str2num(r(:,3:end));

    reach = TrajReach(skel_jnt); % get traj reach 
    skel_jnt = TrajSimp(skel_jnt,reach * 0.02); % simplify sequence to speed up experiment processing
        
    % store results in CompMoveData
    CompMoveData(numSequence,1) = {char(actions(a))};
    CompMoveData(numSequence,2) = {['Subject ' num2str(s)]};
    CompMoveData(numSequence,3) = num2cell(r);
    CompMoveData(numSequence,4) = mat2cell(skel_jnt,size(skel_jnt,1),size(skel_jnt,2));
    numSequence = numSequence + 1;
end
close(h);
timeElapsed = toc;
