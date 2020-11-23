function currSet = DMDistSetupFnc(currSet,numFrameDist,numSetDist)

    for i = 1:size(currSet)
        seq = cell2mat(currSet(i,3));
        currFrameList = [];
        seqSz = size(seq,1);
        numPossCut = seqSz - numFrameDist + 1;
        if seqSz <= numFrameDist
            currFrameList(1,1:2) = [1 seqSz];
        elseif numPossCut <= numSetDist
            for j = 1:numPossCut
                currFrameList(j,1:2) = [j numFrameDist+j-1];
            end
        else
            frameStart = datasample(1:numPossCut,numSetDist,'Replace',false);
            for j = 1:size(frameStart,2)
                currFrame = frameStart(j);
                currFrameList(j,1:2) = [currFrame numFrameDist+currFrame-1];
            end
        end

        currFrameList = sortrows(currFrameList,[1]);
        currSet(i,4) = mat2cell(currFrameList,size(currFrameList,1),size(currFrameList,2));

    end
end