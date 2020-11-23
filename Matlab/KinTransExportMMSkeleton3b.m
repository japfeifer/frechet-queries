% this code is specific to the KinTrans dataset

KNECK = [1,2,3];
KTORS = [4,5,6];
KRSHO = [7,8,9];
KRELB = [10,11,12];
KRWST = [13,14,15];
KRHND = [16,17,18];
KLSHO = [19,20,21];
KLELB = [22,23,24];
KLWST = [25,26,27];
KLHND = [28,29,30];
KORIGIN = [31,32,33];

SHO = KNECK;
RSHO = KRSHO;
RELB = KRELB;
RHND = KRHND;
LSHO = KLSHO;
LELB = KLELB;
LHND = KLHND;

h = waitbar(0, 'Export');
tic;

for i=1:size(currSeqSet,1) % for each sequence do
    
    X = [targetFolder,': ',num2str(i),'/',num2str(size(currSeqSet,1))];
    X = strrep(X,'\','/');
    waitbar(i/size(currSeqSet,1), h, X);

    currSeqID = cell2mat(currSeqSet(i,1));
    currLabelID = cell2mat(currSeqSet(i,2));
    currLabelID = currLabelID - 1;
    currSeq = cell2mat(CompMoveData(currSeqID,4));
    currSeq(:,31:33) = 0; % put in a joint at the end with all-zero coordinates (origin coordinate)
    
    % normalize the seq
    xval = [currSeq(:,1)' currSeq(:,4)' currSeq(:,7)' currSeq(:,10)' currSeq(:,13)' currSeq(:,16)' currSeq(:,19)' currSeq(:,22)' currSeq(:,25)' currSeq(:,28)' ];
    yval = [currSeq(:,2)' currSeq(:,5)' currSeq(:,8)' currSeq(:,11)' currSeq(:,14)' currSeq(:,17)' currSeq(:,20)' currSeq(:,23)' currSeq(:,26)' currSeq(:,29)' ];
    minxval = min(xval);
    maxxval = max(xval);
    minyval = min(yval);
    maxyval = max(yval);
    
    normSeq = currSeq;
    
    % x axis
    colsProcess = [1 4 7 10 13 16 19 22 25 28];
    for j = 1:size(colsProcess,2)
        normSeq(:,colsProcess(j)) = 1 - ((normSeq(:,colsProcess(j)) - minxval) / (maxxval - minxval));
    end

    % y axis
    colsProcess = [2 5 8 11 14 17 20 23 26 29];
    for j = 1:size(colsProcess,2)
        normSeq(:,colsProcess(j)) = 1 - ((normSeq(:,colsProcess(j)) - minyval) / (maxyval - minyval));
    end
    
    % z axis
    colsProcess = [3 6 9 12 15 18 21 24 27 30];
    for j = 1:size(colsProcess,2)
        normSeq(:,colsProcess(j)) = 0;
    end
    
    normSeq = normSeq * 0.25;  % shrink the subject
    normSeq = normSeq + 0.4;  % translate the subject closer to the center
    normSeq(:,31:33) = 0; % make origin joint all-zero coordinates (origin coordinate)
    
    currSeq = normSeq;
    
    numFrame = size(currSeq,1);
    numJoints = 18; % hard-code to 18 joints, since this is the requirement for mmskeleon "layout: 'openpose'"

    fileName = strcat(targetFolder,num2str(currSeqID),'.json'); % name of file to create
    
    %write header to file
    fid = fopen(fileName,'w');
    currText = '{';
    fprintf(fid,'%s\n',currText);
    currText = '    "info":';
    fprintf(fid,'%s\n',currText);
    currText = '        {';
    fprintf(fid,'%s\n',currText);
    currText = ['            "video_name": null,'];
    fprintf(fid,'%s\n',currText);
    currText = '            "resolution": null,';
    fprintf(fid,'%s\n',currText);
    currText = ['            "num_frame": ',num2str(numFrame),','];
    fprintf(fid,'%s\n',currText);
    currText = ['            "num_keypoints": ',num2str(numJoints),','];
    fprintf(fid,'%s\n',currText);    
    currText = '            "keypoint_channels": ["x", "y", "score"],';
    fprintf(fid,'%s\n',currText);
    currText = '            "version": null';
    fprintf(fid,'%s\n',currText);
    currText = '        },';
    fprintf(fid,'%s\n',currText);
    currText = '    "annotations":';
    fprintf(fid,'%s\n',currText);
    currText = '        [';
    fprintf(fid,'%s\n',currText);
    
    for j = 1:numFrame  % for each frame do
        currText = '            {';
        fprintf(fid,'%s\n',currText);
        currText = ['                "frame_index": ',num2str(j-1),','];
        fprintf(fid,'%s\n',currText);
        currText = ['                "id": ',num2str(idcnt),','];
        fprintf(fid,'%s\n',currText);
        currText = '                "person_id": null,';
        fprintf(fid,'%s\n',currText);

        % interpolate joints in openpose that are not in KinTrans
        HEAD(1) = currSeq(j, SHO(1));
        HEAD(2) = currSeq(j, SHO(2)) - 0.08;
        RTHD(1) = currSeq(j, SHO(1)) - 0.02;
        RTHD(2) = currSeq(j, SHO(2)) - 0.09;
        LTHD(1) = currSeq(j, SHO(1)) + 0.02;
        LTHD(2) = currSeq(j, SHO(2)) - 0.09;
        REAR(1) = currSeq(j, SHO(1)) - 0.04;
        REAR(2) = currSeq(j, SHO(2)) - 0.08;
        LEAR(1) = currSeq(j, SHO(1)) + 0.04;
        LEAR(2) = currSeq(j, SHO(2)) - 0.08;
        RHIP(1) = currSeq(j, KTORS(1)) - 0.05;
        RHIP(2) = currSeq(j, KTORS(2));
        LHIP(1) = currSeq(j, KTORS(1)) + 0.05;
        LHIP(2) = currSeq(j, KTORS(2));
        RKNE(1) = currSeq(j, KTORS(1)) - 0.05;
        RKNE(2) = currSeq(j, KTORS(2)) + 0.12;
        LKNE(1) = currSeq(j, KTORS(1)) + 0.05;
        LKNE(2) = currSeq(j, KTORS(2)) + 0.12;
        RFOT(1) = currSeq(j, KTORS(1)) - 0.05;
        RFOT(2) = currSeq(j, KTORS(2)) + 0.20;
        LFOT(1) = currSeq(j, KTORS(1)) + 0.05;
        LFOT(2) = currSeq(j, KTORS(2)) + 0.20;
        
        currText = '                "keypoints": [';
        currText = [currText,'[',num2str(round(HEAD(1),3),'%.3f'),', ',num2str(round(HEAD(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j, SHO(1)),3),'%.3f'),', ',num2str(round(currSeq(j, SHO(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j,RSHO(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RSHO(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j,RELB(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RELB(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j,RHND(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RHND(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j,LSHO(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LSHO(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j,LELB(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LELB(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(currSeq(j,LHND(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LHND(2)),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(RHIP(1),3),'%.3f'),', ',num2str(round(RHIP(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(RKNE(1),3),'%.3f'),', ',num2str(round(RKNE(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(RFOT(1),3),'%.3f'),', ',num2str(round(RFOT(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(LHIP(1),3),'%.3f'),', ',num2str(round(LHIP(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(LKNE(1),3),'%.3f'),', ',num2str(round(LKNE(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(LFOT(1),3),'%.3f'),', ',num2str(round(LFOT(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(RTHD(1),3),'%.3f'),', ',num2str(round(RTHD(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(LTHD(1),3),'%.3f'),', ',num2str(round(LTHD(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(REAR(1),3),'%.3f'),', ',num2str(round(REAR(2),3),'%.3f'),', 0.9], '];
        currText = [currText,'[',num2str(round(LEAR(1),3),'%.3f'),', ',num2str(round(LEAR(2),3),'%.3f'),', 0.9], '];

        currText = currText(1:end-2);  % remove last comma
        currText = [currText,']'];

        fprintf(fid,'%s\n',currText);
        
        currText = '            },';
        if j == numFrame
            currText = currText(1:end-1);  % remove last comma
        end
        fprintf(fid,'%s\n',currText);
        
        idcnt = idcnt + 1;
    end
    
    currText = '        ],';
    fprintf(fid,'%s\n',currText);
    currText = ['    "category_id": ',num2str(currLabelID)];
    fprintf(fid,'%s\n',currText);
    currText = '}';
    fprintf(fid,'%s\n',currText);
    
    fclose(fid);
end

close(h);
timeElapsed = toc;
