% get the frequency size for a sequence distance array, i.e. determine the
% average number of frames per sub-seq using fourier transform math

function [phase,numSubSeq,freqSize] = GetSeqDistFreqSize(x,seq,doCheck,lowVaryPct,highVaryPct,lastFramePct)

    Fs = length(x);
    N = length(x);
    xdft = fft(x); % fourier transform
    
%     phase = unwrap(angle(xdft)); 
    
    xdft = xdft(1:floor(N/2+1));
    psdx = (1/(Fs*N)) * abs(xdft).^2;
    psdx(2:end-1) = 2*psdx(2:end-1);
    ignoreVal = 5; % ignore the first 5 values (this variable should be set to 1 or greater)
    [m,numSubSeq] = max(psdx(1+ignoreVal:end)); % find the index with the maximum "spike"
    numSubSeq = numSubSeq + ignoreVal - 1;
    freqSize = floor(N/numSubSeq);
    
    % see if a smaller numSubSeq is better by checking best cluster total distances
    if numSubSeq >= 18 && doCheck == 1
        % get best cluster total distance for current numSubSeq
        numSubSeq1 = numSubSeq;
        freqSize1 = freqSize;
        fc = GetSeqCut(lowVaryPct,highVaryPct,lastFramePct,x,freqSize1);
        [fcTmp,bestTotDist1] = GetBestSeqCluster(fc,seq);
        bestDist1 = bestTotDist1 / numSubSeq1; % average dist based on num of sub seq
        
        % get best cluster total distance for half of numSubSeq
        [m,numSubSeq2] = max(psdx(1+ignoreVal:numSubSeq1-1)); % find the index with the maximum "spike", but smaller than the last spike
        numSubSeq2 = numSubSeq2 + ignoreVal - 1;
        freqSize2 = floor(N/numSubSeq2);
        fc = GetSeqCut(lowVaryPct,highVaryPct,lastFramePct,x,freqSize2);
        [fcTmp,bestTotDist2] = GetBestSeqCluster(fc,seq);
        bestDist2 = bestTotDist2 / numSubSeq2; % average dist based on num of sub seq

        % get best cluster total distance for third of numSubSeq
        [m,numSubSeq3] = max(psdx(1+ignoreVal:numSubSeq2-1)); % find the index with the maximum "spike", but smaller than the last spike
        numSubSeq3 = numSubSeq3 + ignoreVal - 1;
        freqSize3 = floor(N/numSubSeq3);
        fc = GetSeqCut(lowVaryPct,highVaryPct,lastFramePct,x,freqSize3);
        [fcTmp,bestTotDist3] = GetBestSeqCluster(fc,seq);
        bestDist3 = bestTotDist3 / numSubSeq3; % average dist based on num of sub seq
        
        if bestDist2 < bestDist1 % choose the min bestDist
            if bestDist3 < bestDist2
                freqSize = freqSize3;
                numSubSeq = numSubSeq3;
            else
                freqSize = freqSize2;
                numSubSeq = numSubSeq2;
            end
        end
    end

    phase = (angle(xdft(numSubSeq+1)) / (2 * pi)) * N;    % frame id for Phase
    phase = floor(abs(phase));
    phase = mod(phase,freqSize);
    
    
%     Xaxis = 0:Fs/length(x):Fs/2;
%     plot(Xaxis,10*log10(psdx))
%     grid on
%     title('Periodogram Using FFT')
%     xlabel('Frequency (Hz)')
%     ylabel('Power/Frequency (dB/Hz)')

end