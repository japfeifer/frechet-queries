% Import the NTU-RBG+D dataset

% Code from read_skeleton_file on https://github.com/shahroudy/NTURGB-D
% was extracted and modified below for our purposes.

NTURGBDexclude; % load the file exclusion list (302 seq contain bad data)

h = waitbar(0, 'Import NTU-RBG+D Dataset');

tic;
CompMoveData = {[]};
numSequence = 1;
actions = ["drink water","eat meal-snack","brushing teeth","brushing hair","drop",...
           "pickup","throw","sitting down","standing up (from sitting position)","clapping",...
           "reading","writing","tear up paper","wear jacket","take off jacket",...
           "wear a shoe","take off a shoe","wear on glasses","take off glasses","put on a hat-cap",...
           "take off a hat-cap","cheer up","hand waving","kicking something","reach into pocket",...
           "hopping (one foot jumping)","jump up","make a phone call-answer phone","playing with phone-tablet","typing on a keyboard",...
           "pointing to something with finger","taking a selfie","check time (from watch)","rub two hands together","nod head/bow",...
           "shake head","wipe face","salute","put the palms together","cross hands in front (say stop)",...
           "sneeze-cough","staggering","falling","touch head (headache)","touch chest (stomachache-heart pain)",...
           "touch back (backache)","touch neck (neckache)","nausea or vomiting condition","use a fan (with hand or paper)-feeling warm","punching-slapping other person",...
           "kicking other person","pushing other person","pat on back of other person","point finger at the other person","hugging other person",...
           "giving something to other person","touch other person's pocket","handshaking","walking towards each other","walking apart from each other"];

dirName = ['C:\Users\jpfe0390\st-gcn\nturawdata\*.skeleton'];
fileList = dir(dirName);

for i = 1:size(fileList,1)
    X = ['Import NTU-RBG+D Dataset: ',num2str(numSequence),'/',num2str(size(fileList,1))];
    waitbar(numSequence/size(fileList,1), h, X);

    fileName = fileList(i).name;
    fileName = strtok(fileName,'.'); % get rid of the '.skeleton' extension
    
    % do not process seq's containing bad data
    if ismember(fileName,excludeNTURGBD,'rows') == false  % this seq contains good data
        % set subject s, action a, repetition r
        % set repetition r to the camera id so that we can do Xcamera view experiment
        s = str2num(fileName(10:12));
        a = str2num(fileName(18:20));
        r = str2num(fileName(6:8));

        % now get skeleton(s) from the data file
        currTraj = [];
        fileName = [fileList(i).folder '/' fileList(i).name];
        fileid = fopen(fileName);
        framecount = fscanf(fileid,'%d',1); % no of the recorded frames
        for f=1:framecount
            bodycount = fscanf(fileid,'%d',1); % no of observed skeletons in current frame
            for b=1:bodycount
                garbage = fscanf(fileid,'%ld',1); % tracking id of the skeleton
                garbage = fscanf(fileid,'%d',6); % read 6 integers
                garbage = fscanf(fileid,'%f',2);
                garbage = fscanf(fileid,'%d',1);
                jointCount = fscanf(fileid,'%d',1); % no of joints (25)
                for j=1:jointCount
                    jointinfo = fscanf(fileid,'%f',11);
                    garbage = fscanf(fileid,'%d',1);
                    idx = ((75*b) - 75) + ((j*3) - 2);
                    currTraj(f,idx:idx+2) = [jointinfo(1) jointinfo(2) jointinfo(3)];
                end
            end
        end
        fclose(fileid);

%         reach = TrajReach(currTraj); % get traj reach 
%         currTraj = TrajSimp(currTraj,reach * 0.02); % simplify sequence to speed up experiment processing

        % store results in CompMoveData
        CompMoveData(numSequence,1) = {char(actions(a))};
        CompMoveData(numSequence,2) = {['Subject ' num2str(s)]};
        CompMoveData(numSequence,3) = num2cell(r);
        CompMoveData(numSequence,4) = mat2cell(currTraj,size(currTraj,1),size(currTraj,2));
        numSequence = numSequence + 1;
    
    end
end
close(h);
timeElapsed = toc;

