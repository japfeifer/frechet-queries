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

NOSE = KNECK;
LEYE = KNECK;
REYE = KNECK;
LEAR = KNECK;
REAR = KNECK;
LSHO = KLSHO;
RSHO = KRSHO;
LELB = KLELB;
RELB = KRELB;
LWST = KLHND;
RWST = KRHND;
LHIP = KTORS;
RHIP = KTORS;
LKNE = KTORS;
RKNE = KTORS;
LANK = KTORS;
RANK = KTORS;

h = waitbar(0, 'Export');
tic;

for i=1:size(currSeqSet,1) % for each sequence do
    
    X = [targetFolder,': ',num2str(i),'/',num2str(size(currSeqSet,1))];
    X = strrep(X,'\','/');
    waitbar(i/size(currSeqSet,1), h, X);

    currSeqID = cell2mat(currSeqSet(i,1));
    currLabelID = cell2mat(currSeqSet(i,2));
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
    
    currSeq = normSeq;
    
    numFrame = size(currSeq,1);
    numJoints = 17; % hard-code to 18 joints, since this is the requirement for mmskeleon "layout: 'coco'"

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
        
        currText = '                "keypoints": [';
        currText = [currText,'[',num2str(currSeq(j,NOSE(1))),', ',num2str(currSeq(j,NOSE(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LEYE(1))),', ',num2str(currSeq(j,LEYE(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,REYE(1))),', ',num2str(currSeq(j,REYE(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LEAR(1))),', ',num2str(currSeq(j,LEAR(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,REAR(1))),', ',num2str(currSeq(j,REAR(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LSHO(1))),', ',num2str(currSeq(j,LSHO(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,RSHO(1))),', ',num2str(currSeq(j,RSHO(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LELB(1))),', ',num2str(currSeq(j,LELB(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,RELB(1))),', ',num2str(currSeq(j,RELB(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LWST(1))),', ',num2str(currSeq(j,LWST(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,RWST(1))),', ',num2str(currSeq(j,RWST(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LHIP(1))),', ',num2str(currSeq(j,LHIP(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,RHIP(1))),', ',num2str(currSeq(j,RHIP(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LKNE(1))),', ',num2str(currSeq(j,LKNE(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,RKNE(1))),', ',num2str(currSeq(j,RKNE(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,LANK(1))),', ',num2str(currSeq(j,LANK(2))),', 0.9], '];
        currText = [currText,'[',num2str(currSeq(j,RANK(1))),', ',num2str(currSeq(j,RANK(2))),', 0.9], '];

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
    currText = ['    "category_id": ',num2str(currLabelID - 1)];
    fprintf(fid,'%s\n',currText);
    currText = '}';
    fprintf(fid,'%s\n',currText);
    
    fclose(fid);
end

close(h);
timeElapsed = toc;
