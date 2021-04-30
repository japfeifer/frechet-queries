% MSASL pre-processing step
%
% Some joints are set to origin for one or more frames. 
% Update these joints to previous frame non-origin value.
% If joint is origin for first frame(s), set them to first non-origin value.
% If all frames are origin for a joint, throw an exception error

h = waitbar(0, 'MSASL Fix joints at origin');
szComp = size(CompMoveData,1);
for i = 1:szComp
    currSeq = cell2mat(CompMoveData(i,4));
    changeFlg = 0;
    for j = 1:(size(currSeq,2) / 3) % do for each joint
        idxStart = (j*3) - 2;
        idxEnd = idxStart + 2;
        currJointSeq = currSeq(:,idxStart:idxEnd);
        firstFrameFlg = 0;
        for k = 1:size(currJointSeq,1)
            if currJointSeq(k,1) == 0 && currJointSeq(k,2) == 0 && currJointSeq(k,3) == 0 % joint is at origin
                if k == 1 || firstFrameFlg == 1
                    firstFrameFlg = 1;
                else
                    disp(['Middle, seq id: ',num2str(i),' joint: ',num2str(j),' frame: ',num2str(k)]);
                    currJointSeq(k,:) = currJointSeq(k-1,:);
                    changeFlg = 1;
                end
            elseif firstFrameFlg == 1
                disp(['Beginning, seq id: ',num2str(i),' joint: ',num2str(j),' frame: ',num2str(k)]);
                changeFlg = 1;
                firstFrameFlg = 0;
                for m = 1:k-1
                    currJointSeq(m,:) = currJointSeq(k,:);
                end
            end
        end
        if firstFrameFlg == 1
            disp(['All frames for joint are at origin.']);
        end
        currSeq(:,idxStart:idxEnd) = currJointSeq;
    end
    if changeFlg == 1
        CompMoveData(i,4) = mat2cell(currSeq,size(currSeq,1),size(currSeq,2));
    end
    if mod(i,10) == 0
        X = ['MSASL Fix joints at origin: ',num2str(i),'/',num2str(szComp)];
        waitbar(i/szComp, h, X);
    end
end
close(h);