seqID = 48;
% seqID = 40000;
% seqID = 40128;
% seqID = 2700;
% seqID = 50;
% seqID = 5967;
plotType = 2; 

ComputeNTURGBDSeqOverride(); % get table of overrides
seq = cell2mat(CompMoveData(seqID,4)); % get raw seq
seq = NTURGBDNormalizeSeq(seq,[0 1 0 1 0 0]); % normalize seq
% seq = NTURGBDExtractFeatures(seq,2);
seq = seq(overrideNTURGBD(seqID,2) : overrideNTURGBD(seqID,3), :); % seq start/end frames
lowVaryPct = overrideNTURGBD(seqID,4);
highVaryPct = overrideNTURGBD(seqID,5);
lastFramePct = overrideNTURGBD(seqID,6);
x = GetSeqDist2(seq); % get seq distances to first frame
[phase,numSubSeq,freqSize] = GetSeqDistFreqSize2(x,seq,1,lowVaryPct,highVaryPct,lastFramePct); % get number of frames per sub-seq
fc = GetSeqCut3(lowVaryPct,highVaryPct,lastFramePct,x,freqSize,phase); % create initial vector of frame cuts

[fcTmp2,bestTotDist] = GetBestSeqCluster(fc,seq);

[threshDist,meanDist,numKeepSubSeq,numDiscardSubSeq,numDStart,numDEnd,fcNew,fcDiscard] = GetClusterSubSeq(fc,seq); % do clustering and refine frame cuts

PlotSeqDist; % plot the seq distances to first frame
