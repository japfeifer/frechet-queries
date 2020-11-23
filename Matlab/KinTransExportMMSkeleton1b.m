% this code is specific to the KinTrans dataset

KNECK = [1,2,3];
KTORS = [4,5,6];
KRSO = [7,8,9];
KRELB = [10,11,12];
KRWST = [13,14,15];
KRHND = [16,17,18];
KLSHO = [19,20,21];
KLELB = [22,23,24];
KLWST = [25,26,27];
KLHND = [28,29,30];
KORIGIN = [31,32,33];

HIP = KTORS;
% SPIN = KTORS;
NECK = KNECK;
% HEAD = KNECK;
LSHO = KLSHO;
LELB = KLELB;
LWST = KLWST;
LHND = KLHND;
RSHO = KRSO;
RELB = KRELB;
RWST = KRWST;
RHND = KRHND;
% LHIP = KTORS;
% LKNE = KTORS;
% LANK = KTORS;
% LFOT = KTORS;
% RHIP = KTORS;
% RKNE = KTORS;
% RANK = KTORS;
% RFOT = KTORS;
SHO = KNECK;
LTIP = KLHND;
LTHM = KLHND;
RTIP = KRHND;
RTHM = KRHND;

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
    numFrame = size(currSeq,1);
    numJoints = 25; % hard-code to 25 joints, since this is the requirement for mmskeleon "layout: 'ntu-rgb+d'"

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
    currText = '            "keypoint_channels": ["x", "y", "z"],';
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
        currText = [currText,'[',num2str(currSeq(j,HIP(1))),', ',num2str(currSeq(j,HIP(2))),', ',num2str(currSeq(j,HIP(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,SPIN(1))),', ',num2str(currSeq(j,SPIN(2))),', ',num2str(currSeq(j,SPIN(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,NECK(1))),', ',num2str(currSeq(j,NECK(2))),', ',num2str(currSeq(j,NECK(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,HEAD(1))),', ',num2str(currSeq(j,HEAD(2))),', ',num2str(currSeq(j,HEAD(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LSHO(1))),', ',num2str(currSeq(j,LSHO(2))),', ',num2str(currSeq(j,LSHO(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LELB(1))),', ',num2str(currSeq(j,LELB(2))),', ',num2str(currSeq(j,LELB(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LWST(1))),', ',num2str(currSeq(j,LWST(2))),', ',num2str(currSeq(j,LWST(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LHND(1))),', ',num2str(currSeq(j,LHND(2))),', ',num2str(currSeq(j,LHND(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RSHO(1))),', ',num2str(currSeq(j,RSHO(2))),', ',num2str(currSeq(j,RSHO(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RELB(1))),', ',num2str(currSeq(j,RELB(2))),', ',num2str(currSeq(j,RELB(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RWST(1))),', ',num2str(currSeq(j,RWST(2))),', ',num2str(currSeq(j,RWST(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RHND(1))),', ',num2str(currSeq(j,RHND(2))),', ',num2str(currSeq(j,RHND(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LHIP(1))),', ',num2str(currSeq(j,LHIP(2))),', ',num2str(currSeq(j,LHIP(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LKNE(1))),', ',num2str(currSeq(j,LKNE(2))),', ',num2str(currSeq(j,LKNE(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LANK(1))),', ',num2str(currSeq(j,LANK(2))),', ',num2str(currSeq(j,LANK(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LFOT(1))),', ',num2str(currSeq(j,LFOT(2))),', ',num2str(currSeq(j,LFOT(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RHIP(1))),', ',num2str(currSeq(j,RHIP(2))),', ',num2str(currSeq(j,RHIP(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RKNE(1))),', ',num2str(currSeq(j,RKNE(2))),', ',num2str(currSeq(j,RKNE(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RANK(1))),', ',num2str(currSeq(j,RANK(2))),', ',num2str(currSeq(j,RANK(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RFOT(1))),', ',num2str(currSeq(j,RFOT(2))),', ',num2str(currSeq(j,RFOT(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,SHO(1))),', ',num2str(currSeq(j,SHO(2))),', ',num2str(currSeq(j,SHO(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LTIP(1))),', ',num2str(currSeq(j,LTIP(2))),', ',num2str(currSeq(j,LTIP(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,LTHM(1))),', ',num2str(currSeq(j,LTHM(2))),', ',num2str(currSeq(j,LTHM(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RTIP(1))),', ',num2str(currSeq(j,RTIP(2))),', ',num2str(currSeq(j,RTIP(3))),'], '];
        currText = [currText,'[',num2str(currSeq(j,RTHM(1))),', ',num2str(currSeq(j,RTHM(2))),', ',num2str(currSeq(j,RTHM(3))),'], '];
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

