% compute the frame cuts

function fc = GetSeqCut2(lowVaryPct,highVaryPct,lastFramePct,x,freqSize)

    fc = [];
    currID = 1;
    minLastFrame = freqSize - floor(freqSize * lastFramePct);
    minFrame = freqSize - floor(freqSize * lowVaryPct);
    maxFrame = freqSize + floor(freqSize * highVaryPct);
    
    % make first cut
    currLen = length(x);
    bestID = 0;
    bestDist = inf;
    for i = minFrame : min(maxFrame,currLen) % find smallest dist frame
        if x(i) < bestDist
            bestID = i;
            bestDist = x(i);
        end
    end
    if size(fc,1) > 0
        fc(end+1,:) = [fc(end,2) bestID + currID - 1];
    else
        fc(1,:) = [1 bestID + currID - 1];
    end
    currID = currID + bestID - 1;
    minLastFrame = max(minLastFrame,bestID);
    prevCurve = x(1:bestID);
    x = x(bestID:end);

    % make other cuts by matching prevCurve curve to next sub-curve, by
    % finding the closest DTW distance
    while 1 == 1
        currLen = length(x);
        if currLen < minLastFrame % we are done
            break;
        else % make a cut
            bestID = 0;
            bestDist = inf;
            for i = 2 : min(maxFrame * 2,currLen) % find smallest DTW dist
                currCurve = x(1:i);
                currDist = DiscreteFrechetDist(prevCurve',currCurve');
%                 currDist = dtw(prevCurve,currCurve); % dtw does not seem to be as accurate as frechet for this purpose
                if currDist < bestDist
                    bestID = i;
                    bestDist = currDist;
                end
            end
            prevCurve = x(1:bestID);
            fc(end+1) = bestID + currID - 1;
            currID = currID + bestID - 1;
            minLastFrame = max(minLastFrame,bestID);
            x = x(bestID:end);
        end
    end
end