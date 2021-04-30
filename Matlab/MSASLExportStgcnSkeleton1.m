% Convert to 2D openpose format with 18 joints.
% Normalize coordinates to [0,1], where upper left corner is coordinate
% (0,0) and bottom right corner is coordinate (1,1).

% this code is specific to the MSASL dataset

HEAD = [1,2,3];         NECK = [4,5,6];         RSHO = [7,8,9];        RELB = [10,11,12];
RWST = [13,14,15];      LSHO = [16,17,18];      LELB = [19,20,21];     LWST = [22,23,24];
RHIP = [25,26,27];      RKNE = [28,29,30];      RFOT = [31,32,33];     LHIP = [34,35,36];
LKNE = [37,38,39];      LFOT = [40,41,42];      REYE = [43,44,45];     LEYE = [46,47,48];
REAR = [49,50,51];      LEAR = [52,53,54]; 

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
    
%     % normalize the seq
%     xval = [currSeq(:,1)'  currSeq(:,4)'  currSeq(:,7)'  currSeq(:,10)' currSeq(:,13)' ...
%             currSeq(:,16)' currSeq(:,19)' currSeq(:,22)' currSeq(:,25)' currSeq(:,28)' ...
%             currSeq(:,31)' currSeq(:,34)' currSeq(:,37)' currSeq(:,40)' currSeq(:,43)' ...
%             currSeq(:,46)' currSeq(:,49)' currSeq(:,52)'];
%     yval = [currSeq(:,2)'  currSeq(:,5)'  currSeq(:,8)'  currSeq(:,11)' currSeq(:,14)' ...
%             currSeq(:,17)' currSeq(:,20)' currSeq(:,23)' currSeq(:,26)' currSeq(:,29)' ...
%             currSeq(:,32)' currSeq(:,35)' currSeq(:,38)' currSeq(:,41)' currSeq(:,44)' ...
%             currSeq(:,47)' currSeq(:,50)' currSeq(:,53)'];
%     minxval = min(xval);
%     maxxval = max(xval);
%     minyval = min(yval);
%     maxyval = max(yval);
%     
%     normSeq = currSeq;
%     
%     % x axis
%     colsProcess = [1 4 7 10 13 16 19 22 25 28 31 34 37 40 43 46 49 52];
%     for j = 1:size(colsProcess,2)
%         normSeq(:,colsProcess(j)) = ((normSeq(:,colsProcess(j)) - minxval) / (maxxval - minxval));
%     end
% 
%     % y axis
%     colsProcess = [2 5 8 11 14 17 20 23 26 29 32 35 38 41 44 47 50 53];
%     for j = 1:size(colsProcess,2)
%         normSeq(:,colsProcess(j)) = ((normSeq(:,colsProcess(j)) - minyval) / (maxyval - minyval));
%     end
%     
%     % z axis
%     colsProcess = [3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48 51 54];
%     for j = 1:size(colsProcess,2)
%         normSeq(:,colsProcess(j)) = 0;
%     end
%     
%     currSeq = normSeq;
    
    numFrame = size(currSeq,1);
    numJoints = 18; % hard-code to 18 joints, since this is the requirement for "layout: 'openpose'"
    
    for ii = 1:repeatNum

        fileName = strcat(targetFolder,num2str(currSeqID),'-',num2str(ii),'.json'); % name of file to create

        % write header to file
        fid = fopen(fileName,'w');
        currText = '{"data": [';
        fprintf(fid,'%s',currText);

        for j = 1:numFrame  % for each frame do
            currText = ['{"frame_index": ',sprintf('%d',j),', "skeleton": ['];
            fprintf(fid,'%s',currText); 
            currText = ['{"pose": [' ...
                       sprintf('%.3f',round(currSeq(j,HEAD(1)),3)),', ',sprintf('%.3f',round(currSeq(j,HEAD(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j, NECK(1)),3)),', ',sprintf('%.3f',round(currSeq(j, NECK(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,RSHO(1)),3)),', ',sprintf('%.3f',round(currSeq(j,RSHO(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,RELB(1)),3)),', ',sprintf('%.3f',round(currSeq(j,RELB(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,RWST(1)),3)),', ',sprintf('%.3f',round(currSeq(j,RWST(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LSHO(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LSHO(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LELB(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LELB(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LWST(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LWST(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,RHIP(1)),3)),', ',sprintf('%.3f',round(currSeq(j,RHIP(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,RKNE(1)),3)),', ',sprintf('%.3f',round(currSeq(j,RKNE(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,RFOT(1)),3)),', ',sprintf('%.3f',round(currSeq(j,RFOT(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LHIP(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LHIP(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LKNE(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LKNE(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LFOT(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LFOT(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,REYE(1)),3)),', ',sprintf('%.3f',round(currSeq(j,REYE(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LEYE(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LEYE(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,REAR(1)),3)),', ',sprintf('%.3f',round(currSeq(j,REAR(2)),3)),', ' ...
                       sprintf('%.3f',round(currSeq(j,LEAR(1)),3)),', ',sprintf('%.3f',round(currSeq(j,LEAR(2)),3)),'], '];

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
end

close(h);
timeElapsed = toc;
