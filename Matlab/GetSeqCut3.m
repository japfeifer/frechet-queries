% compute the frame cuts

function fc = GetSeqCut3(lowVaryPct,highVaryPct,lastFramePct,x,freqSize,phase)

    x2 = x;
    fc = [];
    currID = 1;
    minFrame = freqSize - floor(freqSize * lowVaryPct);
    maxFrame = freqSize + floor(freqSize * highVaryPct);
%     minLastFrame = freqSize - floor(freqSize * lastFramePct);
    minLastFrame = minFrame;
    while 1 == 1
        currLen = length(x2);
        if currLen < minLastFrame % we are done
            break;
        else % make a cut
            bestID = 0;
            bestDist = inf;
            if size(fc,1) > 0
                startIdx = minFrame; endIdx = min(maxFrame,currLen);
            else
                % compute best first cut (first frame of first cut)
                firstTol = freqSize - minFrame;
                bestFirstID = 0;
                bestFirstDist = inf;
                for i = phase : phase + firstTol % find smallest dist frame
                    if x2(i) < bestFirstDist
                        bestFirstID = i;
                        bestFirstDist = x2(i);
                    end
                end
                startIdx = min(minFrame + phase,currLen); endIdx = min(maxFrame + phase,currLen);
            end
            for i = startIdx : endIdx % find smallest dist frame
                if x2(i) < bestDist
                    bestID = i;
                    bestDist = x2(i);
                end
            end
            if size(fc,1) > 0
                fc(end+1,:) = [fc(end,2) bestID + currID - 1];
            else
                fc(1,:) = [bestFirstID bestID + currID - 1];
            end
            currID = currID + bestID - 1;
            x2 = x2(bestID:end);
        end
    end
end