% Convert to 3D 'ntu-rgb+d' layout with 25 joints.

% this code is specific to the UCF dataset

UHEAD = [1,2,3];
UNECK = [4,5,6];
UTORS = [7,8,9];
ULSHO = [10,11,12];
ULELB = [13,14,15];
ULHND = [16,17,18];
URSHO = [19,20,21];
URELB = [22,23,24];
URHND = [25,26,27];
ULHIP = [28,29,30];
ULKNE = [31,32,33];
ULFOT = [34,35,36];
URHIP = [37,38,39];
URKNE = [40,41,42];
URFOT = [43,44,45];
UORIGIN = [46,47,48];

HIP =  UTORS;
SPIN = UORIGIN;
NECK = UNECK;
HEAD = UHEAD;
LSHO = ULSHO;
LELB = ULELB;
LWST = UORIGIN;
LHND = ULHND;
RSHO = URSHO;
RELB = URELB;
RWST = UORIGIN;
RHND = URHND;
LHIP = ULHIP;
LKNE = ULKNE;
LANK = UORIGIN;
LFOT = ULFOT;
RHIP = URHIP;
RKNE = URKNE;
RANK = UORIGIN;
RFOT = URFOT;
SHO =  UORIGIN;
LTIP = UORIGIN;
LTHM = UORIGIN;
RTIP = UORIGIN;
RTHM = UORIGIN;

h = waitbar(0, 'Export');
tic;

numS = 1; numC = 1; numR = 1;
if targetType == 1  % training sequences
    numP = 1;  % performer id = 1 is a train seq
else  % testing sequences
    numP = 3;  % performer id = 3 is a test seq
end

for i=1:size(currSeqSet,1) % for each sequence do
    X = [targetFolder,': ',num2str(i),'/',num2str(size(currSeqSet,1))];
    X = strrep(X,'\','/');
    waitbar(i/size(currSeqSet,1), h, X);

    currSeqID = cell2mat(currSeqSet(i,1));
    currSeq = cell2mat(CompMoveData(currSeqID,4));
    currSeq(:,46:48) = 0; % put in a joint at the end with all-zero coordinates (origin coordinate)
     
    numFrame = size(currSeq,1);  % number of frames in the seq
    numJoints = 25; % hard-code to 25 joints, since this is the requirement for mmskeleon "layout: 'ntu-rgb+d'"
    numA = cell2mat(currSeqSet(i,2));  % label (action class number for ntu-rgb+d)
    
    for nrep = 1:repeatNum
        fileName = [targetFolder 'S' sprintf('%03d',numS) ...
                                 'C' sprintf('%03d',numC) ...
                                 'P' sprintf('%03d',numP) ...
                                 'R' sprintf('%03d',numR) ...
                                 'A' sprintf('%03d',numA) '.skeleton'];

        fid = fopen(fileName,'w'); % open file for writing
        currText = num2str(numFrame); %number of frames
        fprintf(fid,'%s\n',currText);

        for j = 1:numFrame  % for each frame do
            currText = '1';  % number of subjects in this frame
            fprintf(fid,'%s\n',currText);

            % the next row in the output file contains the following 10 numbers:
            % skeleton tracking ID (int)
            % clipped edges (int)
            % left-hand confidence (int)
            % left-hand state (int)
            % right-hand confidence (int)
            % right-hand state (int)
            % is-restricted (int)
            % lean X (real)
            % lean Y (real)
            % tracking state (int)
            currText = [num2str(skelTrackID) ' 0 1 1 1 1 0 0.0 0.0 2'];
            fprintf(fid,'%s\n',currText);

            currText = num2str(numJoints);  % number of joints 
            fprintf(fid,'%s\n',currText);

            % the next 25 rows in the output file contain the joint location
            % info - 1 row for each joint.  Each row contains the following
            % 11 numbers:
            % X-axis coordinate
            % Y-axis coordinate
            % Z-axis coordinate
            % X-axis location in corresponding depth/IR frame
            % Y-axis location in corresponding depth/IR frame
            % X-axis location in corresponding RGB frame
            % Y-axis location in corresponding RGB frame
            % joint orientation W
            % joint orientation X
            % joint orientation Y
            % joint orientation Z
            % tracking state of joint

            currText = [num2str(round(currSeq(j, HIP(1)),3),'%.3f') ' ' num2str(round(currSeq(j, HIP(2)),3),'%.3f') ' ' num2str(round(currSeq(j, HIP(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,SPIN(1)),3),'%.3f') ' ' num2str(round(currSeq(j,SPIN(2)),3),'%.3f') ' ' num2str(round(currSeq(j,SPIN(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,NECK(1)),3),'%.3f') ' ' num2str(round(currSeq(j,NECK(2)),3),'%.3f') ' ' num2str(round(currSeq(j,NECK(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,HEAD(1)),3),'%.3f') ' ' num2str(round(currSeq(j,HEAD(2)),3),'%.3f') ' ' num2str(round(currSeq(j,HEAD(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LSHO(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LSHO(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LSHO(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LELB(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LELB(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LELB(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LWST(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LWST(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LWST(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LHND(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LHND(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LHND(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RSHO(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RSHO(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RSHO(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RELB(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RELB(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RELB(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RWST(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RWST(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RWST(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RHND(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RHND(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RHND(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LHIP(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LHIP(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LHIP(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LKNE(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LKNE(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LKNE(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LANK(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LANK(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LANK(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LFOT(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LFOT(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LFOT(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RHIP(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RHIP(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RHIP(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RKNE(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RKNE(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RKNE(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RANK(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RANK(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RANK(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RFOT(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RFOT(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RFOT(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j, SHO(1)),3),'%.3f') ' ' num2str(round(currSeq(j, SHO(2)),3),'%.3f') ' ' num2str(round(currSeq(j, SHO(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LTIP(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LTIP(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LTIP(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,LTHM(1)),3),'%.3f') ' ' num2str(round(currSeq(j,LTHM(2)),3),'%.3f') ' ' num2str(round(currSeq(j,LTHM(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RTIP(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RTIP(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RTIP(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);
            currText = [num2str(round(currSeq(j,RTHM(1)),3),'%.3f') ' ' num2str(round(currSeq(j,RTHM(2)),3),'%.3f') ' ' num2str(round(currSeq(j,RTHM(3)),3),'%.3f') ' 0 0 0 0 0 0 0 0 2']; fprintf(fid,'%s\n',currText);

            %         currText = [num2str(round(HIP(1),3),'%.3f') ' ' num2str(round(HIP(1),3),'%.3f') ' ' num2str(round(HIP(1),3),'%.3f') ' 0 0 0 0 0 0 0 0 2'];
        end

        fclose(fid);

        numR = numR + 1;
        if numR == 1000
            numR = 1;
            numS = numS + 1;
        end

        skelTrackID = skelTrackID + 1;
    end
end

close(h);
timeElapsed = toc;
