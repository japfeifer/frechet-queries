% cut each NUTRGBD seq into individual signed words

h = waitbar(0, 'Cut NUTRGBD Seq');
CompMoveData2 = {[]};
cnt = 1;
szSeq = size(CompMoveData,1);
ComputeNTURGBDSeqOverride(); % get table of overrides
seqCutInfo = [];
seqCutInfo(szSeq,2) = 0;
for i = 1:szSeq % for each seq
    if mod(i,10) == 0
        X = ['Cut NTURGBD Seq: ',num2str(i),'/',num2str(szSeq)];
        waitbar(i/szSeq, h, X);
    end
    processSeq = overrideNTURGBD(i,1);
    if processSeq == 1 % process seq or not
        seq = cell2mat(CompMoveData(i,4)); % get raw seq
        seq = seq(overrideNTURGBD(i,2) : overrideNTURGBD(i,3), :); % seq start/end frames
        seq = NTURGBDNormalizeSeq(seq,[0 1 0 1 0 0]); % transform the seq
%         seq = NTURGBDExtractFeatures(seq,2);
        lowVaryPct = overrideNTURGBD(i,4);
        highVaryPct = overrideNTURGBD(i,5);
        lastFramePct = overrideNTURGBD(i,6);
        x = GetSeqDist2(seq); % get seq distances to first frame
        [phase,numSubSeq,freqSize] = GetSeqDistFreqSize2(x,seq,1,lowVaryPct,highVaryPct,lastFramePct); % get number of frames per sub-seq
        fc = GetSeqCut3(lowVaryPct,highVaryPct,lastFramePct,x,freqSize,phase); % create initial vector of frame cuts
        [fcTmp2,bestTotDist] = GetBestSeqCluster(fc,seq);
        fcTmp2 = sortrows(fcTmp2,[4]); % sort by cluster center and distances
        
        if isempty(fc) == false
            seq = cell2mat(CompMoveData(i,4)); % convert seq back to original non-normalized "raw" format
            seq = seq(overrideNTURGBD(i,2) : overrideNTURGBD(i,3), :); % seq start/end frames
            seqCutInfo(i,:) = [i size(fc,1)];

            currSeq = seq(fcTmp2(1,2):fcTmp2(1,3),:); % get the sub-seq
            CompMoveData2(cnt,1) = CompMoveData(i,1);
            CompMoveData2(cnt,2) = CompMoveData(i,2);
            CompMoveData2(cnt,3) = CompMoveData(i,3);
            CompMoveData2(cnt,4) = mat2cell(currSeq,size(currSeq,1),size(currSeq,2));
            cnt = cnt + 1;
        end
    end
end
close(h);

CompMoveData2 = sortrows(CompMoveData2,[1,2,3]); % sort by class,subject,seq id

% CompMoveData = CompMoveData2;
% save('NTURGBDSubSeqData.mat','CompMoveData');


