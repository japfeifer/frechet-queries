% cut each LM seq into individual signed words

h = waitbar(0, 'Cut LM Seq');
CompMoveData2 = {[]};
cnt = 1;
cntKeepSeq = 0;
cntDiscardSeq = 0;
cntKeepSubSeq = 0;
cntDiscardSubSeq = 0;
cntNumDStart = 0;
cntNumDEnd = 0;
szSeq = size(CompMoveData,1);
ComputeLMSeqOverride(); % get table of overrides
for i = 1:szSeq % for each seq
    X = ['Cut LM Seq: ',num2str(i),'/',num2str(szSeq)];
    waitbar(i/szSeq, h, X);
    processSeq = overrideLM(i,1);
    if processSeq == 1 % process seq or not
        seq = cell2mat(CompMoveData(i,4)); % get raw seq
        seq = seq(overrideLM(i,2) : overrideLM(i,3), :); % seq start/end frames
        seq = LMNormalizeSeq(seq,[1]); % transform the seq
        seq = LMExtractFeatures(seq,2);
        lowVaryPct = overrideLM(i,4);
        highVaryPct = overrideLM(i,5);
        lastFramePct = overrideLM(i,6);
        x = GetSeqDist(seq); % get seq distances to first frame
        [phase,numSubSeq,freqSize] = GetSeqDistFreqSize(x,seq,1,lowVaryPct,highVaryPct,lastFramePct); % get number of frames per sub-seq
        fc = GetSeqCut(lowVaryPct,highVaryPct,lastFramePct,x,freqSize); % create initial vector of frame cuts
        [threshDist,meanDist,numKeepSubSeq,numDiscardSubSeq,numDStart,numDEnd,fc,fcDiscard] = GetClusterSubSeq(fc,seq); % do clustering and refine frame cuts
        cntKeepSubSeq = cntKeepSubSeq + numKeepSubSeq;
        cntDiscardSubSeq = cntDiscardSubSeq + numDiscardSubSeq;
        cntNumDStart = cntNumDStart + numDStart;
        cntNumDEnd = cntNumDEnd + numDEnd;
        cntKeepSeq = cntKeepSeq + 1;
        if isempty(fc) == false
            rep = 1; % repetition number
            seq = cell2mat(CompMoveData(i,4)); % convert seq back to original non-normalized "raw" format
            seq = seq(overrideLM(i,2) : overrideLM(i,3), :); % seq start/end frames
            for j = 1:size(fc,1)
                currSeq = seq(fc(j,1):fc(j,2),:); % get the sub-seq
                reach = TrajReach(currSeq); % compute the sub-seq traj reach
                currSeq = TrajSimp(currSeq,reach * 0.02); % simplify the sub-seq (speeds-up experiment processing)
                CompMoveData2(cnt,1) = CompMoveData(i,1);
                CompMoveData2(cnt,2) = CompMoveData(i,2);
                CompMoveData2(cnt,3) = num2cell(rep);
                CompMoveData2(cnt,4) = mat2cell(currSeq,size(currSeq,1),size(currSeq,2));
                cnt = cnt + 1;
                rep = rep + 1; 
            end
        else
            cntDiscardSeq = cntDiscardSeq + 1;
        end
    else
        cntDiscardSeq = cntDiscardSeq + 1;
    end
end
close(h);

CompMoveData2 = sortrows(CompMoveData2,[1,2,3]); % sort by class,subject,seq id

disp(['Seq Keep: ',num2str(cntKeepSeq), ...
      ' Seq Discard: ',num2str(cntDiscardSeq), ...
      ' SubSeq Keep: ',num2str(cntKeepSubSeq), ...
      ' SubSeq Discard: ',num2str(cntDiscardSubSeq), ...
      ' SubSeq Start Discard: ',num2str(cntNumDStart), ...
      ' SubSeq End Discard: ',num2str(cntNumDEnd)]);

% CompMoveData = CompMoveData2;
% save('LMSubSeqData.mat','CompMoveData');


