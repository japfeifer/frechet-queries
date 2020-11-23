% function fcNew
%
% 1) find the best cluster center (min sum dist to all sub-seq)
% 2) include sub-seq's that are close to cluster center
% 3) for outliers, try and split sub-seq (they may contain two sub-seq's), otherwise exclude them

function [threshDist,meanDist,numKeepSubSeq,numDiscardSubSeq,numDStart,numDEnd,fcNew,fcDiscard] = GetClusterSubSeq(fc,seq)

    if size(fc,1) == 1
        threshDist = 0;
        meanDist = 0;
        numKeepSubSeq = 1;
        numDiscardSubSeq = 0;
        numDStart = 0;
        numDEnd = 0;
        fcNew = [fc(1,:) 0];
        fcDiscard = [];
    else
        
        numKeepSubSeq = 0;
        numDiscardSubSeq = 0;
        numDStart = 0;
        numDEnd = 0;

        % 1) find the best cluster center
        [fcTmp,bestTotDist] = GetBestSeqCluster(fc,seq);

        % compute a dist to include/exclude sub-seq's
        fcTmp2 = fcTmp;
        fcTmp2 = sortrows(fcTmp2,[4]); % sort by dist
        r = iqr(fcTmp2(2:end,4)); % interquartile range
        iqrIdx = floor(0.75 * (size(fcTmp2,1) - 1)); % index at 75% quartile
        if iqrIdx == 0
            iqrIdx = 1;
        end
        skew = fcTmp2(iqrIdx,4) / r / 2;
        threshDist1 = fcTmp2(iqrIdx,4) + (r * skew);
        meanDist = mean(fcTmp2(2:end,4));
        threshDist2 = meanDist * 2; 
        threshDist = (threshDist1 + threshDist2) / 2;

        fcNew = [];
        fcDiscard = [];
        P = seq(fcTmp2(1,2):fcTmp2(1,3) , :); % cluster center curve
        for i = 1:size(fcTmp,1)
            if fcTmp(i,4) < meanDist
                % 2) include sub-seq's that are close to cluster center
                numKeepSubSeq = numKeepSubSeq + 1;
                fcNew(end+1,:) = fcTmp(i,2:4);
            elseif fcTmp(i,4) > threshDist
                % 3) for outliers, try and split sub-seq
                bestTotDist = Inf;
                bestDist1 = Inf;
                bestDist2 = Inf;
                bestCutFrame = 0;
                frameStart = fcTmp(i,2);
                frameEnd = fcTmp(i,3);
                for j = frameStart + 1 : frameEnd - 1
                    Q1 = seq(frameStart:j , :); 
                    Q2 = seq(j:frameEnd , :); 
                    curDist1 = DiscreteFrechetDist(P,Q1);
                    curDist2 = DiscreteFrechetDist(P,Q2);
                    if curDist1 + curDist2 < bestTotDist
                        bestTotDist = curDist1 + curDist2;
                        bestDist1 = curDist1;
                        bestDist2 = curDist2;
                        bestCutFrame = j;
                    end
                end
                keep1 = 0; keep2 = 0;
                if bestDist1 < threshDist && bestCutFrame - frameStart + 1 > 15 % include this cut within the sub-seq
                    fcNew(end+1,:) = [frameStart bestCutFrame bestDist1];
                    numKeepSubSeq = numKeepSubSeq + 1;
                    keep1 = 1;
                end
                if bestDist2 < threshDist && frameEnd - bestCutFrame + 1 > 15 % include this cut within the sub-seq
                    fcNew(end+1,:) = [bestCutFrame frameEnd bestDist2];
                    numKeepSubSeq = numKeepSubSeq + 1;
                    keep2 = 1;
                end
                if keep1 == 0 && keep2 == 1
                    fcDiscard(end+1,:) = [frameStart bestCutFrame bestDist1];
                elseif keep1 == 1 && keep2 == 0
                    fcDiscard(end+1,:) = [bestCutFrame frameEnd bestDist2];
                elseif keep1 == 0 && keep2 == 0 % this sub-seq is discarded
                    fcDiscard(end+1,:) = [frameStart frameEnd fcTmp(i,4)];
                    numDiscardSubSeq = numDiscardSubSeq + 1;
                    if i == 1
                        numDStart = numDStart + 1;
                    elseif i == size(fcTmp,1)
                        numDEnd = numDEnd + 1;
                    end
                end
            else 
                bestTotDist = Inf;
                bestDist1 = Inf;
                bestDist2 = Inf;
                bestCutFrame = 0;
                frameStart = fcTmp(i,2);
                frameEnd = fcTmp(i,3);
                for j = frameStart + 1 : frameEnd - 1
                    Q1 = seq(frameStart:j , :); 
                    Q2 = seq(j:frameEnd , :); 
                    curDist1 = DiscreteFrechetDist(P,Q1);
                    curDist2 = DiscreteFrechetDist(P,Q2);
                    if curDist1 + curDist2 < bestTotDist
                        bestTotDist = curDist1 + curDist2;
                        bestDist1 = curDist1;
                        bestDist2 = curDist2;
                        bestCutFrame = j;
                    end
                end
                if bestDist1 < fcTmp(i,4) && bestDist2 < fcTmp(i,4) % include the two cuts within the sub-seq
                    fcNew(end+1,:) = [frameStart bestCutFrame bestDist1];
                    fcNew(end+1,:) = [bestCutFrame frameEnd bestDist2];
                    numKeepSubSeq = numKeepSubSeq + 2;
                elseif fcTmp(i,4) < threshDist
                    fcNew(end+1,:) = fcTmp(i,2:4);
                    numKeepSubSeq = numKeepSubSeq + 1;
                else
                    fcDiscard(end+1,:) = [frameStart frameEnd fcTmp(i,4)];
                    numDiscardSubSeq = numDiscardSubSeq + 1;
                end

            end
        end

        fcNew = sortrows(fcNew,[1]);
    
    end
    
end
