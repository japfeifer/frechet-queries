% compute the frame cuts

function fc = GetSeqCut(lowVaryPct,highVaryPct,lastFramePct,x,freqSize)

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
            for i = minFrame : min(maxFrame,currLen) % find smallest dist frame
                if x2(i) < bestDist
                    bestID = i;
                    bestDist = x2(i);
                end
            end
            if size(fc,1) > 0
                fc(end+1,:) = [fc(end,2) bestID + currID - 1];
            else
                fc(1,:) = [1 bestID + currID - 1];
            end
            currID = currID + bestID - 1;
            x2 = x2(bestID:end);
        end
    end
end