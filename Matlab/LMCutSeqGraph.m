seqID = 255;
plotType = 2; 

ComputeLMSeqOverride(); % get table of overrides
seq = cell2mat(CompMoveData(seqID,4)); % get raw seq
seq = LMNormalizeSeq(seq,[1]); % normalize seq
seq = LMExtractFeatures(seq,2);
seq = seq(overrideLM(seqID,2) : overrideLM(seqID,3), :); % seq start/end frames
lowVaryPct = overrideLM(seqID,4);
highVaryPct = overrideLM(seqID,5);
lastFramePct = overrideLM(seqID,6);
x = GetSeqDist(seq); % get seq distances to first frame
[phase,numSubSeq,freqSize] = GetSeqDistFreqSize(x,seq,1,lowVaryPct,highVaryPct,lastFramePct); % get number of frames per sub-seq
fc = GetSeqCut(lowVaryPct,highVaryPct,lastFramePct,x,freqSize); % create initial vector of frame cuts
[threshDist,meanDist,numKeepSubSeq,numDiscardSubSeq,numDStart,numDEnd,fcNew,fcDiscard] = GetClusterSubSeq(fc,seq); % do clustering and refine frame cuts

PlotSeqDist; % plot the seq distances to first frame
