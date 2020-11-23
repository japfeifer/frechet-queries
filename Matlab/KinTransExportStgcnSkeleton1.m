% Convert to 2D openpose format with 18 joints.
% Normalize coordinates to [0,1], where upper left corner is coordinate
% (0,0) and bottom right corner is coordinate (1,1).

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

HEAD = KNECK;
SHO = KNECK;
RSHO = KRSHO;
RELB = KRELB;
RHND = KRHND;
LSHO = KLSHO;
LELB = KLELB;
LHND = KLHND;
RHIP = KTORS;
RKNE = KTORS;
RFOT = KTORS;
LHIP = KTORS;
LKNE = KTORS;
LFOT = KTORS;
RTHD = KNECK;
LTHD = KNECK;
REAR = KNECK;
LEAR = KNECK;

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
    
    currSeq = normSeq;
    
    numFrame = size(currSeq,1);
    numJoints = 18; % hard-code to 18 joints, since this is the requirement for mmskeleon "layout: 'openpose'"

    fileName = strcat(targetFolder,num2str(currSeqID),'.json'); % name of file to create
    
    % write header to file
    fid = fopen(fileName,'w');
    currText = '{"data": [';
    fprintf(fid,'%s',currText);

    for j = 1:numFrame  % for each frame do
        currText = ['{"frame_index": ',num2str(j),', "skeleton": ['];
        fprintf(fid,'%s',currText);
        
        currText = '{"pose": [';
        currText = [currText,num2str(round(currSeq(j,HEAD(1)),3),'%.3f'),', ',num2str(round(currSeq(j,HEAD(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j, SHO(1)),3),'%.3f'),', ',num2str(round(currSeq(j, SHO(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RSHO(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RSHO(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RELB(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RELB(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RHND(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RHND(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LSHO(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LSHO(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LELB(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LELB(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LHND(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LHND(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RHIP(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RHIP(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RKNE(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RKNE(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RFOT(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RFOT(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LHIP(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LHIP(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LKNE(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LKNE(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LFOT(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LFOT(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,RTHD(1)),3),'%.3f'),', ',num2str(round(currSeq(j,RTHD(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LTHD(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LTHD(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,REAR(1)),3),'%.3f'),', ',num2str(round(currSeq(j,REAR(2)),3),'%.3f'),', '];
        currText = [currText,num2str(round(currSeq(j,LEAR(1)),3),'%.3f'),', ',num2str(round(currSeq(j,LEAR(2)),3),'%.3f'),'], '];
        fprintf(fid,'%s',currText);

        currText = '"score": [0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900, 0.900]}]}, ';

        if j == numFrame
            currText = currText(1:end-2);  % remove last comma
        end
        fprintf(fid,'%s',currText);
        
    end
    
    currText = ['], "label": "',num2str(currLabelID),'", "label_index": ',num2str(currLabelID),'}'];
    fprintf(fid,'%s',currText);
    
    fclose(fid);
end

close(h);
timeElapsed = toc;
